onerror { resume }
transcript off
add wave

add wave -named_row "ctrl.v" -bold -height 32 -color 255,0,0
add wave -named_row "Wishbone" -bold -height 32 -color 255,0,0
add wave -noreg -logic {/tb_top/dut/ctrl_inst/CLK}
add wave -noreg -logic {/tb_top/dut/ctrl_inst/RST_N}
add wave -noreg -logic {/tb_top/dut/ctrl_inst/WB_CYC_O}
add wave -noreg -logic {/tb_top/dut/ctrl_inst/WB_STB_O}
add wave -noreg -logic {/tb_top/dut/ctrl_inst/WB_WE_O}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/WB_ADR_O}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/WB_DAT_O}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/WB_DAT_I}
add wave -noreg -logic {/tb_top/dut/ctrl_inst/WB_ACK_I}

add wave -named_row "Registers" -bold -height 32 -color 255,0,0
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/REGS_ADDR}
add wave -noreg -logic {/tb_top/dut/ctrl_inst/REGS_WE}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/REGS_WDATA}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/REGS_RDATA}

add wave -named_row "FIFO" -bold -height 32 -color 255,0,0
add wave -noreg -logic {/tb_top/dut/ctrl_inst/FIFO_FULL}
add wave -noreg -logic {/tb_top/dut/ctrl_inst/FIFO_WE}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/FIFO_WDATA}
add wave -noreg -logic {/tb_top/dut/ctrl_inst/FIFO_OVERFLOW}
add wave -noreg -logic {/tb_top/dut/ctrl_inst/EOF}

add wave -named_row "Internal" -bold -height 32 -color 255,0,0
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/sm_state}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/sm_spi_cmd}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/sm_spi_addr}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/sm_spi_byte}
add wave -noreg -logic {/tb_top/dut/ctrl_inst/sm_active}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/sm_byte_count}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/sm_pixel_index}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/PROTOCOL}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ctrl_inst/REVISION}
cursor "Cursor 1" 0ps  
transcript on
