onerror { resume }
transcript off
add wave

add wave -named_row "top.v" -bold -height 32 -color 255,0,0

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

add wave -named_row "Internal" -bold -height 32 -color 255,0,0
add wave -noreg -logic {/tb_top/dut/clk}
add wave -noreg -logic {/tb_top/dut/rst}
add wave -noreg -logic {/tb_top/dut/wbm_cyc_o}
add wave -noreg -logic {/tb_top/dut/wbm_stb_o}
add wave -noreg -logic {/tb_top/dut/wbm_we_o}
add wave -noreg -hexadecimal -literal {/tb_top/dut/wbm_adr_o}
add wave -noreg -hexadecimal -literal {/tb_top/dut/wbm_dat_o}
add wave -noreg -hexadecimal -literal {/tb_top/dut/wbm_dat_i}
add wave -noreg -logic {/tb_top/dut/wbm_ack_i}
add wave -noreg -logic {/tb_top/dut/fifo_reset}
add wave -noreg -logic {/tb_top/dut/fifo_re}
add wave -noreg -hexadecimal -literal {/tb_top/dut/fifo_rdata}
add wave -noreg -logic {/tb_top/dut/fifo_we}
add wave -noreg -hexadecimal -literal {/tb_top/dut/fifo_wdata}
add wave -noreg -logic {/tb_top/dut/fifo_aempty_i}
add wave -noreg -logic {/tb_top/dut/fifo_empty_i}
add wave -noreg -logic {/tb_top/dut/fifo_afull_i}
add wave -noreg -logic {/tb_top/dut/fifo_full_i}
add wave -noreg -hexadecimal -literal {/tb_top/dut/fifo_aempty_thresh}
add wave -noreg -hexadecimal -literal {/tb_top/dut/fifo_afull_thresh}
add wave -noreg -logic {/tb_top/dut/fifo_overflow_i}
add wave -noreg -logic {/tb_top/dut/fifo_underflow_i}
add wave -noreg -logic {/tb_top/dut/reg_enable}
add wave -noreg -logic {/tb_top/dut/reg_mode}
add wave -noreg -hexadecimal -literal {/tb_top/dut/reg_format}
add wave -noreg -logic {/tb_top/dut/reg_run}
add wave -noreg -hexadecimal -literal {/tb_top/dut/reg_zero_high_timing}
add wave -noreg -hexadecimal -literal {/tb_top/dut/reg_zero_low_timing}
add wave -noreg -hexadecimal -literal {/tb_top/dut/reg_one_high_timing}
add wave -noreg -hexadecimal -literal {/tb_top/dut/reg_one_low_timing}
add wave -noreg -hexadecimal -literal {/tb_top/dut/reg_reset_cycle_timing}
add wave -noreg -hexadecimal -literal {/tb_top/dut/reg_reset_code_timing}
add wave -noreg -logic {/tb_top/dut/reg_error}
add wave -noreg -logic {/tb_top/dut/regs_we}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_addr}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_wdata}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_rdata}
add wave -noreg -logic {/tb_top/dut/ctrl_eof}
add wave -noreg -hexadecimal -literal {/tb_top/dut/gpo_i}
add wave -noreg -hexadecimal -literal {/tb_top/dut/gpo_oe_i}
add wave -noreg -logic {/tb_top/dut/ser_out}
add wave -noreg -hexadecimal -literal {/tb_top/dut/PROTOCOL}
add wave -noreg -hexadecimal -literal {/tb_top/dut/REVISION}

cursor "Cursor 1" 0ps  
transcript on
