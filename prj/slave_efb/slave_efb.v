/* Verilog netlist generated by SCUBA Diamond (64-bit) 3.11.0.396.4 */
/* Module Version: 1.2 */
/* C:\Program Files\Lattice\diamond\3.11_x64\ispfpga\bin\nt64\scuba.exe -w -n slave_efb -lang verilog -synth lse -bus_exp 7 -bb -type efb -arch xo2c00 -freq 44.33 -spi -spi_mode Slave -wb -dev 1200  */
/* Tue Jul 02 05:37:39 2019 */


`timescale 1 ns / 1 ps
module slave_efb (wb_clk_i, wb_rst_i, wb_cyc_i, wb_stb_i, wb_we_i, 
    wb_adr_i, wb_dat_i, wb_dat_o, wb_ack_o, spi_clk, spi_miso, spi_mosi, 
    spi_scsn)/* synthesis NGD_DRC_MASK=1 */;
    input wire wb_clk_i;
    input wire wb_rst_i;
    input wire wb_cyc_i;
    input wire wb_stb_i;
    input wire wb_we_i;
    input wire [7:0] wb_adr_i;
    input wire [7:0] wb_dat_i;
    input wire spi_scsn;
    output wire [7:0] wb_dat_o;
    output wire wb_ack_o;
    inout wire spi_clk;
    inout wire spi_miso;
    inout wire spi_mosi;

    wire scuba_vhi;
    wire spi_mosi_oe;
    wire spi_mosi_o;
    wire spi_miso_oe;
    wire spi_miso_o;
    wire spi_clk_oe;
    wire spi_clk_o;
    wire spi_mosi_i;
    wire spi_miso_i;
    wire spi_clk_i;
    wire scuba_vlo;

    VHI scuba_vhi_inst (.Z(scuba_vhi));

    BB BBspi_mosi (.I(spi_mosi_o), .T(spi_mosi_oe), .O(spi_mosi_i), .B(spi_mosi));

    BB BBspi_miso (.I(spi_miso_o), .T(spi_miso_oe), .O(spi_miso_i), .B(spi_miso));

    BB BBspi_clk (.I(spi_clk_o), .T(spi_clk_oe), .O(spi_clk_i), .B(spi_clk));

    VLO scuba_vlo_inst (.Z(scuba_vlo));

    defparam EFBInst_0.UFM_INIT_FILE_FORMAT = "HEX" ;
    defparam EFBInst_0.UFM_INIT_FILE_NAME = "NONE" ;
    defparam EFBInst_0.UFM_INIT_ALL_ZEROS = "ENABLED" ;
    defparam EFBInst_0.UFM_INIT_START_PAGE = 0 ;
    defparam EFBInst_0.UFM_INIT_PAGES = 0 ;
    defparam EFBInst_0.DEV_DENSITY = "1200L" ;
    defparam EFBInst_0.EFB_UFM = "DISABLED" ;
    defparam EFBInst_0.TC_ICAPTURE = "DISABLED" ;
    defparam EFBInst_0.TC_OVERFLOW = "DISABLED" ;
    defparam EFBInst_0.TC_ICR_INT = "OFF" ;
    defparam EFBInst_0.TC_OCR_INT = "OFF" ;
    defparam EFBInst_0.TC_OV_INT = "OFF" ;
    defparam EFBInst_0.TC_TOP_SEL = "OFF" ;
    defparam EFBInst_0.TC_RESETN = "ENABLED" ;
    defparam EFBInst_0.TC_OC_MODE = "TOGGLE" ;
    defparam EFBInst_0.TC_OCR_SET = 32767 ;
    defparam EFBInst_0.TC_TOP_SET = 65535 ;
    defparam EFBInst_0.GSR = "ENABLED" ;
    defparam EFBInst_0.TC_CCLK_SEL = 1 ;
    defparam EFBInst_0.TC_MODE = "CTCM" ;
    defparam EFBInst_0.TC_SCLK_SEL = "PCLOCK" ;
    defparam EFBInst_0.EFB_TC_PORTMODE = "WB" ;
    defparam EFBInst_0.EFB_TC = "DISABLED" ;
    defparam EFBInst_0.SPI_WAKEUP = "DISABLED" ;
    defparam EFBInst_0.SPI_INTR_RXOVR = "DISABLED" ;
    defparam EFBInst_0.SPI_INTR_TXOVR = "DISABLED" ;
    defparam EFBInst_0.SPI_INTR_RXRDY = "DISABLED" ;
    defparam EFBInst_0.SPI_INTR_TXRDY = "DISABLED" ;
    defparam EFBInst_0.SPI_SLAVE_HANDSHAKE = "DISABLED" ;
    defparam EFBInst_0.SPI_PHASE_ADJ = "DISABLED" ;
    defparam EFBInst_0.SPI_CLK_INV = "DISABLED" ;
    defparam EFBInst_0.SPI_LSB_FIRST = "DISABLED" ;
    defparam EFBInst_0.SPI_CLK_DIVIDER = 1 ;
    defparam EFBInst_0.SPI_MODE = "SLAVE" ;
    defparam EFBInst_0.EFB_SPI = "ENABLED" ;
    defparam EFBInst_0.I2C2_WAKEUP = "DISABLED" ;
    defparam EFBInst_0.I2C2_GEN_CALL = "DISABLED" ;
    defparam EFBInst_0.I2C2_CLK_DIVIDER = 1 ;
    defparam EFBInst_0.I2C2_BUS_PERF = "100kHz" ;
    defparam EFBInst_0.I2C2_SLAVE_ADDR = "0b1000010" ;
    defparam EFBInst_0.I2C2_ADDRESSING = "7BIT" ;
    defparam EFBInst_0.EFB_I2C2 = "DISABLED" ;
    defparam EFBInst_0.I2C1_WAKEUP = "DISABLED" ;
    defparam EFBInst_0.I2C1_GEN_CALL = "DISABLED" ;
    defparam EFBInst_0.I2C1_CLK_DIVIDER = 1 ;
    defparam EFBInst_0.I2C1_BUS_PERF = "100kHz" ;
    defparam EFBInst_0.I2C1_SLAVE_ADDR = "0b1000001" ;
    defparam EFBInst_0.I2C1_ADDRESSING = "7BIT" ;
    defparam EFBInst_0.EFB_I2C1 = "DISABLED" ;
    defparam EFBInst_0.EFB_WB_CLK_FREQ = "44.3" ;
    EFB EFBInst_0 (.WBCLKI(wb_clk_i), .WBRSTI(wb_rst_i), .WBCYCI(wb_cyc_i), 
        .WBSTBI(wb_stb_i), .WBWEI(wb_we_i), .WBADRI7(wb_adr_i[7]), .WBADRI6(wb_adr_i[6]), 
        .WBADRI5(wb_adr_i[5]), .WBADRI4(wb_adr_i[4]), .WBADRI3(wb_adr_i[3]), 
        .WBADRI2(wb_adr_i[2]), .WBADRI1(wb_adr_i[1]), .WBADRI0(wb_adr_i[0]), 
        .WBDATI7(wb_dat_i[7]), .WBDATI6(wb_dat_i[6]), .WBDATI5(wb_dat_i[5]), 
        .WBDATI4(wb_dat_i[4]), .WBDATI3(wb_dat_i[3]), .WBDATI2(wb_dat_i[2]), 
        .WBDATI1(wb_dat_i[1]), .WBDATI0(wb_dat_i[0]), .PLL0DATI7(scuba_vlo), 
        .PLL0DATI6(scuba_vlo), .PLL0DATI5(scuba_vlo), .PLL0DATI4(scuba_vlo), 
        .PLL0DATI3(scuba_vlo), .PLL0DATI2(scuba_vlo), .PLL0DATI1(scuba_vlo), 
        .PLL0DATI0(scuba_vlo), .PLL0ACKI(scuba_vlo), .PLL1DATI7(scuba_vlo), 
        .PLL1DATI6(scuba_vlo), .PLL1DATI5(scuba_vlo), .PLL1DATI4(scuba_vlo), 
        .PLL1DATI3(scuba_vlo), .PLL1DATI2(scuba_vlo), .PLL1DATI1(scuba_vlo), 
        .PLL1DATI0(scuba_vlo), .PLL1ACKI(scuba_vlo), .I2C1SCLI(scuba_vlo), 
        .I2C1SDAI(scuba_vlo), .I2C2SCLI(scuba_vlo), .I2C2SDAI(scuba_vlo), 
        .SPISCKI(spi_clk_i), .SPIMISOI(spi_miso_i), .SPIMOSII(spi_mosi_i), 
        .SPISCSN(spi_scsn), .TCCLKI(scuba_vlo), .TCRSTN(scuba_vlo), .TCIC(scuba_vlo), 
        .UFMSN(scuba_vhi), .WBDATO7(wb_dat_o[7]), .WBDATO6(wb_dat_o[6]), 
        .WBDATO5(wb_dat_o[5]), .WBDATO4(wb_dat_o[4]), .WBDATO3(wb_dat_o[3]), 
        .WBDATO2(wb_dat_o[2]), .WBDATO1(wb_dat_o[1]), .WBDATO0(wb_dat_o[0]), 
        .WBACKO(wb_ack_o), .PLLCLKO(), .PLLRSTO(), .PLL0STBO(), .PLL1STBO(), 
        .PLLWEO(), .PLLADRO4(), .PLLADRO3(), .PLLADRO2(), .PLLADRO1(), .PLLADRO0(), 
        .PLLDATO7(), .PLLDATO6(), .PLLDATO5(), .PLLDATO4(), .PLLDATO3(), 
        .PLLDATO2(), .PLLDATO1(), .PLLDATO0(), .I2C1SCLO(), .I2C1SCLOEN(), 
        .I2C1SDAO(), .I2C1SDAOEN(), .I2C2SCLO(), .I2C2SCLOEN(), .I2C2SDAO(), 
        .I2C2SDAOEN(), .I2C1IRQO(), .I2C2IRQO(), .SPISCKO(spi_clk_o), .SPISCKEN(spi_clk_oe), 
        .SPIMISOO(spi_miso_o), .SPIMISOEN(spi_miso_oe), .SPIMOSIO(spi_mosi_o), 
        .SPIMOSIEN(spi_mosi_oe), .SPIMCSN7(), .SPIMCSN6(), .SPIMCSN5(), 
        .SPIMCSN4(), .SPIMCSN3(), .SPIMCSN2(), .SPIMCSN1(), .SPIMCSN0(), 
        .SPICSNEN(), .SPIIRQO(), .TCINT(), .TCOC(), .WBCUFMIRQ(), .CFGWAKE(), 
        .CFGSTDBY());



    // exemplar begin
    // exemplar end

endmodule
