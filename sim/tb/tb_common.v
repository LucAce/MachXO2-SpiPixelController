//*****************************************************************************
//
// Copyright (c) 2019-2020 LucAce
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
// File:  tb_common.v
// Date:  Sun Aug 18 12:00:00 EDT 2019
//
// Functional Description:
//
//   Common test bench tasks and functions.  All other test bench files
//   include this one using `include.
//
//*****************************************************************************


    //*************************************************************************
    // Parameter Definitions
    //*************************************************************************
    parameter FPGA_REVISION   = 8'h03;                  // Expected Revision

    parameter SPI_HALF_PERIOD = 25;                     // 20Mhz
    parameter SPI_DELAY       = 32*SPI_HALF_PERIOD;     // 8 SPI Clocks
    parameter SPI_CSN_DELAY   = 5;

    // SPI Commands
    `define SPI_CMD_PROTOCOL         8'hF0
    `define SPI_CMD_REVISION         8'hF1
    `define SPI_CMD_REG_READ         8'h00
    `define SPI_CMD_REG_WRITE        8'h01
    `define SPI_CMD_LOAD_RGB         8'h04
    `define SPI_CMD_LOAD_WRGB        8'h05
    `define SPI_CMD_LOAD_RESET_CYCLE 8'h06
    `define SPI_CMD_LOAD_RESET_CODE  8'h07


    //*************************************************************************
    // Signal Definitions
    //*************************************************************************
    reg         rst_n;
    reg         sclk;
    reg         scsn;
    reg         mosi;
    wire        miso;
    wire        led_out;
    wire        error;
    wire        fifo_aempty;
    wire        fifo_afull;
    wire [1:0]  gpo;

    reg  [7:0]  bytetx [0:31];
    reg  [7:0]  byterx [0:31];
    reg  [7:0]  bytecount;
    reg  [7:0]  i;

    //*************************************************************************
    // DUT Instantiation
    //*************************************************************************

    // Instantiate GSR & PUR
    GSR GSR_INST (.GSR (1'b1));
    PUR PUR_INST (.PUR (1'b1));

    top dut(
        .RST_N          (rst_n       ),
        .SCLK           (sclk        ),
        .SCSN           (scsn        ),
        .MOSI           (mosi        ),
        .MISO           (miso        ),
        .LED_OUT        (led_out     ),
        .ERROR          (error       ),
        .FIFO_AEMPTY    (fifo_aempty ),
        .FIFO_AFULL     (fifo_afull  ),
        .GPO            (gpo         )
    );


    //*************************************************************************
    // TB Tasks
    //*************************************************************************

    // SPI Command
    task spi_cmd;
        integer i;
        integer j;
    begin
        for (i=0; i<32; i=i+1) begin
            byterx[i] = 8'h00;
        end

        mosi = 1'b1;
        scsn = 1'b1;
        #SPI_HALF_PERIOD;
        scsn  = 1'b0;
        mosi = 1'b0;

        for (i=0; i<SPI_CSN_DELAY; i=i+1) begin
            #SPI_HALF_PERIOD;
        end

        for (i=0; i<bytecount; i=i+1) begin
            for (j=0; j<8; j=j+1) begin
                sclk = 1'b0;
                mosi = bytetx[i][7-j];
                #SPI_HALF_PERIOD;
                byterx[i][7-j] = miso;
                sclk = 1'b1;
                #SPI_HALF_PERIOD;
            end
        end

        sclk = 1'b0;
        #SPI_HALF_PERIOD;
        for (i=0; i<SPI_CSN_DELAY; i=i+1) begin
            #SPI_HALF_PERIOD;
        end
        scsn = 1'b1;

        #SPI_DELAY;
        mosi = 1'b1;
    end
    endtask

    // Command Protocol
    // 1 Command Byte; 1 Dummy Byte; 1 Data Byte
    task cmd_protocol;
        integer i;
    begin
        for (i=0; i<32; i=i+1) begin
            bytetx[i] = 8'h00;
        end

        bytetx[0] = `SPI_CMD_PROTOCOL;
        bytecount = 3;

        spi_cmd();
        if (byterx[2] == 8'h01)
            $display("Reported Protocol: 0x%02h", byterx[2]);
        else
            $error("Error: Reported Protocol: 0x%02h", byterx[2]);
    end
    endtask


    // Command Protocol
    // 1 Command Byte; 1 Dummy Byte; 1 Data Byte
    task cmd_revision;
        integer i;
    begin
        for (i=0; i<32; i=i+1) begin
            bytetx[i] = 8'h00;
        end

        bytetx[0] = `SPI_CMD_REVISION;
        bytecount = 3;

        spi_cmd();
        if (byterx[2] == FPGA_REVISION)
            $display("Reported Revision: 0x%02h", byterx[2]);
        else
            $display("Error: Reported Revision: 0x%02h", byterx[2]);
    end
    endtask

    // Register Read
    // 1 Command Byte; 1 Address Byte; 1 Dummy Byte; 1+ Data Byte
    task cmd_reg_read;
        input [7:0] addr;
        integer i;
    begin
        for (i=0; i<32; i=i+1) begin
            bytetx[i] = 8'h00;
        end

        bytetx[0] = `SPI_CMD_REG_READ;
        bytetx[1] = addr;
        bytecount = 4;

        spi_cmd();
        $display("Register Read 0x%02h: 0x%02h", bytetx[1], byterx[3]);
    end
    endtask

    // Register Read and Verify
    // 1 Command Byte; 1 Address Byte; 1 Dummy Byte; 1+ Data Byte
    task cmd_reg_verify;
        input [7:0] addr;
        input [7:0] expected;
        integer i;
    begin
        for (i=0; i<32; i=i+1) begin
            bytetx[i] = 8'h00;
        end

        bytetx[0] = `SPI_CMD_REG_READ;
        bytetx[1] = addr;
        bytecount = 4;

        spi_cmd();

        if (byterx[3] == expected) begin
            $display("Register Observed Matched Expected:");
            $display("  Address: 0x%02h", addr);
            $display("  Data:    0x%02h", expected);
        end
        else begin
            $error("");
            $display("Register Observed Did Not Matched Expected:");
            $display("  Address:  0x%02h", addr);
            $display("  Observed: 0x%02h", byterx[3]);
            $display("  Expected: 0x%02h", expected);
        end
    end
    endtask

    // Register Write
    // 1 Command Byte; 1 Address Byte; 1+ Data Bytes
    task cmd_reg_write;
        input [7:0] addr;
        input [7:0] data;
        integer i;
    begin
        for (i=0; i<32; i=i+1) begin
            bytetx[i] = 8'h00;
        end

        bytetx[0] = `SPI_CMD_REG_WRITE;
        bytetx[1] = addr;
        bytetx[2] = data;
        bytecount = 3;

        spi_cmd();
        $display("Register Write 0x%02h: 0x%02h", bytetx[1], bytetx[2]);
    end
    endtask

    // Load RGB
    // 1 Command Byte; 1+ Data Bytes
    task cmd_load_rgb;
        input [7:0] b1;
        input [7:0] b2;
        input [7:0] b3;
        integer     i;
    begin
        for (i=0; i<32; i=i+1) begin
            bytetx[i] = 8'h00;
        end

        bytetx[0] = `SPI_CMD_LOAD_RGB;
        bytetx[1] = b1;
        bytetx[2] = b2;
        bytetx[3] = b3;
        bytecount = 4;

        spi_cmd();
        $display("Load RGB: 0x%02h 0x%02h 0x%02h", bytetx[1], bytetx[2], bytetx[3]);
    end
    endtask

    // Load WRGB
    // 1 Command Byte; 1+ Data Bytes
    task cmd_load_wrgb;
        input [7:0] b1;
        input [7:0] b2;
        input [7:0] b3;
        input [7:0] b4;
        integer     i;
    begin
        for (i=0; i<32; i=i+1) begin
            bytetx[i] = 8'h00;
        end

        bytetx[0] = `SPI_CMD_LOAD_WRGB;
        bytetx[1] = b1;
        bytetx[2] = b2;
        bytetx[3] = b3;
        bytetx[4] = b4;
        bytecount = 5;

        spi_cmd();
        $display("Load WRGB: 0x%02h 0x%02h 0x%02h 0x%02h", bytetx[1], bytetx[2], bytetx[3], bytetx[4]);
    end
    endtask

    // Load Reset Cycle
    // 1 Command Byte; 1+ Data Bytes
    task cmd_load_reset_cyle;
        integer i;
    begin
        for (i=0; i<32; i=i+1) begin
            bytetx[i] = 8'h00;
        end

        bytetx[0] = `SPI_CMD_LOAD_RESET_CYCLE;
        bytetx[1] = 8'hE1;
        bytecount = 2;

        spi_cmd();
        $display("Load Reset Cycle: 0x%02h ", bytetx[1]);
    end
    endtask

    // Load Reset Code
    // 1 Command Byte; 1+ Data Bytes
    task cmd_load_reset_code;
        integer i;
    begin
        for (i=0; i<32; i=i+1) begin
            bytetx[i] = 8'h00;
        end

        bytetx[0] = `SPI_CMD_LOAD_RESET_CODE;
        bytetx[1] = 8'hA5;
        bytecount = 2;

        spi_cmd();
        $display("Load Reset Code: 0x%02h", bytetx[1]);
    end
    endtask


    //*************************************************************************
    // System Reset
    //*************************************************************************
    initial begin
        scsn  = 1'b1;
        sclk  = 1'b0;
        mosi  = 1'b1;
        rst_n = 1'b0;
        #500;
        rst_n = 1'b1;
    end

