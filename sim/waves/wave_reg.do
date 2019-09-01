onerror { resume }
transcript off
add wave

add wave -named_row "reg.v" -bold -height 32 -color 255,0,0

add wave -noreg -logic {/tb_top/dut/regs_inst/CLK}
add wave -noreg -logic {/tb_top/dut/regs_inst/RST_N}
add wave -noreg -logic {/tb_top/dut/regs_inst/REGS_WE}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/REGS_ADDR}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/REGS_WDATA}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/REGS_RDATA}
add wave -noreg -logic {/tb_top/dut/regs_inst/FIFO_ALMOST_FULL}
add wave -noreg -logic {/tb_top/dut/regs_inst/FIFO_ALMOST_EMPTY}
add wave -noreg -logic {/tb_top/dut/regs_inst/FIFO_FULL}
add wave -noreg -logic {/tb_top/dut/regs_inst/FIFO_EMPTY}
add wave -noreg -logic {/tb_top/dut/regs_inst/FIFO_OVERFLOW}
add wave -noreg -logic {/tb_top/dut/regs_inst/FIFO_UNDERFLOW}
add wave -noreg -logic {/tb_top/dut/regs_inst/ERROR}
add wave -noreg -logic {/tb_top/dut/regs_inst/ENABLE}
add wave -noreg -logic {/tb_top/dut/regs_inst/MODE}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/FORMAT}
add wave -noreg -logic {/tb_top/dut/regs_inst/RUN}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/AFULL_THRESH}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/AEMPTY_THRESH}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/ZERO_HIGH_TIMING}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/ZERO_LOW_TIMING}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/ONE_HIGH_TIMING}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/ONE_LOW_TIMING}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/RESET_CYCLE_TIMING}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/RESET_CODE_TIMING}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/GPO}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/GPO_OE}

add wave -named_row "Internal" -bold -height 32 -color 255,0,0
add wave -noreg -logic {/tb_top/dut/regs_inst/overflow_reg}
add wave -noreg -logic {/tb_top/dut/regs_inst/underflow_reg}
add wave -noreg -logic {/tb_top/dut/regs_inst/mode_reg}
add wave -noreg -logic {/tb_top/dut/regs_inst/enable_reg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/format_reg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/afull_thresh_reg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/aempty_thresh_reg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/zero_high_timing_reg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/zero_low_timing_reg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/one_high_timing_reg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/one_low_timing_reg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/reset_cycle_timing_reg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/reset_code_timing_reg}
add wave -noreg -logic {/tb_top/dut/regs_inst/run_reg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/gpo_reg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/gpo_oe_reg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/scratch_pad_1_reg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/scratch_pad_2_reg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/scratch_pad_3_reg}
add wave -noreg -hexadecimal -literal {/tb_top/dut/regs_inst/scratch_pad_4_reg}
add wave -noreg -hexadecimal -literal -signed2 {/tb_top/dut/regs_inst/MIN_TIMING}
cursor "Cursor 1" 0ps  
transcript on
