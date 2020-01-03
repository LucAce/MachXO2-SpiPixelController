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
// File:  ser.v
// Date:  Sun Aug 18 12:00:00 EDT 2019
// Title: Serializer
//
// Functional Description:
//
//   Serialize the FIFO data in framed LED output.
//
// Notes:
//
//   - Input fbuf Format:
//     [34]:   Mode: 1: RGBW, 0: RGB
//     [33]:   Reset Cycle (Reset for 3 or 4 bytes)
//     [32]:   Reset Code (Full Reset)
//     [31:24] White
//     [23:16] Red
//     [15: 8] Green
//     [ 7: 0] Blue
//
//*****************************************************************************

`timescale 1ns/1ps

module ser (
    input  wire         CLK,                // Clock
    input  wire         RST_N,              // Reset (Active Low)

    input  wire         ENABLE,             // Enable
    input  wire         MODE,               // Operating Mode
    input  wire [7:0]   FORMAT,             // LED output format
    input  wire         RUN,                // Run/Stop

    output reg          FIFO_RE,            // FIFO Read Enable
    input  wire [33:0]  FIFO_RDATA,         // FIFO Read Data
    input  wire         FIFO_EMPTY,         // FIFO Empty
    output reg          FIFO_UNDERFLOW,     // FIFO Underflow

    input  wire         EOF,                // End of Frame

    input  wire [7:0]   ZERO_HIGH_TIMING,   // Zero High Timing
    input  wire [7:0]   ZERO_LOW_TIMING,    // Zero Low Timing
    input  wire [7:0]   ONE_HIGH_TIMING,    // One High Timing
    input  wire [7:0]   ONE_LOW_TIMING,     // One Low Timing
    input  wire [7:0]   RESET_CYCLE_TIMING, // Reset Cycle Timing
    input  wire [7:0]   RESET_CODE_TIMING,  // Reset Code Timing

    output reg          SER_OUT             // Serialized Output
);

    //*************************************************************************
    // Signal Definition
    //*************************************************************************

    // FIFO Read FSM States
    `define S_FR_IDLE       4'b0001
    `define S_FR_READ       4'b0010
    `define S_FR_REORDER    4'b0100
    `define S_FR_VALID      4'b1000

    reg [3:0]       frsm_state;

    // Serial Out FSM States
    `define S_SO_IDLE       4'b0001
    `define S_SO_HIGH_PHASE 4'b0010
    `define S_SO_LOW_PHASE  4'b0100
    `define S_SO_RESET      4'b1000

    reg [3:0]       sosm_state;

    // Buffers
    reg [34:0]      fbuf;
    reg [34:0]      fbuf_run;

    // FIFO FSM Handshake signals
    reg             fbuf_valid;
    reg             fbuf_ready;

    // FSM Counter
    reg [1:0]       frsm_counter;

    // Current transmit bit position
    reg [4:0]       bindex;

    // Toggle Counts
    reg [7:0]       timing_count;
    reg [14:0]      reset_count;

    // Buffer Reset Count
    wire            eof_empty;
    reg             eof_decr;
    reg [10:0]      eof_count;


    //*************************************************************************
    // Number of Resets/EoFs In FIFO
    //*************************************************************************
    assign eof_empty = (eof_count == 11'h000) ? 1'b1 : 1'b0;

    always @(posedge CLK or negedge RST_N) begin
        if (RST_N == 1'b0) begin
            eof_count <= 11'h000;
        end
        else begin
            // Increment Count, Count Not Saturated
            if ( (EOF       == 1'b1) &&
                 (eof_decr  == 1'b0) &&
                 (eof_count <  11'h400) ) begin
                eof_count <= eof_count + 1;
            end
            // Decrement Count, Count Not Zero
            else if ( (EOF       == 1'b0) &&
                      (eof_decr  == 1'b1) &&
                      (eof_count != 11'h000) ) begin
                eof_count <= eof_count - 1;
            end
            // Count Remains Unchanged
            else begin
                eof_count <= eof_count;
            end
        end
    end


    //*************************************************************************
    // FIFO Read Controller State Machine
    //
    // Design Notes:
    // - The fbuf_valid flag will go high until fbuf_ready goes high or
    //   enable goes low.  During that time, the fbuf will remain unchanged
    //   and can be read as needed by the Serial Out state machine.
    //*************************************************************************
    always @(posedge CLK or negedge RST_N) begin
        if (RST_N == 1'b0) begin
            frsm_state   <= `S_FR_IDLE;
            // FIFO Read Enable
            FIFO_RE      <= 1'b0;
            // Buffer Valid (Handshake)
            fbuf_valid   <= 1'b0;
            // FSM state counter
            frsm_counter <= 2'b00;
            // Buffer
            fbuf         <= 35'h0_0000_0000;
        end
        else begin
            FIFO_RE      <= 1'b0;
            fbuf_valid   <= 1'b0;

            case (frsm_state)
                //*************************************************************
                // State: Idle
                // Wait for FIFO read request.
                //*************************************************************
                `S_FR_IDLE: begin
                    // Initialize Counter
                    frsm_counter <= 2'b01;

                    // Get next buffer if FIFO is not empty
                    if ((ENABLE == 1'b1) && (FIFO_EMPTY == 1'b0)) begin
                        FIFO_RE    <= 1'b1;
                        frsm_state <= `S_FR_READ;
                    end
                    else begin
                        frsm_state <= `S_FR_IDLE;
                    end
                end

                //*************************************************************
                // State: Read FIFO
                // Register FIFO_RDATA after appropriate delay.
                //*************************************************************
                `S_FR_READ: begin
                    if (frsm_counter == 2'b00) begin
                        fbuf         <= {1'b0, FIFO_RDATA};
                        frsm_state   <= `S_FR_REORDER;
                    end
                    else begin
                        frsm_counter <= frsm_counter - 1;
                        frsm_state   <= `S_FR_READ;
                    end
                end

                //*************************************************************
                // State: Reorder
                // Wait for ready.
                //*************************************************************
                `S_FR_REORDER: begin
                    // Flag bits remain unchanged
                    fbuf[33:32] <= fbuf[33:32];

                    // If White Format is equal to Red Format, then
                    // only transmit 3 LEDs, ie white not present
                    if (FORMAT[7:6] == FORMAT[5:4])
                        fbuf[34] <= 1'b0;
                    else
                        fbuf[34] <= 1'b1;

                    // Byte 1/If present (MSB)
                    case (FORMAT[7:6])
                        2'b00: fbuf[31:24] <= fbuf[31:24];  // White
                        2'b01: fbuf[31:24] <= fbuf[23:16];  // Red
                        2'b10: fbuf[31:24] <= fbuf[15: 8];  // Green
                        2'b11: fbuf[31:24] <= fbuf[ 7: 0];  // Blue
                    endcase

                    // Byte 2
                    case (FORMAT[5:4])
                        2'b00: fbuf[23:16] <= fbuf[31:24];  // White
                        2'b01: fbuf[23:16] <= fbuf[23:16];  // Red
                        2'b10: fbuf[23:16] <= fbuf[15: 8];  // Green
                        2'b11: fbuf[23:16] <= fbuf[ 7: 0];  // Blue
                    endcase

                    // Byte 3
                    case (FORMAT[3:2])
                        2'b00: fbuf[15: 8] <= fbuf[31:24];  // White
                        2'b01: fbuf[15: 8] <= fbuf[23:16];  // Red
                        2'b10: fbuf[15: 8] <= fbuf[15: 8];  // Green
                        2'b11: fbuf[15: 8] <= fbuf[ 7: 0];  // Blue
                    endcase

                    // Byte 4 (LSB)
                    case (FORMAT[1:0])
                        2'b00: fbuf[ 7: 0] <= fbuf[31:24];  // White
                        2'b01: fbuf[ 7: 0] <= fbuf[23:16];  // Red
                        2'b10: fbuf[ 7: 0] <= fbuf[15: 8];  // Green
                        2'b11: fbuf[ 7: 0] <= fbuf[ 7: 0];  // Blue
                    endcase

                    fbuf_valid <= 1'b1;
                    frsm_state <= `S_FR_VALID;
                end

                //*************************************************************
                // State: Valid
                // Data is valid, wait for ready.
                //*************************************************************
                `S_FR_VALID: begin
                    fbuf_valid <= 1'b1;

                    if ((fbuf_ready == 1'b1) || (ENABLE == 1'b0)) begin
                        fbuf_valid <= 1'b0;
                        frsm_state <= `S_FR_IDLE;
                    end
                    else begin
                        frsm_state <= `S_FR_VALID;
                    end
                end

                //*************************************************************
                // State: Default
                // All other values of frsm_state.  Not synthesized.
                //*************************************************************
                default: begin
                    frsm_state <= `S_FR_IDLE;
                end
            endcase
        end
    end


    //*************************************************************************
    // Serial Output FSM
    //*************************************************************************
    always @(posedge CLK or negedge RST_N) begin
        if (RST_N == 1'b0) begin
            sosm_state              <= `S_SO_IDLE;

            // Reset Under Flow Flag
            FIFO_UNDERFLOW          <= 1'b0;

            // Reset Serial Output
            SER_OUT                 <= 1'b0;

            // Reset Processing Values
            bindex                  <= 5'h00;
            timing_count            <= 8'h00;
            reset_count             <= 15'h0000;

            // Reset SO FSM Buffer Values, Flags
            fbuf_ready              <= 1'b0;
            fbuf_run                <= 35'h0_0000_0000;

            // Reset Count Decrement
            eof_decr                <= 1'b0;
        end
        else begin
            FIFO_UNDERFLOW          <= 1'b0;
            SER_OUT                 <= 1'b0;
            fbuf_ready              <= 1'b0;
            eof_decr                <= 1'b0;

            case (sosm_state)
                //*************************************************************
                // State: Idle
                // Wait for next buffer.
                //*************************************************************
                `S_SO_IDLE: begin
                    if ( (RUN == 1'b1) && (fbuf_valid == 1'b1) &&
                         (((eof_empty == 1'b0) && (MODE == 1'b0)) || (MODE == 1'b1)) ) begin
                        // Reset Code
                        if      (fbuf[32] == 1'b1) begin
                            eof_decr    <= 1'b1;
                            reset_count <= {RESET_CODE_TIMING[7:0], 7'h00} - 1;
                            sosm_state  <= `S_SO_RESET;
                        end
                        // Reset Cycle
                        else if (fbuf[33] == 1'b1) begin
                            eof_decr    <= 1'b1;
                            reset_count <= {7'h00, RESET_CYCLE_TIMING[7:0]} - 1;
                            sosm_state  <= `S_SO_RESET;
                        end
                        // 4 Color/bytes, MSB is 1, Start at bit 31
                        else if ((fbuf[34] == 1'b1) && (fbuf[31] == 1'b1)) begin
                            timing_count <= ONE_HIGH_TIMING - 1;
                            bindex       <= 5'h1F;
                            sosm_state   <= `S_SO_HIGH_PHASE;
                        end
                        // 4 Color/bytes, MSB is 0, Start at bit 31
                        else if ((fbuf[34] == 1'b1) && (fbuf[31] == 1'b0)) begin
                            timing_count <= ZERO_HIGH_TIMING - 1;
                            bindex       <= 5'h1F;
                            sosm_state   <= `S_SO_HIGH_PHASE;
                        end
                        // 3 Color/bytes, MSB is 1, Start at bit 23
                        else if ((fbuf[34] == 1'b0) && (fbuf[23] == 1'b1)) begin
                            timing_count <= ONE_HIGH_TIMING - 1;
                            bindex       <= 5'h17;
                            sosm_state   <= `S_SO_HIGH_PHASE;
                        end
                        // 3 Color/bytes, MSB is 0, Start at bit 23
                        else begin
                            timing_count <= ZERO_HIGH_TIMING - 1;
                            bindex       <= 5'h17;
                            sosm_state   <= `S_SO_HIGH_PHASE;
                        end

                        // Store buffer locally
                        fbuf_ready <= 1'b1;
                        fbuf_run   <= fbuf;
                    end
                    else begin
                        sosm_state <= `S_SO_IDLE;
                    end
                end

                //*************************************************************
                // State: High Phase
                // Serial Out High Phase of Output
                //*************************************************************
                `S_SO_HIGH_PHASE: begin
                    SER_OUT <= 1'b1;

                    if (timing_count > 8'h00) begin
                        timing_count <= timing_count - 1;
                        sosm_state   <= `S_SO_HIGH_PHASE;
                    end
                    else begin
                        if (fbuf_run[bindex] == 1'b1)
                            timing_count <= ONE_LOW_TIMING - 1;
                        else
                            timing_count <= ZERO_LOW_TIMING - 1;

                        sosm_state <= `S_SO_LOW_PHASE;
                    end
                end

                //*************************************************************
                // State: Low Phase
                // Serial Out Low Phase of Output
                //*************************************************************
                `S_SO_LOW_PHASE : begin
                    SER_OUT <= 1'b0;

                    // Decrement count and stay in this state
                    if (timing_count > 8'h00) begin
                        timing_count <= timing_count - 1;
                        sosm_state   <= `S_SO_LOW_PHASE;
                    end
                    // Get the next WRGB/RGB buffer value if there is no EOF.
                    // This occurs one cycle early to give time to the idle
                    // state to register and start the next buffer value.
                    else if ( (bindex     == 0) &&
                              (fbuf_valid == 1'b1) ) begin
                        // Reset Code
                        if      (fbuf[32] == 1'b1) begin
                            eof_decr    <= 1'b1;
                            reset_count <= {RESET_CODE_TIMING[7:0], 7'h00} - 1;
                            sosm_state  <= `S_SO_RESET;
                        end
                        // Reset Cycle
                        else if (fbuf[33] == 1'b1) begin
                            eof_decr    <= 1'b1;
                            reset_count <= {7'h00, RESET_CYCLE_TIMING[7:0]} - 1;
                            sosm_state  <= `S_SO_RESET;
                        end
                        // 4 Color/bytes, MSB is 1, Start at bit 31
                        else if ((fbuf[34] == 1'b1) && (fbuf[31] == 1'b1)) begin
                            timing_count <= ONE_HIGH_TIMING - 1;
                            bindex       <= 5'h1F;
                            sosm_state   <= `S_SO_HIGH_PHASE;
                        end
                        // 4 Color/bytes, MSB is 0, Start at bit 31
                        else if ((fbuf[34] == 1'b1) && (fbuf[31] == 1'b0)) begin
                            timing_count <= ZERO_HIGH_TIMING - 1;
                            bindex       <= 5'h1F;
                            sosm_state   <= `S_SO_HIGH_PHASE;
                        end
                        // 3 Color/bytes, MSB is 1, Start at bit 23
                        else if ((fbuf[34] == 1'b0) && (fbuf[23] == 1'b1)) begin
                            timing_count <= ONE_HIGH_TIMING - 1;
                            bindex       <= 5'h17;
                            sosm_state   <= `S_SO_HIGH_PHASE;
                        end
                        // 3 Color/bytes, MSB is 0, Start at bit 23
                        else begin
                            timing_count <= ZERO_HIGH_TIMING - 1;
                            bindex       <= 5'h17;
                            sosm_state   <= `S_SO_HIGH_PHASE;
                        end

                        // Store buffer locally
                        fbuf_ready <= 1'b1;
                        fbuf_run   <= fbuf;
                    end
                    // Execute a Reset Code if last bit and nothing in buffer
                    // Do not decrement the reset count because this reset
                    // code is not due to a command but rather an underrun
                    else if ( (bindex     == 0) &&
                              (fbuf_valid == 1'b0) ) begin
                        FIFO_UNDERFLOW <= 1'b1;
                        reset_count    <= {RESET_CODE_TIMING[7:0], 7'h00} - 1;
                        sosm_state     <= `S_SO_RESET;
                    end
                    // If this is not the last bit go to the next pixel
                    else begin
                        if (fbuf_run[bindex-1] == 1'b1)
                            timing_count <= ONE_HIGH_TIMING - 1;
                        else
                            timing_count <= ZERO_HIGH_TIMING - 1;

                        bindex     <= bindex - 1;
                        sosm_state <= `S_SO_HIGH_PHASE;
                    end
                end

                //*************************************************************
                // State: Reset Code
                // Full Reset
                //*************************************************************
                `S_SO_RESET: begin
                    SER_OUT <= 1'b0;

                    // Stay in reset until a count of 1 then go to idle.
                    // The one extra cycle allows for the next buffer
                    // to be started in the idle state.
                    if (reset_count > 15'h0001) begin
                        reset_count <= reset_count - 1;
                        sosm_state  <= `S_SO_RESET;
                    end
                    else begin
                        sosm_state  <= `S_SO_IDLE;
                    end
                end

                //*************************************************************
                // State: Default
                // All other values of frsm_state.  Not synthesized.
                //*************************************************************
                default: begin
                    sosm_state <= `S_SO_IDLE;
                end
            endcase
        end
    end

endmodule
