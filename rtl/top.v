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
// File:  top.v
// Date:  Sun Aug 18 12:00:00 EDT 2019
// Title: Device Top Level
//
// Functional Description:
//
//   Top level verilog module of the design.  It defines the IO and
//   instantiates the subcomponents.
//
// Notes:
//
//   - This design requires an active Slave Select signal.  Without it, the
//     design cannot distinquish between SPI operations.
//
//*****************************************************************************

`timescale 1ns/1ps

module top (
    input  wire         RST_N,              // Reset (Active Low)

    // SPI (On-chip hardened function)
    input  wire         SCLK,               // SPI Slave Clock
    input  wire         SCSN,               // SPI Slave Select (Active Low)
    input  wire         MOSI,               // SPI Slave Master Out Slave In
    output wire         MISO,               // SPI Slave Master In Slave Out

    // LED Data Output
    output wire         LED_OUT,            // LED Data Output

    // Status Output
    output wire         ERROR,              // Error Flag

    // FIFO Status
    output wire         FIFO_AEMPTY,        // LED FIFO Almost Empty
    output wire         FIFO_AFULL,         // LED FIFO Almost Full

    // Support Siganls
    output wire [1:0]   GPO                 // General Purpose Outputs
);

    //*************************************************************************
    // Parameter Definitions
    //*************************************************************************
    parameter       PROTOCOL = 8'h01;       // Protocol Version
    parameter       REVISION = 8'h00;       // Device Revision


    //*************************************************************************
    // Signal Definitions
    //*************************************************************************

    // On-chip clock
    wire            clk;

    // Active High Reset
    wire            rst;

    // Wishbone Master (Controller)
    wire            wbm_cyc_o;
    wire            wbm_stb_o;
    wire            wbm_we_o;
    wire [7:0]      wbm_adr_o;
    wire [7:0]      wbm_dat_o;
    wire [7:0]      wbm_dat_i;
    wire            wbm_ack_i;

    // EFB FIFO
    wire            fifo_reset;
    wire            fifo_re;
    wire [33:0]     fifo_rdata;
    wire            fifo_we;
    wire [33:0]     fifo_wdata;
    wire            fifo_aempty_i;
    wire            fifo_empty_i;
    wire            fifo_afull_i;
    wire            fifo_full_i;
    wire [9:0]      fifo_aempty_thresh;
    wire [9:0]      fifo_afull_thresh;
    wire            fifo_overflow_i;
    wire            fifo_underflow_i;

    // Register values
    wire [7:0]      reg_status;
    wire            reg_enable;
    wire            reg_mode;
    wire [7:0]      reg_format;
    wire            reg_run;
    wire [7:0]      reg_zero_high_timing;
    wire [7:0]      reg_zero_low_timing;
    wire [7:0]      reg_one_high_timing;
    wire [7:0]      reg_one_low_timing;
    wire [7:0]      reg_reset_cycle_timing;
    wire [7:0]      reg_reset_code_timing;
    wire            reg_error;

    // Registers request interface
    wire            regs_we;
    wire [7:0]      regs_addr;
    wire [7:0]      regs_wdata;
    wire [7:0]      regs_rdata;

    // Eod of Frame/Reset
    wire            ctrl_eof;

    // General purpose Outputs
    wire [1:0]      gpo_i;
    wire [1:0]      gpo_oe_i;

    // Serial out signals
    wire            ser_out;


    //*************************************************************************
    // Subcomponent Instatiations
    //*************************************************************************

    // Onboard Clock Instantiation, 44.33 MHZ +/-5%
    OSCH #(
        .NOM_FREQ("44.33")
    )
    internal_oscillator_inst (
        .STDBY              (1'b0                   ),
        .OSC                (clk                    ),
        .SEDSTDBY           (                       )
    );

    // Slave EFB Instantiation
    slave_efb slave_efb_inst (
        .wb_clk_i           (clk                    ),
        .wb_rst_i           (rst                    ),
        .wb_cyc_i           (wbm_cyc_o              ),
        .wb_stb_i           (wbm_stb_o              ),
        .wb_we_i            (wbm_we_o               ),
        .wb_adr_i           (wbm_adr_o              ),
        .wb_dat_i           (wbm_dat_o              ),
        .wb_dat_o           (wbm_dat_i              ),
        .wb_ack_o           (wbm_ack_i              ),

        .spi_clk            (SCLK                   ),
        .spi_miso           (MISO                   ),
        .spi_mosi           (MOSI                   ),
        .spi_scsn           (SCSN                   )
    );

    // FIFO_DC EFB Instantiation
    fifo_dc_efb fifo_dc_efb_inst (
        .Data               (fifo_wdata             ),
        .WrClock            (clk                    ),
        .RdClock            (clk                    ),
        .WrEn               (fifo_we                ),
        .RdEn               (fifo_re                ),
        .Reset              (~reg_enable            ),
        .RPReset            (1'b0                   ),
        .AmEmptyThresh      (fifo_aempty_thresh     ),
        .AmFullThresh       (fifo_afull_thresh      ),
        .Q                  (fifo_rdata             ),
        .Empty              (fifo_empty_i           ),
        .Full               (fifo_full_i            ),
        .AlmostEmpty        (fifo_aempty_i          ),
        .AlmostFull         (fifo_afull_i           )
    );

    // Controller Instantiation
    ctrl #(
        .PROTOCOL           (PROTOCOL               ),
        .REVISION           (REVISION               )
    ) ctrl_inst (
        .CLK                (clk                    ),
        .RST_N              (RST_N                  ),

        .WB_CYC_O           (wbm_cyc_o              ),
        .WB_STB_O           (wbm_stb_o              ),
        .WB_WE_O            (wbm_we_o               ),
        .WB_ADR_O           (wbm_adr_o              ),
        .WB_DAT_O           (wbm_dat_o              ),
        .WB_DAT_I           (wbm_dat_i              ),
        .WB_ACK_I           (wbm_ack_i              ),

        .STATUS_REGISTER    (reg_status             ),

        .REGS_WE            (regs_we                ),
        .REGS_ADDR          (regs_addr              ),
        .REGS_WDATA         (regs_wdata             ),
        .REGS_RDATA         (regs_rdata             ),

        .FIFO_FULL          (fifo_full_i            ),
        .FIFO_WE            (fifo_we                ),
        .FIFO_WDATA         (fifo_wdata             ),

        .FIFO_OVERFLOW      (fifo_overflow_i        ),

        .EOF                (ctrl_eof               )
    );

    // Registers Instantiation
    regs regs_inst (
        .CLK                (clk                    ),
        .RST_N              (RST_N                  ),

        .REGS_WE            (regs_we                ),
        .REGS_ADDR          (regs_addr              ),
        .REGS_WDATA         (regs_wdata             ),
        .REGS_RDATA         (regs_rdata             ),

        .FIFO_ALMOST_FULL   (fifo_afull_i           ),
        .FIFO_ALMOST_EMPTY  (fifo_aempty_i          ),
        .FIFO_FULL          (fifo_full_i            ),
        .FIFO_EMPTY         (fifo_empty_i           ),

        .FIFO_OVERFLOW      (fifo_overflow_i        ),
        .FIFO_UNDERFLOW     (fifo_underflow_i       ),

        .ERROR              (reg_error              ),

        .ENABLE             (reg_enable             ),
        .MODE               (reg_mode               ),
        .FORMAT             (reg_format             ),
        .RUN                (reg_run                ),

        .AFULL_THRESH       (fifo_afull_thresh      ),
        .AEMPTY_THRESH      (fifo_aempty_thresh     ),

        .STATUS_REGISTER    (reg_status             ),
        .ZERO_HIGH_TIMING   (reg_zero_high_timing   ),
        .ZERO_LOW_TIMING    (reg_zero_low_timing    ),
        .ONE_HIGH_TIMING    (reg_one_high_timing    ),
        .ONE_LOW_TIMING     (reg_one_low_timing     ),
        .RESET_CYCLE_TIMING (reg_reset_cycle_timing ),
        .RESET_CODE_TIMING  (reg_reset_code_timing  ),

        .GPO                (gpo_i                  ),
        .GPO_OE             (gpo_oe_i               )
    );

    // Serializer Instantiation
    ser ser_inst(
        .CLK                (clk                    ),
        .RST_N              (RST_N                  ),

        .ENABLE             (reg_enable             ),
        .MODE               (reg_mode               ),
        .FORMAT             (reg_format             ),
        .RUN                (reg_run                ),

        .FIFO_RE            (fifo_re                ),
        .FIFO_RDATA         (fifo_rdata             ),
        .FIFO_EMPTY         (fifo_empty_i           ),
        .FIFO_UNDERFLOW     (fifo_underflow_i       ),

        .EOF                (ctrl_eof               ),

        .ZERO_HIGH_TIMING   (reg_zero_high_timing   ),
        .ZERO_LOW_TIMING    (reg_zero_low_timing    ),
        .ONE_HIGH_TIMING    (reg_one_high_timing    ),
        .ONE_LOW_TIMING     (reg_one_low_timing     ),
        .RESET_CYCLE_TIMING (reg_reset_cycle_timing ),
        .RESET_CODE_TIMING  (reg_reset_code_timing  ),

        .SER_OUT            (ser_out                )
    );


    //*************************************************************************
    // Concurrent Logic
    //*************************************************************************

    // Invert Reset for Active High Reset blocks
    assign rst         = ~RST_N;


    //*************************************************************************
    // Output Tri-States
    //*************************************************************************

    // General Purpose Outputs
    assign GPO[1]      = (gpo_oe_i[1] == 1'b1) ? gpo_i[1] : 1'bZ;
    assign GPO[0]      = (gpo_oe_i[0] == 1'b1) ? gpo_i[0] : 1'bZ;

    // FIFO Status Outputs
    assign FIFO_AEMPTY = (reg_enable == 1'b1) ? fifo_aempty_i : 1'bZ;
    assign FIFO_AFULL  = (reg_enable == 1'b1) ? fifo_afull_i  : 1'bZ;

    // Error Output
    assign ERROR       = (reg_enable == 1'b1) ? reg_error : 1'bZ;

    // Serial Out
    assign LED_OUT     = (reg_enable == 1'b1) ? ser_out : 1'bZ;

endmodule
