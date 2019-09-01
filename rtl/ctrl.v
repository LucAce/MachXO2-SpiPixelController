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
// File:  ctrl.v
// Date:  Sun Aug 18 12:00:00 EDT 2019
// Title: Main Controller
//
// Functional Description:
//
//   Device Controller
//
// Notes:
//
//   - Writing to registers SPICR1 or SPICR2 will cause the SPI core to reset.
//     See note in table Table 18. SPI Control 1, or Table 19. SPI Control 2
//   - The Internal Wishbone Clock frequency of the EFB-SPI slave must be
//     atleast twice than the External SPI Master's clock frequency.
//
//*****************************************************************************

`timescale 1ns/1ps

module ctrl #(
    parameter           PROTOCOL = 8'hFF,   // Protocol Version
    parameter           REVISION = 8'hFF    // Device Revision
) (
    input  wire         CLK,                // Clock
    input  wire         RST_N,              // Reset (Active Low)

    // Wishbone Interface
    output wire         WB_CYC_O,           // Wishbone Bus Cycle
    output wire         WB_STB_O,           // Wishbone Strobe
    output reg          WB_WE_O,            // Wishbone Write Enable
    output reg  [7:0]   WB_ADR_O,           // Wishbone Address
    output reg  [7:0]   WB_DAT_O,           // Wishbone Data Out
    input  wire [7:0]   WB_DAT_I,           // Wishbone Data In
    input  wire         WB_ACK_I,           // Wishbone Acknowledge

    // Status Register
    input  wire [7:0]   STATUS_REGISTER,    // Status Register

    // Register Interface
    output reg          REGS_WE,            // Registers Write Enable
    output reg  [7:0]   REGS_ADDR,          // Registers Address
    output reg  [7:0]   REGS_WDATA,         // Registers Write Data
    input  wire [7:0]   REGS_RDATA,         // Registers Read Data

    // FIFO Write Interface
    input  wire         FIFO_FULL,          // FIFO Full Flag
    output reg          FIFO_WE,            // FIFO Write Enable
    output reg  [33:0]  FIFO_WDATA,         // FIFO Write Data

    // FIFO Status Flags
    output reg          FIFO_OVERFLOW,      // FIFO Overflow Flag

    // EOF/Reset Flag
    output reg          EOF                 // End of Frame Flag
);

    //*************************************************************************
    // Signal Definition
    //*************************************************************************

    // Request Types
    `define REQ_READ                 1'b0
    `define REQ_WRITE                1'b1

    // SPI EFB Register Addresses
    `define SPICR0                   8'h54
    `define SPICR1                   8'h55
    `define SPICR2                   8'h56
    `define SPIBR                    8'h57
    `define SPICSR                   8'h58
    `define SPITXDR                  8'h59
    `define SPISR                    8'h5A
    `define SPIRXDR                  8'h5B
    `define SPIIRQ                   8'h5C
    `define SPIIRQEN                 8'h5D

    // SPI EFB Register Configuration Values
    `define SPICR1_CFG               8'h80
    `define SPICR2_CFG               8'h00
    `define SPITXDR_CFG              8'h00
    `define SPIIRQEN_CFG             8'h00

    // SPI Commands
    `define SPI_CMD_PROTOCOL         8'hF0
    `define SPI_CMD_REVISION         8'hF1
    `define SPI_CMD_REG_READ         8'h00
    `define SPI_CMD_REG_WRITE        8'h01
    `define SPI_CMD_LOAD_RGB         8'h04
    `define SPI_CMD_LOAD_WRGB        8'h05
    `define SPI_CMD_LOAD_RESET_CYCLE 8'h06
    `define SPI_CMD_LOAD_RESET_CODE  8'h07

    // State Machine States
    `define S_INIT                   5'h00
    `define S_SPICR1                 5'h01
    `define S_SPICR2                 5'h02
    `define S_WAIT_FOR_TIPN          5'h03
    `define S_RXDR_DISCARD1          5'h04
    `define S_RXDR_DISCARD2          5'h05
    `define S_T1_TXDR                5'h06
    `define S_WAIT_FOR_TIP           5'h07
    `define S_T2_TRDY                5'h08
    `define S_T2_TXDR                5'h09
    `define S_R1_RRDY                5'h0A
    `define S_R1_RXDR                5'h0B
    `define S_T3_TRDY                5'h0C
    `define S_T3_TXDR                5'h0D
    `define S_RN_RRDY                5'h0E
    `define S_RN_RXDR                5'h0F
    `define S_RN_PROCESS             5'h10
    `define S_TN_TRDY                5'h11
    `define S_TN_TXDR                5'h12

    // Wishbone Cycle
    reg       wb_cyc;

    // State machine state
    reg [4:0] sm_state;

    // State machine intermediates, flags
    reg [7:0] sm_spi_cmd;
    reg [7:0] sm_spi_byte;
    reg [3:0] sm_byte_count;
    reg [1:0] sm_pixel_index;

    // Immediate assignments
    // Article ID 2416 and some documentation states
    // a delay is required to avoid a race condition
    // in the simulation model
    assign #1.000 WB_STB_O = wb_cyc;
    assign #1.000 WB_CYC_O = wb_cyc;


    //*************************************************************************
    // Controller State Machine
    //*************************************************************************
    always @(posedge CLK or negedge RST_N) begin
        if (RST_N == 1'b0) begin
            sm_state        <= `S_INIT;

            // Wishbone output reset values
            wb_cyc          <= 1'b0;
            WB_WE_O         <= 1'b0;
            WB_ADR_O        <= 8'h00;
            WB_DAT_O        <= 8'h00;

            // Reset Register Request Attributes
            REGS_ADDR       <= 8'h00;
            REGS_WDATA      <= 8'h00;
            REGS_WE         <= 1'b0;

            // Reset FIFO Attributes
            FIFO_WE         <= 1'b0;
            FIFO_WDATA      <= 34'h0_0000_0000;
            FIFO_OVERFLOW   <= 1'b0;

            // Reset SPI Attributes
            sm_spi_cmd      <= 8'h00;
            sm_spi_byte     <= 8'h00;

            // Reset State Machine Attributes
            sm_byte_count   <= 4'h0;
            sm_pixel_index  <= 2'b00;

            // Reset EOF Flag
            EOF             <= 1'b0;
        end
        else begin
            // Default signals
            wb_cyc          <= 1'b0;
            WB_WE_O         <= `REQ_READ;
            REGS_WE         <= 1'b0;
            FIFO_WE         <= 1'b0;
            FIFO_OVERFLOW   <= 1'b0;
            EOF             <= 1'b0;

            case (sm_state)
                //*************************************************************
                // State: Init
                // Idle state.
                //*************************************************************
                `S_INIT: begin
                    sm_state <= `S_SPICR1;
                end

                //*************************************************************
                // State: S_SPICR1
                // Enable EFB SPI Interface
                //*************************************************************
                `S_SPICR1: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPICR1;
                    WB_DAT_O <= `SPICR1_CFG;
                    WB_WE_O  <= `REQ_WRITE;
                    sm_state <= `S_SPICR1;

                    if (WB_ACK_I == 1'b1) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_SPICR2;
                    end
                end

                //*************************************************************
                // State: S_SPICR2
                // Enable EFB SPI as a Slave
                //*************************************************************
                `S_SPICR2: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPICR2;
                    WB_DAT_O <= `SPICR2_CFG;
                    WB_WE_O  <= `REQ_WRITE;

                    if (WB_ACK_I == 1'b1) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_WAIT_FOR_TIPN;
                    end
                end

                //*************************************************************
                // State: S_WAIT_FOR_TIPN
                // Wait for Not TIP
                //*************************************************************
                `S_WAIT_FOR_TIPN: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPISR;
                    WB_WE_O  <= `REQ_READ;

                    // TIPN
                    if ( (WB_ACK_I    == 1'b1) &&
                         (WB_DAT_I[7] == 1'b0) ) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_RXDR_DISCARD1;
                    end
                    // Make new wishbone request
                    else if (WB_ACK_I == 1'b1)  begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_WAIT_FOR_TIPN;
                    end
                end

                //*************************************************************
                // State: S_RXDR_DISCARD1
                // Discard data from RXDR
                //
                // discard <= RXDR
                //*************************************************************
                `S_RXDR_DISCARD1: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPIRXDR;
                    WB_WE_O  <= `REQ_READ;

                    if (WB_ACK_I == 1'b1) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_RXDR_DISCARD2;
                    end
                end

                //*************************************************************
                // State: S_RXDR_DISCARD2
                // Discard data from RXDR
                //
                // discard <= RXDR
                //*************************************************************
                `S_RXDR_DISCARD2: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPIRXDR;
                    WB_WE_O  <= `REQ_READ;

                    if (WB_ACK_I == 1'b1) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_T1_TXDR;
                    end
                end

                //*************************************************************
                // State: S_T1_TXDR
                // Load T1 Data into TXDR
                //
                // TXDR <= T1 data
                //*************************************************************
                `S_T1_TXDR: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPITXDR;
                    WB_DAT_O <= 8'h00;
                    WB_WE_O  <= `REQ_WRITE;

                    if (WB_ACK_I == 1'b1) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_WAIT_FOR_TIP;
                    end
                end

                //*************************************************************
                // State: S_WAIT_FOR_TIP
                // Wait for TIP
                //*************************************************************
                `S_WAIT_FOR_TIP: begin
                    sm_byte_count  <= 4'h0;
                    sm_pixel_index <= 2'b00;

                    wb_cyc         <= 1'b1;
                    WB_ADR_O       <= `SPISR;
                    WB_WE_O        <= `REQ_READ;

                    // TXDR
                    if ( (WB_ACK_I    == 1'b1) &&
                         (WB_DAT_I[7] == 1'b1) &&
                         (WB_DAT_I[4] == 1'b1) ) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_T2_TXDR;
                    end
                    // TRDY
                    else if ( (WB_ACK_I    == 1'b1) &&
                              (WB_DAT_I[7] == 1'b1) ) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_T2_TRDY;
                    end
                    // Make new wishbone request
                    else if (WB_ACK_I == 1'b1) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_WAIT_FOR_TIP;
                    end
                end

                //*************************************************************
                // State: S_T2_TRDY
                // Wait for TRDY
                //*************************************************************
                `S_T2_TRDY: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPISR;
                    WB_WE_O  <= `REQ_READ;

                    // TRDY
                    if ( (WB_ACK_I    == 1'b1) &&
                         (WB_DAT_I[4] == 1'b1) ) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_T2_TXDR;
                    end
                    // Make new wishbone request
                    else if (WB_ACK_I == 1'b1) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_T2_TRDY;
                    end
                end

                //*************************************************************
                // State: S_T2_TXDR
                // Load T2 Data into TXDR
                //
                // TXDR <= T2 data
                //*************************************************************
                `S_T2_TXDR: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPITXDR;
                    WB_DAT_O <= 8'h00;
                    WB_WE_O  <= `REQ_WRITE;

                    if (WB_ACK_I == 1'b1) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_R1_RRDY;
                    end
                end

                //*************************************************************
                // State: S_R1_RRDY
                // Wait for RRDY following T2
                //*************************************************************
                `S_R1_RRDY: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPISR;
                    WB_WE_O  <= `REQ_READ;

                    // SPI complete, no pending RX data
                    if ( (WB_ACK_I    == 1'b1) &&
                         (WB_DAT_I[7] == 1'b0) &&
                         (WB_DAT_I[3] == 1'b0) ) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_SPICR2;
                    end
                    // RXDR
                    else if ( (WB_ACK_I    == 1'b1) &&
                              (WB_DAT_I[3] == 1'b1) ) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_R1_RXDR;
                    end
                    // Make new wishbone request
                    else if (WB_ACK_I == 1'b1) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_R1_RRDY;
                    end
                end

                //*************************************************************
                // State: S_R1_RXDR
                // Read R1 Data from RXDR, R1 data is the SPI Command
                //
                // R1 data <= RXDR
                //*************************************************************
                `S_R1_RXDR: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPIRXDR;
                    WB_WE_O  <= `REQ_READ;

                    if (WB_ACK_I == 1'b1) begin
                        sm_byte_count <= 4'h1;
                        sm_spi_cmd    <= WB_DAT_I;

                        wb_cyc        <= 1'b0;
                        WB_WE_O       <= `REQ_READ;
                        sm_state      <= `S_T3_TRDY;
                    end
                end

                //*************************************************************
                // State: S_T3_TRDY
                // Wait for TRDY
                //*************************************************************
                `S_T3_TRDY: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPISR;
                    WB_WE_O  <= `REQ_READ;

                    // SPI complete
                    if ( (WB_ACK_I    == 1'b1) &&
                         (WB_DAT_I[7] == 1'b0) ) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_SPICR2;
                    end
                    // TRDY
                    else if ( (WB_ACK_I    == 1'b1) &&
                              (WB_DAT_I[4] == 1'b1) ) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_T3_TXDR;
                    end
                    // Make new wishbone request
                    else if (WB_ACK_I == 1'b1) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_T3_TRDY;
                    end
                end

                //*************************************************************
                // State: S_T3_TXDR
                // Load T3 Data into TXDR
                //
                // TXDR <= T3 data
                //*************************************************************
                `S_T3_TXDR: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPITXDR;
                    WB_WE_O  <= `REQ_WRITE;

                    // Only Protocol and Revision commands return data at T3
                    case (sm_spi_cmd)
                        `SPI_CMD_PROTOCOL: WB_DAT_O <= PROTOCOL;
                        `SPI_CMD_REVISION: WB_DAT_O <= REVISION;
                        default:           WB_DAT_O <= 8'h00;
                    endcase

                    if (WB_ACK_I == 1'b1) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_RN_RRDY;
                    end
                end

                //*************************************************************
                // State: S_RN_RRDY
                // Wait for R2/RN RRDY
                //*************************************************************
                `S_RN_RRDY: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPISR;
                    WB_WE_O  <= `REQ_READ;

                    // SPI complete, no pending RX data
                    if ( (WB_ACK_I    == 1'b1) &&
                         (WB_DAT_I[7] == 1'b0) &&
                         (WB_DAT_I[3] == 1'b0) ) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_SPICR2;
                    end
                    // RRDY
                    else if ( (WB_ACK_I    == 1'b1) &&
                              (WB_DAT_I[3] == 1'b1) ) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_RN_RXDR;
                    end
                    // Make new wishbone request
                    else if (WB_ACK_I == 1'b1) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_RN_RRDY;
                    end
                end

                //*************************************************************
                // State: S_RN_RXDR
                // Read R2/R2+ Data from RXDR
                //
                // R2 data <= RXDR
                //*************************************************************
                `S_RN_RXDR: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPIRXDR;
                    WB_WE_O  <= `REQ_READ;

                    if (WB_ACK_I == 1'b1) begin
                        wb_cyc        <= 1'b0;
                        WB_WE_O       <= `REQ_READ;
                        sm_spi_byte   <= WB_DAT_I;

                        // Register address at 4'h1 for register commands
                        if ( (sm_byte_count == 4'h1)              &&
                            ((sm_spi_cmd    == `SPI_CMD_REG_READ) ||
                             (sm_spi_cmd    == `SPI_CMD_REG_WRITE)) ) begin
                            REGS_ADDR <= WB_DAT_I;
                        end

                        sm_state <= `S_RN_PROCESS;
                    end
                end

                //*************************************************************
                // State: S_RN_PROCESS
                // Process the R2/R2+ RX Data word depending on SPI Command
                //*************************************************************
                `S_RN_PROCESS: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPISR;
                    WB_WE_O  <= `REQ_READ;
                    sm_state <= `S_TN_TRDY;

                    // Increment the byte counter to track what part of the
                    // command the FSM is processings.  This is used for
                    // commands with address bytes following the command.
                    // The counter saturates and does not rollover.
                    if (sm_byte_count != 4'hF) begin
                        sm_byte_count <= sm_byte_count + 4'h1;
                    end

                    // Process the byte depending on the command type
                    case (sm_spi_cmd)
                        // Load RGB Byte
                        // 3 Bytes Per Pixel
                        `SPI_CMD_LOAD_RGB: begin
                            FIFO_WDATA[33:32] <= 2'h0;

                            case (sm_pixel_index)
                                2'b00: FIFO_WDATA[23:16] <= sm_spi_byte;
                                2'b01: FIFO_WDATA[15: 8] <= sm_spi_byte;
                                2'b10: begin
                                    FIFO_WDATA[ 7: 0] <= sm_spi_byte;
                                    if (FIFO_FULL == 1'b0)
                                        FIFO_WE <= 1'b1;
                                    else
                                        FIFO_OVERFLOW <= 1'b1;
                                end
                            endcase

                            if (sm_pixel_index < 2'b10)
                                sm_pixel_index <= sm_pixel_index + 2'b01;
                            else
                                sm_pixel_index <= 2'b00;
                        end

                        // Load WRGB Byte
                        // 4 Bytes Per Pixel
                        `SPI_CMD_LOAD_WRGB: begin
                            FIFO_WDATA[33:32] <= 2'h0;

                            case (sm_pixel_index)
                                2'b00: FIFO_WDATA[31:24] <= sm_spi_byte;
                                2'b01: FIFO_WDATA[23:16] <= sm_spi_byte;
                                2'b10: FIFO_WDATA[15: 8] <= sm_spi_byte;
                                2'b11: begin
                                    FIFO_WDATA[ 7: 0] <= sm_spi_byte;
                                    if (FIFO_FULL == 1'b0)
                                        FIFO_WE <= 1'b1;
                                    else
                                        FIFO_OVERFLOW <= 1'b1;
                                end
                            endcase

                            if (sm_pixel_index < 2'b11)
                                sm_pixel_index <= sm_pixel_index + 2'b01;
                            else
                                sm_pixel_index <= 2'b00;
                        end

                        // Load Reset Cycle
                        // Pixel bits (31:0) ignored
                        `SPI_CMD_LOAD_RESET_CYCLE: begin
                            FIFO_WDATA[33:32] <= 2'h2;

                            if (FIFO_FULL == 1'b0) begin
                                FIFO_WE <= 1'b1;
                                EOF     <= 1'b1;
                            end
                            else begin
                                FIFO_OVERFLOW <= 1'b1;
                            end
                        end

                        // Load Reset Code
                        // Pixel bits (31:0) ignored
                        `SPI_CMD_LOAD_RESET_CODE: begin
                            FIFO_WDATA[32:32] <= 2'h1;

                            if (FIFO_FULL == 1'b0) begin
                                FIFO_WE <= 1'b1;
                                EOF     <= 1'b1;
                            end
                            else begin
                                FIFO_OVERFLOW <= 1'b1;
                            end
                        end

                        // Register Write Data
                        `SPI_CMD_REG_WRITE: begin
                            if (sm_byte_count > 4'h1) begin
                                REGS_WDATA <= sm_spi_byte;
                                REGS_WE    <= 1'b1;
                            end
                        end
                    endcase
                end

                //*************************************************************
                // State: S_TN_TRDY
                // Wait for T2/TN TRDY
                //*************************************************************
                `S_TN_TRDY: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPISR;
                    WB_WE_O  <= `REQ_READ;

                    // SPI complete
                    if ( (WB_ACK_I    == 1'b1) &&
                         (WB_DAT_I[7] == 1'b0) ) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_SPICR2;
                    end
                    // TRDY
                    else if ( (WB_ACK_I    == 1'b1) &&
                              (WB_DAT_I[4] == 1'b1) ) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_TN_TXDR;
                    end
                    // Make new Wishbone request
                    else if (WB_ACK_I == 1'b1) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;
                        sm_state <= `S_TN_TRDY;
                    end
                end

                //*************************************************************
                // State: S_TN_TXDR
                // Load TXDR register with next byte to transmit
                //*************************************************************
                `S_TN_TXDR: begin
                    wb_cyc   <= 1'b1;
                    WB_ADR_O <= `SPITXDR;
                    WB_WE_O  <= `REQ_WRITE;

                    // Return register value on register reads
                    if ( (sm_spi_cmd    == `SPI_CMD_REG_READ) &&
                         (sm_byte_count >= 4'h2) ) begin
                        WB_DAT_O <= REGS_RDATA;
                    end
                    // Return status register for load commands
                    else if ( (sm_spi_cmd == `SPI_CMD_LOAD_RGB)         ||
                              (sm_spi_cmd == `SPI_CMD_LOAD_WRGB)        ||
                              (sm_spi_cmd == `SPI_CMD_LOAD_RESET_CYCLE) ||
                              (sm_spi_cmd == `SPI_CMD_LOAD_RESET_CODE) ) begin
                        WB_DAT_O <= STATUS_REGISTER;
                    end
                    // Return Status Register in all other cases
                    else begin
                        WB_DAT_O <= 8'h00;
                    end

                    if (WB_ACK_I == 1'b1) begin
                        wb_cyc   <= 1'b0;
                        WB_WE_O  <= `REQ_READ;

                        // Increment register address
                        if ( ((sm_byte_count >= 4'h3)                &&
                              (sm_spi_cmd    == `SPI_CMD_REG_WRITE)) ||
                             ((sm_byte_count >= 4'h2)                &&
                              (sm_spi_cmd    == `SPI_CMD_REG_READ)) ) begin
                            REGS_ADDR <= REGS_ADDR + 4'h1;
                        end

                        sm_state <= `S_RN_RRDY;
                    end
                end

                //*************************************************************
                // State: Default
                // All other values of sm_state.
                //*************************************************************
                default: begin
                    sm_state <= `S_INIT;
                end
            endcase
        end
    end

endmodule
