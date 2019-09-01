//*****************************************************************************
//
// Copyright (c) 2019 LucAce
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//
//*****************************************************************************
//
// File:  regs.v
// Date:  Sun Aug 18 12:00:00 EDT 2019
// Title: Registers
//
// Functional Description:
//
//   Device registers.
//
// Notes:
//
//   - Timing registers can only be written to when the ENABLED is 0 or when
//     the FIFO is empty.  Writing the timing registers when ENABLED is 1 and
//     the FIFO is not empty will result in a write error and the write will
//     will be ignored.
//
//*****************************************************************************

`timescale 1ns/1ps

module regs (
    input  wire         CLK,                 // Clock
    input  wire         RST_N,               // Reset (Active Low)

    input  wire         REGS_WE,             // Register Write Enable
    input  wire [7:0]   REGS_ADDR,           // Register Address
    input  wire [7:0]   REGS_WDATA,          // Register Write Data
    output reg  [7:0]   REGS_RDATA,          // Register Read Data

    input  wire         FIFO_ALMOST_FULL,    // FIFO Almost Full Flag
    input  wire         FIFO_ALMOST_EMPTY,   // FIFO Almost Empty Flag
    input  wire         FIFO_FULL,           // FIFO Full Flag
    input  wire         FIFO_EMPTY,          // FIFO Empty Flag

    input  wire         FIFO_OVERFLOW,       // FIFO Overflow Flag
    input  wire         FIFO_UNDERFLOW,      // FIFO Underflow Flag

    output wire         ERROR,               // Error Flag

    output wire         ENABLE,              // Serial Out Enable
    output wire         MODE,                // Serial Out Mode
    output wire [7:0]   FORMAT,              // Serial Out Format
    output wire         RUN,                 // Serial Out Run/Stop

    output wire [9:0]   AFULL_THRESH,        // FIFO Almost Full Threshold
    output wire [9:0]   AEMPTY_THRESH,       // FIFO Almost Empty Threshold

    output reg  [7:0]   STATUS_REGISTER,     // Status Register
    output wire [7:0]   ZERO_HIGH_TIMING,    // Zero High Timing
    output wire [7:0]   ZERO_LOW_TIMING,     // Zero Low Timing
    output wire [7:0]   ONE_HIGH_TIMING,     // One High Timing
    output wire [7:0]   ONE_LOW_TIMING,      // One Low Timing
    output wire [7:0]   RESET_CYCLE_TIMING,  // Reset Cycle Timing
    output wire [7:0]   RESET_CODE_TIMING,   // Reset Code Timing

    output wire [1:0]   GPO,                 // General Purpose Outputs
    output wire [1:0]   GPO_OE               // General Purpose Output Enables
);

    //*************************************************************************
    // Signal Definition
    //*************************************************************************

    // Smallest timing register value
    localparam      MIN_TIMING = 5;

    // Status Register
    wire [7:0]      status_reg;

    // Status Register Fields
    reg             write_error;
    reg             overflow_reg;
    reg             underflow_reg;

    // Configuration  Register Fields
    reg             mode_reg;
    reg             enable_reg;

    // Format Register
    reg  [7:0]      format_reg;

    // Almost Full Threshold Register
    reg  [9:0]      afull_thresh_reg;

    // Almost Empty Threshold Register
    reg  [9:0]      aempty_thresh_reg;

    // Zero High Timing Register
    reg  [7:0]      zero_high_timing_reg;

    // Zero Low Timing Register
    reg  [7:0]      zero_low_timing_reg;

    // One High Timing Register
    reg  [7:0]      one_high_timing_reg;

    // One Low Timing Register
    reg  [7:0]      one_low_timing_reg;

    // Reset Cycle Timing Register
    reg  [7:0]      reset_cycle_timing_reg;

    // Reset Code Timing Register
    reg  [7:0]      reset_code_timing_reg;

    // Run / Stop Register Field
    reg             run_reg;

    // General Purpose Outputs
    reg  [1:0]      gpo_reg;
    reg  [1:0]      gpo_oe_reg;

    // Scratch Pad Registers
    reg  [7:0]      scratch_pad_1_reg;
    reg  [7:0]      scratch_pad_2_reg;
    reg  [7:0]      scratch_pad_3_reg;
    reg  [7:0]      scratch_pad_4_reg;


    //*************************************************************************
    // Concurrent Output Assignments
    //*************************************************************************

    assign ERROR              = (overflow_reg | underflow_reg | write_error);

    assign ENABLE             = enable_reg;
    assign MODE               = mode_reg;
    assign FORMAT             = format_reg;
    assign RUN                = run_reg;

    assign AFULL_THRESH       = afull_thresh_reg;
    assign AEMPTY_THRESH      = aempty_thresh_reg;

    assign ZERO_HIGH_TIMING   = zero_high_timing_reg;
    assign ZERO_LOW_TIMING    = zero_low_timing_reg;
    assign ONE_HIGH_TIMING    = one_high_timing_reg;
    assign ONE_LOW_TIMING     = one_low_timing_reg;
    assign RESET_CYCLE_TIMING = reset_cycle_timing_reg;
    assign RESET_CODE_TIMING  = reset_code_timing_reg;

    assign GPO                = gpo_reg;
    assign GPO_OE             = gpo_oe_reg;

    assign status_reg         = { 1'b0, write_error, overflow_reg,
                                  underflow_reg, FIFO_ALMOST_FULL,
                                  FIFO_ALMOST_EMPTY, FIFO_FULL, FIFO_EMPTY };


    //*************************************************************************
    // Registered Outputs
    //*************************************************************************
    always @(posedge CLK or negedge RST_N) begin
        if (RST_N == 1'b0) begin
            STATUS_REGISTER <= 8'h00;
        end
        else begin
            STATUS_REGISTER <= status_reg;
        end
    end


    //*************************************************************************
    // Register State Machine
    //*************************************************************************
    always @(posedge CLK or negedge RST_N) begin
        if (RST_N == 1'b0) begin
            // Read Data
            REGS_RDATA              <= 8'h0;

            // Reg 0x00
            write_error             <= 1'b0;
            overflow_reg            <= 1'b0;
            underflow_reg           <= 1'b0;

            // Reg 0x01
            enable_reg              <= 1'b1;
            mode_reg                <= 1'b0;

            // Reg 0x02
            format_reg              <= 8'hA7;

            // Reg 0x03, 0x04 (~90%)
            afull_thresh_reg        <= 10'h399;

            // Reg 0x05, 0x06 (~10%)
            aempty_thresh_reg       <= 10'h067;

            // Reg 0x07 (14)
            zero_high_timing_reg    <= 8'h10;

            // Reg 0x08 (31)
            zero_low_timing_reg     <= 8'h24;

            // Reg 0x09 (27)
            one_high_timing_reg     <= 8'h20;

            // Reg 0x0A (23)
            one_low_timing_reg      <= 8'h1B;

            // Reg 0x0B (45)
            reset_cycle_timing_reg  <= 8'h34;

            // Reg 0x0C (18)
            reset_code_timing_reg   <= 8'h12;

            // Reg 0x0D
            run_reg                 <= 1'b1;

            // Reg 0xF0
            gpo_reg                 <= 2'b00;

            // Reg 0xF1
            gpo_oe_reg              <= 2'b00;

            // Reg 0xF2, 0xF3, 0xF4, 0xF5
            scratch_pad_1_reg       <= 8'h00;
            scratch_pad_2_reg       <= 8'h00;
            scratch_pad_3_reg       <= 8'h00;
            scratch_pad_4_reg       <= 8'h00;
        end
        else begin
            if (FIFO_OVERFLOW == 1'b1)
                overflow_reg <= 1'b1;

            if (FIFO_UNDERFLOW == 1'b1)
                underflow_reg <= 1'b1;

            //*****************************************************************
            // Register Write
            //*****************************************************************
            if (REGS_WE == 1'b1) begin
                case (REGS_ADDR)
                    // Reg 0x00: Status Register
                    8'h00: begin
                        if (REGS_WDATA[6] == 1'b1)
                            write_error   <= 1'b0;
                        if (REGS_WDATA[5] == 1'b1)
                            overflow_reg  <= 1'b0;
                        if (REGS_WDATA[4] == 1'b1)
                            underflow_reg <= 1'b0;
                    end
                    // Reg 0x01: Configuration Register
                    8'h01: begin
                        mode_reg   <= REGS_WDATA[1];
                        enable_reg <= REGS_WDATA[0];
                    end
                    // Reg 0x02: Format
                    8'h02: begin
                        format_reg <= REGS_WDATA;
                    end
                    // Reg 0x03: Almost Full Threshold MSB
                    8'h03: begin
                        afull_thresh_reg[9:8] <= REGS_WDATA[1:0];
                    end
                    // Reg 0x04: Almost Full Threshold LSB
                    8'h04: begin
                        afull_thresh_reg[7:0] <= REGS_WDATA;
                    end
                    // Reg 0x05: Almost Empty Threshold MSB
                    8'h05: begin
                        aempty_thresh_reg[9:8] <= REGS_WDATA[1:0];
                    end
                    // Reg 0x06: Almost Empty Threshold LSBs
                    8'h06: begin
                        aempty_thresh_reg[7:0] <= REGS_WDATA;
                    end
                    // Reg 0x07: Zero High Timing
                    8'h07: begin
                        if ((enable_reg == 1'b0) || (FIFO_EMPTY == 1'b1)) begin
                            if (REGS_WDATA >= MIN_TIMING)
                                zero_high_timing_reg <= REGS_WDATA;
                            else
                                zero_high_timing_reg <= MIN_TIMING;
                        end
                        else begin
                            write_error <= 1'b1;
                        end
                    end
                    // Reg 0x08: Zero Low Timing
                    8'h08: begin
                        if ((enable_reg == 1'b0) || (FIFO_EMPTY == 1'b1)) begin
                            if (REGS_WDATA >= MIN_TIMING)
                                zero_low_timing_reg <= REGS_WDATA;
                            else
                                zero_low_timing_reg <= MIN_TIMING;
                        end
                        else begin
                            write_error <= 1'b1;
                        end
                    end
                    // Reg 0x09: One High Timing
                    8'h09: begin
                        if ((enable_reg == 1'b0) || (FIFO_EMPTY == 1'b1)) begin
                            if (REGS_WDATA >= MIN_TIMING)
                                one_high_timing_reg <= REGS_WDATA;
                            else
                                one_high_timing_reg <= MIN_TIMING;
                        end
                        else begin
                            write_error <= 1'b1;
                        end
                    end
                    // Reg 0x0A: One Low Timing
                    8'h0A: begin
                        if ((enable_reg == 1'b0) || (FIFO_EMPTY == 1'b1)) begin
                            if (REGS_WDATA >= MIN_TIMING)
                                one_low_timing_reg <= REGS_WDATA;
                            else
                                one_low_timing_reg <= MIN_TIMING;
                        end
                        else begin
                            write_error <= 1'b1;
                        end
                    end
                    // Reg 0x0B: Reset Cycle Timing
                    8'h0B: begin
                        if ((enable_reg == 1'b0) || (FIFO_EMPTY == 1'b1)) begin
                            if (REGS_WDATA >= MIN_TIMING)
                                reset_cycle_timing_reg <= REGS_WDATA;
                            else
                                reset_cycle_timing_reg <= MIN_TIMING;
                        end
                        else begin
                            write_error <= 1'b1;
                        end
                    end
                    // Reg 0x0C: Reset Code Timing
                    8'h0C: begin
                        if ((enable_reg == 1'b0) || (FIFO_EMPTY == 1'b1)) begin
                            if (REGS_WDATA >= MIN_TIMING)
                                reset_code_timing_reg <= REGS_WDATA;
                            else
                                reset_code_timing_reg <= MIN_TIMING;
                        end
                        else begin
                            write_error <= 1'b1;
                        end
                    end
                    // Reg 0x0D: Run
                    8'h0D: begin
                        run_reg <= REGS_WDATA[0];
                    end
                    // Reg 0xF0: General Purpose Output
                    8'hF0: begin
                        gpo_reg <= REGS_WDATA[1:0];
                    end
                    // Reg 0xF1: General Purpose Output Enables
                    8'hF1: begin
                        gpo_oe_reg <= REGS_WDATA[1:0];
                    end
                    // Reg 0xF2: Scatch Pad 1
                    8'hF2: begin
                        scratch_pad_1_reg <= REGS_WDATA;
                    end
                    // Reg 0xF3: Scatch Pad 2
                    8'hF3: begin
                        scratch_pad_2_reg <= REGS_WDATA;
                    end
                    // Reg 0xF4: Scatch Pad 3
                    8'hF4: begin
                        scratch_pad_3_reg <= REGS_WDATA;
                    end
                    // Reg 0xF5: Scatch Pad 4
                    8'hF5: begin
                        scratch_pad_4_reg <= REGS_WDATA;
                    end
                endcase
            end

            //*****************************************************************
            // Register Read
            //*****************************************************************
            else begin
                REGS_RDATA <= 8'h00;

                case (REGS_ADDR)
                    // Reg 0x00: Status Register
                    8'h00: begin
                        REGS_RDATA <= status_reg;
                    end
                    // Reg 0x01: Configuration Register
                    8'h01: begin
                        REGS_RDATA <= {
                            6'h00,
                            mode_reg,
                            enable_reg
                        };
                    end
                    // Reg 0x02: Format
                    8'h02: begin
                        REGS_RDATA <= format_reg;
                    end
                    // Reg 0x03: Almost Full Threshold MSB
                    8'h03: begin
                        REGS_RDATA <= {6'h00, afull_thresh_reg[9:8]};
                    end
                    // Reg 0x04: Almost Full Threshold LSB
                    8'h04: begin
                        REGS_RDATA <= afull_thresh_reg[7:0];
                    end
                    // Reg 0x05: Almost Empty Threshold MSB
                    8'h05: begin
                        REGS_RDATA <= {6'h00, aempty_thresh_reg[9:8]};
                    end
                    // Reg 0x06: Almost Empty Threshold LSBs
                    8'h06: begin
                        REGS_RDATA <= aempty_thresh_reg[7:0];
                    end
                    // Reg 0x07: Zero High Timing
                    8'h07: begin
                        REGS_RDATA <= zero_high_timing_reg;
                    end
                    // Reg 0x08: Zero Low Timing
                    8'h08: begin
                        REGS_RDATA <= zero_low_timing_reg;
                    end
                    // Reg 0x09: One High Timing
                    8'h09: begin
                        REGS_RDATA <= one_high_timing_reg;
                    end
                    // Reg 0x0A: One Low Timing
                    8'h0A: begin
                        REGS_RDATA <= one_low_timing_reg;
                    end
                    // Reg 0x0B: Reset Cycle Timing
                    8'h0B: begin
                        REGS_RDATA <= reset_cycle_timing_reg;
                    end
                    // Reg 0x0C: Reset Code Timing
                    8'h0C: begin
                        REGS_RDATA <= reset_code_timing_reg;
                    end
                    // Reg 0x0D: Run
                    8'h0D: begin
                        REGS_RDATA <= {7'h00, run_reg};
                    end
                    // Reg 0xF0: General Purpose Outputs
                    8'hF0: begin
                        REGS_RDATA <= {6'h00, gpo_reg};
                    end
                    // Reg 0xF1: General Purpose Output Enables
                    8'hF1: begin
                        REGS_RDATA <= {6'h00, gpo_oe_reg};
                    end
                    // Reg 0xF2: Scatch Pad 1
                    8'hF2: begin
                        REGS_RDATA <= scratch_pad_1_reg;
                    end
                    // Reg 0xF3: Scatch Pad 2
                    8'hF3: begin
                        REGS_RDATA <= scratch_pad_2_reg;
                    end
                    // Reg 0xF4: Scatch Pad 3
                    8'hF4: begin
                        REGS_RDATA <= scratch_pad_3_reg;
                    end
                    // Reg 0xF5: Scatch Pad 4
                    8'hF5: begin
                        REGS_RDATA <= scratch_pad_4_reg;
                    end
                endcase
            end
        end
    end

endmodule
