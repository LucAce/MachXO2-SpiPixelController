onerror { resume }
transcript off
add wave

add wave -named_row "EFB" -bold -height 32 -color 255,0,0

add wave -noreg -logic {/tb_top/dut/slave_efb_inst/scuba_vhi}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/scuba_vlo}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/spi_clk}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/spi_clk_i}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/spi_clk_o}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/spi_clk_oe}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/spi_miso}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/spi_miso_i}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/spi_miso_o}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/spi_miso_oe}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/spi_mosi}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/spi_mosi_i}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/spi_mosi_o}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/spi_mosi_oe}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/spi_scsn}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/wb_ack_o}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/wb_adr_i}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/wb_clk_i}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/wb_cyc_i}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/wb_dat_i}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/wb_dat_o}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/wb_rst_i}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/wb_stb_i}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/wb_we_i}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/BTF}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/CCLKEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/CCLKIN_int}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/CFGSTDBY}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/CFGWAKE}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/CFRONT_INIT_N}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/CLKEDGE}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/CLKSEL}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/CPHA}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/CPOL}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/CS0_N}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/DEFAULT_RBT}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/DONE_CNT}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/DR}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/D_CLK}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/GSR_sig}
add wave -noreg -hexadecimal -literal -signed2 {/tb_top/dut/slave_efb_inst/EFBInst_0/H}
add wave -noreg -hexadecimal -literal -signed2 {/tb_top/dut/slave_efb_inst/EFBInst_0/I}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C1IRQO}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C1SCLI}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C1SCLO}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C1SCLOEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C1SDAI}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C1SDAO}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C1SDAOEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C2IRQO}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C2SCLI}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C2SCLO}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C2SCLOEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C2SDAI}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C2SDAO}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C2SDAOEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_ACK}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_ARBL}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_BR0}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_BR1}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_BUSY}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_CKSDIS}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_CMDR}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_CR}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_EN}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_GCDR}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_GCEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_HGC}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_IRQARBL}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_IRQARBLEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_IRQHGC}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_IRQHGCEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_IRQTROE}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_IRQTROEEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_IRQTRRDY}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_IRQTRRDYEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_RARC}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_RD}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_RXDR}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_SDA_DEL_SEL}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_SR}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_SRW}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_STA}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_STO}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_TIP}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_TROE}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_TRRDY}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_TXDR}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_WKUPEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_1_WR}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_ACK}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_ARBL}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_BR0}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_BR1}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_BUSY}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_CKSDIS}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_CMDR}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_CR}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_EN}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_GCDR}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_GCEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_HGC}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_IRQARBL}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_IRQARBLEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_IRQHGC}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_IRQHGCEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_IRQTROE}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_IRQTROEEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_IRQTRRDY}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_IRQTRRDYEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_RARC}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_RD}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_RXDR}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_SDA_DEL_SEL}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_SR}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_SRW}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_STA}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_STO}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_TIP}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_TROE}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_TRRDY}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_TXDR}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_WKUPEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/I2C_2_WR}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/ICEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/ICRF}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/IRQICRF}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/IRQICRFEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/IRQOCRF}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/IRQOCRFEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/IRQOVF}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/IRQOVFEN}
add wave -noreg -hexadecimal -literal -signed2 {/tb_top/dut/slave_efb_inst/EFBInst_0/J}
add wave -noreg -hexadecimal -literal -signed2 {/tb_top/dut/slave_efb_inst/EFBInst_0/K}
add wave -noreg -hexadecimal -literal -signed2 {/tb_top/dut/slave_efb_inst/EFBInst_0/L}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/LSBF}
add wave -noreg -hexadecimal -literal -signed2 {/tb_top/dut/slave_efb_inst/EFBInst_0/M}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/MCSH}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/MEM_D}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/MODE}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/MSTR}
add wave -noreg -hexadecimal -literal -signed2 {/tb_top/dut/slave_efb_inst/EFBInst_0/N}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/OCM}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/OCRF}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/OVF}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PAD_DONE}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PAD_INIT}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL0ACKI}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL0DATI0}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL0DATI1}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL0DATI2}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL0DATI3}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL0DATI4}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL0DATI5}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL0DATI6}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL0DATI7}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL0STBO}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL1ACKI}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL1DATI0}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL1DATI1}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL1DATI2}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL1DATI3}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL1DATI4}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL1DATI5}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL1DATI6}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL1DATI7}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLL1STBO}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLLADRO0}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLLADRO1}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLLADRO2}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLLADRO3}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLLADRO4}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLLCLKO}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLLDATO0}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLLDATO1}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLLDATO2}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLLDATO3}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLLDATO4}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLLDATO5}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLLDATO6}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLLDATO7}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLLRSTO}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PLLWEO}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/PRESCALE}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PRGM_ISC}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/PUR_sig}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/RBT_FLAG}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/RSTEN}
add wave -noreg -hexadecimal -literal -signed2 {/tb_top/dut/slave_efb_inst/EFBInst_0/RUNTIME}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SDBRE}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SHIFT_COUNT}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SHUTUP_N}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SI}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SOVFEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPE}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIBR}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SPICR0}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SPICR1}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SPICR2}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPICSNEN}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SPICSR}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIIRQO}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIMCSN0}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIMCSN1}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIMCSN2}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIMCSN3}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIMCSN4}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIMCSN5}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIMCSN6}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIMCSN7}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIMISOEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIMISOI}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIMISOO}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIMOSIEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIMOSII}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIMOSIO}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIRXDR}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPISCKEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPISCKI}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPISCKO}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPISCSN}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SPISR}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SPITXDR}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_IRQMDF}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_IRQMDFEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_IRQROE}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_IRQROEEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_IRQRRDY}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_IRQRRDYEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_IRQTRDY}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_IRQTRDYEN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_MDF}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_ROE}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_RRDY}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_TIP}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_TRDY}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_WRITE}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SRN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/TCCLKI}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/TCCNT0}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/TCCNT1}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/TCCR0}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/TCCR1}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/TCCR2}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/TCIC}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/TCICR}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/TCINT}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/TCIRQ}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/TCIRQEN}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/TCM}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/TCOC}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/TCOCR}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/TCOCRSET}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/TCRSTN}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/TCSR0}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/TCTOP}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/TCTOPSET}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/TSEL}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/TXEDGE}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/UFMSN}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBACKO}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBADRI0}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBADRI1}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBADRI2}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBADRI3}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBADRI4}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBADRI5}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBADRI6}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBADRI7}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBCLKI}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBCUFMIRQ}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBCYCI}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBDATI0}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBDATI1}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBDATI2}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBDATI3}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBDATI4}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBDATI5}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBDATI6}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBDATI7}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBDATO0}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBDATO1}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBDATO2}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBDATO3}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBDATO4}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBDATO5}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBDATO6}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBDATO7}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBFORCE}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBPAUSE}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBRESET}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBRSTI}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBSTBI}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WBWEI}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WKUPEN_CFG}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/WKUPEN_USER}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/auto_done}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/bg_stable}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/bin10str2bin.bin10str}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/bin10str2bin.bin10str2bin}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/bin10str2bin.ch}
add wave -noreg -hexadecimal -literal -signed2 {/tb_top/dut/slave_efb_inst/EFBInst_0/bin10str2bin.i}
add wave -noreg -hexadecimal -literal -signed2 {/tb_top/dut/slave_efb_inst/EFBInst_0/bin10str2bin.j}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/bin7str2bin.bin7str}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/bin7str2bin.bin7str2bin}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/bin7str2bin.ch}
add wave -noreg -hexadecimal -literal -signed2 {/tb_top/dut/slave_efb_inst/EFBInst_0/bin7str2bin.i}
add wave -noreg -hexadecimal -literal -signed2 {/tb_top/dut/slave_efb_inst/EFBInst_0/bin7str2bin.j}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/bsmode}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/cfg_osc}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/cib_done}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/device}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/done_md_n}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/done_outp}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/done_ts}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_c_bl}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_capture_dout}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_cfg_row_sel_all}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_cfg_row_sel_none}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_col_rst}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_col_shift}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_colstart}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_dout}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_drain_ctrl}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_en_vreg_mon}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_era_cfg}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_era_feat}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_era_trim}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_era_ufm}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_era_ver}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_erapdis}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_erase_pulse}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_erase_setup}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_feat_row_sel_all}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_feat_row_sel_none}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_flash_en}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_l_row_cfg}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_l_row_ufm}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_lastcol}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_mfg_margin_en}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_neg_edge_det}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_ppt_en}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_ppt_pset}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_ppt_rowsel}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_prestep_in_neg}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_prg_cfg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_prg_pulse}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_prg_pwtc}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_prg_tf}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_prg_ufm}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_prgdrv_ena}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_prgdrv_enall}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_prog_disch}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_pwtc_well}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_read_cfg}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_read_tf}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_read_ufm}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_readpart}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_ready}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_ready_rst}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_ready_vfy}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_reg_enable}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_row}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_sa_ena}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_sa_enall}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_scp}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_scpv}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_sel_6p5v}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_softprg}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_src_clamp}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_step_in_neg}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_subrow_hvena_cfg}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_subrow_hvena_tf}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_subrow_hvena_ufm}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_subrow_hvenall_cfg}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_subrow_hvenall_ufm}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_subrow_mvena_cfg}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_subrow_mvena_tf}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_subrow_mvena_ufm}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_subrow_mvenall_cfg}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_subrow_mvenall_ufm}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_trim_row_sel_all}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_trim_row_sel_none}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_ufm_row_sel_all}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_ufm_row_sel_none}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_verify}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_vwlp_active}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_wand_eval}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_well_active}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/fl_wor_eval}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/flash_clk_mfg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/idcode}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/init_md_n}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/init_n}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/init_ts}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/mc1_mclk_cib_reg}
add wave -noreg -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/mem_end}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/mux32_out1_mfg}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/mux32_out2_mfg}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/pad_cclk}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/pad_cclk_src}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/pad_done}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/pad_init}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/pad_si}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/pad_sn}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/pfsafe}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/pwrup_pur_n}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/setCclk.EN}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/setMode.CFG_MODE}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/setSpiCommand.COMM}
add wave -noreg -hexadecimal -literal -signed2 {/tb_top/dut/slave_efb_inst/EFBInst_0/setSpiCommand.LENGTH}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/setSpiCommand.OPERAND}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/setSpiCommand.WR}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/setSpiWrite.WRITE_INC}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/tc_rstn}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/scuba_vlo_inst/VSS}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/scuba_vlo_inst/Z}
cursor "Cursor 1" 2172ns
transcript on
