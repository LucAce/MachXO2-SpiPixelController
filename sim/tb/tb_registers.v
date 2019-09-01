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
// File:  tb_registers.v
// Date:  Sun Aug 18 12:00:00 EDT 2019
//
// Functional Description:
//
//   Register specific test operations.
//
//*****************************************************************************

`timescale 1ns/1ps

module tb_top;

    `include "tb_common.v"

    reg  [7:0]  address;

    //*************************************************************************
    // Test
    //*************************************************************************
    initial begin
        // Wait for reset negation
        #3000;

        $display("***************************************************");
        $display("* Test Started");
        $display("***************************************************");

        //*********************************************************************
        // Read and verify initial register values
        //*********************************************************************

        // Protocol
        cmd_protocol();

        // Version
        cmd_revision();

        // Reg 0x00: Status Register
        cmd_reg_verify(8'h00, 8'h05);

        // Reg 0x01: Configuration Register
        cmd_reg_verify(8'h01, 8'h01);

        // Reg 0x02: Format
        cmd_reg_verify(8'h02, 8'hA7);

        // Reg 0x03: Almost Full Threshold MSB
        cmd_reg_verify(8'h03, 8'h03);

        // Reg 0x04: Almost Full Threshold LSB
        cmd_reg_verify(8'h04, 8'h99);

        // Reg 0x05: Almost Empty Threshold MSB
        cmd_reg_verify(8'h05, 8'h00);

        // Reg 0x06: Almost Empty Threshold LSBs
        cmd_reg_verify(8'h06, 8'h67);

        // Reg 0x07: Zero High Timing
        cmd_reg_verify(8'h07, 8'h10);

        // Reg 0x08: Zero Low Timing
        cmd_reg_verify(8'h08, 8'h24);

        // Reg 0x09: One High Timing
        cmd_reg_verify(8'h09, 8'h20);

        // Reg 0x0A: One Low Timing
        cmd_reg_verify(8'h0A, 8'h1B);

        // Reg 0x0B: Reset Cycle Timing
        cmd_reg_verify(8'h0B, 8'h34);

        // Reg 0x0C: Reset Code Timing
        cmd_reg_verify(8'h0C, 8'h12);

        // Reg 0x0D: Run
        cmd_reg_verify(8'h0D, 8'h01);

        // Reg 0xF0: General Purpose Output
        cmd_reg_verify(8'hF0, 8'h00);

        // Reg 0xF1: General Purpose Output Enables
        cmd_reg_verify(8'hF1, 8'h00);

        // Reg 0xF2: Scatch Pad 1
        cmd_reg_verify(8'hF2, 8'h00);

        // Reg 0xF3: Scatch Pad 2
        cmd_reg_verify(8'hF3, 8'h00);

        // Reg 0xF4: Scatch Pad 3
        cmd_reg_verify(8'hF4, 8'h00);

        // Reg 0xF5: Scatch Pad 4
        cmd_reg_verify(8'hF5, 8'h00);


        //*********************************************************************
        // Read/Write to Scratch Registers
        //*********************************************************************

        // Scratch Pad 1
        address = 8'hF2;
        cmd_reg_write( address, 8'hA5);
        cmd_reg_verify(address, 8'hA5);

        cmd_reg_write( address, 8'h00);
        cmd_reg_write( address, 8'hFF);
        cmd_reg_write( address, 8'h0F);
        cmd_reg_write( address, 8'hF0);
        cmd_reg_write( address, 8'h22);
        cmd_reg_verify(address, 8'h22);

        // Scratch Pad 2
        address = 8'hF3;
        cmd_reg_write( address, 8'hA5);
        cmd_reg_verify(address, 8'hA5);

        cmd_reg_write( address, 8'h00);
        cmd_reg_write( address, 8'hFF);
        cmd_reg_write( address, 8'h0F);
        cmd_reg_write( address, 8'hF0);
        cmd_reg_write( address, 8'h33);
        cmd_reg_verify(address, 8'h33);

        // Scratch Pad 3
        address = 8'hF4;
        cmd_reg_write( address, 8'hA5);
        cmd_reg_verify(address, 8'hA5);

        cmd_reg_write( address, 8'h00);
        cmd_reg_write( address, 8'hFF);
        cmd_reg_write( address, 8'h0F);
        cmd_reg_write( address, 8'hF0);
        cmd_reg_write( address, 8'h44);
        cmd_reg_verify(address, 8'h44);

        // Scratch Pad 4
        address = 8'hF5;
        cmd_reg_write( address, 8'hA5);
        cmd_reg_verify(address, 8'hA5);

        cmd_reg_write( address, 8'h00);
        cmd_reg_write( address, 8'hFF);
        cmd_reg_write( address, 8'h0F);
        cmd_reg_write( address, 8'hF0);
        cmd_reg_write( address, 8'h55);
        cmd_reg_verify(address, 8'h55);


        //*********************************************************************
        // Scratch Pad Burst Write
        //*********************************************************************
        for (i=0; i<32; i=i+1) begin
            bytetx[i] = 8'h00;
        end

        bytetx[0] = `SPI_CMD_REG_WRITE;
        bytetx[1] = 8'hF2;
        bytetx[2] = 8'h12;
        bytetx[3] = 8'h23;
        bytetx[4] = 8'h34;
        bytetx[5] = 8'h45;
		bytecount = 6;

        spi_cmd();

        $display("Register Write Burst:");
        $display("  Address: 0x%02h", bytetx[1]);
        $display("  Data 1:  0x%02h", bytetx[2]);
        $display("  Data 2:  0x%02h", bytetx[3]);
        $display("  Data 3:  0x%02h", bytetx[4]);
        $display("  Data 4:  0x%02h", bytetx[5]);


        //*********************************************************************
        // Scratch Pad Burst Read
        //*********************************************************************
        for (i=0; i<32; i=i+1) begin
            bytetx[i] = 8'h00;
        end

        bytetx[0] = `SPI_CMD_REG_READ;
        bytetx[1] = 8'hF2;
		bytecount = 7;

        spi_cmd();

        if ( (byterx[3] == 8'h12) && (byterx[4] == 8'h23) &&
             (byterx[5] == 8'h34) && (byterx[6] == 8'h45) ) begin
            $display("Register Read Burst Matched Expected:");
            $display("  Address: 0x%02h", bytetx[1]);
            $display("  Data 1:  0x%02h", byterx[3]);
            $display("  Data 2:  0x%02h", byterx[4]);
            $display("  Data 3:  0x%02h", byterx[5]);
            $display("  Data 4:  0x%02h", byterx[6]);
        end
        else begin
            $error("");
            $display("Register Read Burst Matched Expected:");
            $display("  Address: 0x%02h", bytetx[1]);
            $display("  Data 1:  0x%02h", byterx[3]);
            $display("  Data 2:  0x%02h", byterx[4]);
            $display("  Data 3:  0x%02h", byterx[5]);
            $display("  Data 4:  0x%02h", byterx[6]);
        end

        $display("***************************************************");
        $display("* Test Complete");
        $display("***************************************************");
        $stop();
    end

endmodule
