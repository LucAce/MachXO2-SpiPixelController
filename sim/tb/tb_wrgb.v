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
// File:  tb_wrgb.v
// Date:  Sun Aug 18 12:00:00 EDT 2019
//
// Functional Description:
//
//   WRGB specific test operations.
//
//*****************************************************************************

`timescale 1ns/1ps

module tb_top;

    `include "tb_common.v"

    //*************************************************************************
    // Test
    //*************************************************************************
    initial begin
        // Wait for reset negation
        #2000;

        $display("***************************************************");
        $display("* Test Started");
        $display("***************************************************");

        // Protocol
        cmd_protocol();

        // Version
        cmd_revision();

        // Write

        // Reg 0x03: Almost Full Threshold MSB
        cmd_reg_write(8'h03, 8'h00);

        // Reg 0x04: Almost Full Threshold LSB
        cmd_reg_write(8'h04, 8'h20);

        // Reg 0x05: Almost Empty Threshold MSB
        cmd_reg_write(8'h05, 8'h00);

        // Reg 0x06: Almost Empty Threshold LSBs
        cmd_reg_write(8'h06, 8'h01);

        // Verify

        // Reg 0x03: Almost Full Threshold MSB
        cmd_reg_verify(8'h03, 8'h00);

        // Reg 0x04: Almost Full Threshold LSB
        cmd_reg_verify(8'h04, 8'h20);

        // Reg 0x05: Almost Empty Threshold MSB
        cmd_reg_verify(8'h05, 8'h00);

        // Reg 0x06: Almost Empty Threshold LSBs
        cmd_reg_verify(8'h06, 8'h01);


        //*********************************************************************
        // Enable and Config
        //*********************************************************************

        $display("***************************************************");
        $display("* Full Rate Loading");
        $display("***************************************************");

        while (fifo_afull == 1'b0) begin
            cmd_load_wrgb(8'h01, 8'h02, 8'h03, 8'h04);
            cmd_load_wrgb(8'h11, 8'h12, 8'h13, 8'h14);
            cmd_load_wrgb(8'h21, 8'h22, 8'h23, 8'h24);
            cmd_load_wrgb(8'h31, 8'h32, 8'h33, 8'h34);
            cmd_load_wrgb(8'h41, 8'h42, 8'h43, 8'h44);
            cmd_load_wrgb(8'h51, 8'h52, 8'h53, 8'h54);
            cmd_load_wrgb(8'h51, 8'h52, 8'h53, 8'h54);
            cmd_load_reset_code();
        end


        $display("***************************************************");
        $display("* AFULL Throttled Loading");
        $display("***************************************************");

        // After AFULL throttle loading
        repeat(5) begin

            $display("Waiting for AFULL = 0");
            while (fifo_afull == 1'b1)
                #10000;

            $display("Waiting for AFULL = 1");
            while (fifo_afull == 1'b0) begin
                cmd_load_wrgb(8'h01, 8'h02, 8'h03, 8'h04);
                cmd_load_wrgb(8'h11, 8'h12, 8'h13, 8'h14);
                cmd_load_wrgb(8'h21, 8'h22, 8'h23, 8'h24);
                cmd_load_wrgb(8'h31, 8'h32, 8'h33, 8'h34);
                cmd_load_wrgb(8'h41, 8'h42, 8'h43, 8'h44);
                cmd_load_wrgb(8'h51, 8'h52, 8'h53, 8'h54);
                cmd_load_wrgb(8'h51, 8'h52, 8'h53, 8'h54);
                cmd_load_reset_code();
            end
        end

        $display("Waiting for AEMPTY = 1");
        while (fifo_aempty == 1'b0)
            #10000;

        #500000;

        $display("***************************************************");
        $display("* Test Complete");
        $display("***************************************************");
        $stop();
    end

endmodule
