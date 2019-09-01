onerror { resume }
transcript off
add wave

add wave -named_row "tb.v" -bold -height 32 -color 255,0,0
add wave -noreg -logic {/tb_top/rst_n}

add wave -named_row "IO" -bold -height 32 -color 255,0,0
add wave -noreg -logic {/tb_top/dut/RST_N}
add wave -noreg -logic {/tb_top/dut/SCLK}
add wave -noreg -logic {/tb_top/dut/SCSN}
add wave -noreg -logic {/tb_top/dut/MOSI}
add wave -noreg -logic {/tb_top/dut/MISO}
add wave -noreg -logic {/tb_top/dut/LED_OUT}
add wave -noreg -logic {/tb_top/dut/ERROR}
add wave -noreg -logic {/tb_top/dut/FIFO_AEMPTY}
add wave -noreg -logic {/tb_top/dut/FIFO_AFULL}
add wave -noreg -hexadecimal -literal {/tb_top/dut/GPO}

add wave -named_row "LED" -bold -height 32 -color 255,0,0
add wave -noreg -logic {/tb_top/led_out}
add wave -noreg -logic {/tb_top/error}
add wave -noreg -logic {/tb_top/fifo_aempty}
add wave -noreg -logic {/tb_top/fifo_afull}

add wave -named_row "SPI" -bold -height 32 -color 255,0,0
add wave -noreg -logic {/tb_top/sclk}
add wave -noreg -logic {/tb_top/SCSN}
add wave -noreg -logic {/tb_top/mosi}
add wave -noreg -logic {/tb_top/miso}

add wave -named_row "Ctrl" -bold -height 32 -color 255,0,0
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/sm_state}
add wave -noreg -logic {/tb_top/dut/ctrl_inst/sm_active}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/sm_spi_cmd}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/sm_spi_addr}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/sm_spi_byte}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/sm_byte_count}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/sm_pixel_index}

add wave -named_row "Wishbone" -bold -height 32 -color 255,0,0
add wave -noreg -logic {/tb_top/dut/ctrl_inst/CLK}
add wave -noreg -logic {/tb_top/dut/ctrl_inst/WB_CYC_O}
add wave -noreg -logic {/tb_top/dut/ctrl_inst/WB_STB_O}
add wave -noreg -logic {/tb_top/dut/ctrl_inst/WB_WE_O}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/WB_ADR_O}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/WB_DAT_O}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/WB_DAT_I}
add wave -noreg -logic {/tb_top/dut/ctrl_inst/WB_ACK_I}

add wave -named_row "Reg" -bold -height 32 -color 255,0,0
add wave -named_row "Registers" -bold -height 32 -color 255,0,0
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/REGS_ADDR}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/REGS_WDATA}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/REGS_RDATA}
add wave -noreg -logic {/tb_top/dut/ctrl_inst/REGS_WE}

add wave -named_row "EFB" -bold -height 32 -color 255,0,0
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_TIP}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_RRDY}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_TRDY}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_MDF}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_ROE}
add wave -noreg -logic {/tb_top/dut/slave_efb_inst/EFBInst_0/SPI_WRITE}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIBR}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SPICR0}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SPICR1}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SPICR2}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SPICSR}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SPIRXDR}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SPISR}
add wave -noreg -hexadecimal -literal {/tb_top/dut/slave_efb_inst/EFBInst_0/SPITXDR}

cursor "Cursor 1" 0ns
transcript on
