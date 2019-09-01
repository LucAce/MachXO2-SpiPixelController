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
// File:  tb_gpo.v
// Date:  Sun Aug 18 12:00:00 EDT 2019
//
// Functional Description:
//
//   General Purpose Output specific test operations.
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
        #SPI_DELAY;


        //*********************************************************************
        // GPO0
        //*********************************************************************

        // Clear GPO0
        cmd_reg_write(8'hF0, 8'h00);

        // Enable GPO0 (Tristate -> 0)
        cmd_reg_write(8'hF1, 8'h01);

        // Disable GPO0
        cmd_reg_write(8'hF1, 8'h00);

        // Set GPO0
        cmd_reg_write(8'hF0, 8'hFF);

        // Enable GPO0 (Tristate -> 1)
        cmd_reg_write(8'hF1, 8'h01);

        // Clear GPO0 (1 -> 0)
        cmd_reg_write(8'hF0, 8'h00);

        // Set GPO0 (0 -> 1)
        cmd_reg_write(8'hF0, 8'hFF);

        // Disable GPO0
        cmd_reg_write(8'hF1, 8'h00);


        //*********************************************************************
        // GPO1
        //*********************************************************************

        // Clear GPO1
        cmd_reg_write(8'hF0, 8'h00);

        // Enable GPO1 (Tristate -> 0)
        cmd_reg_write(8'hF1, 8'hFE);

        // Disable GPO1
        cmd_reg_write(8'hF1, 8'h00);

        // Set GPO1
        cmd_reg_write(8'hF0, 8'hFF);

        // Enable GPO1 (Tristate -> 1)
        cmd_reg_write(8'hF1, 8'hFE);

        // Clear GPO1 (1 -> 0)
        cmd_reg_write(8'hF0, 8'h00);

        // Set GPO1 (0 -> 1)
        cmd_reg_write(8'hF0, 8'hFF);

        // Disable GPO1
        cmd_reg_write(8'hF1, 8'h00);


        //*********************************************************************
        // GPO1 + GPO1
        //*********************************************************************

        // Clear GPO0/1
        cmd_reg_write(8'hF0, 8'h00);

        // Enable GPO0/1 (Tristate -> 0)
        cmd_reg_write(8'hF1, 8'hFF);

        // Disable GPO0/1
        cmd_reg_write(8'hF1, 8'h00);

        // Set GPO0/1
        cmd_reg_write(8'hF0, 8'hFF);

        // Enable GPO0/1 (Tristate -> 1)
        cmd_reg_write(8'hF1, 8'hFF);

        // Clear GPO0/1 (1 -> 0)
        cmd_reg_write(8'hF0, 8'h00);

        // Set GPO0/1 (0 -> 1)
        cmd_reg_write(8'hF0, 8'hFF);

        // Disable GPO0/1
        cmd_reg_write(8'hF1, 8'h00);

        $display("***************************************************");
        $display("* Test Complete");
        $display("***************************************************");
        $stop();
    end

endmodule
