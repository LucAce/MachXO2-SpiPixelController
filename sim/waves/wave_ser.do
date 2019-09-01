onerror { resume }
transcript off
add wave

add wave -named_row "ser.v" -bold -height 32 -color 255,0,0
add wave -noreg -logic {/tb_top/dut/ser_inst/CLK}
add wave -noreg -logic {/tb_top/dut/ser_inst/RST_N}
add wave -noreg -logic {/tb_top/dut/ser_inst/ENABLE}
add wave -noreg -logic {/tb_top/dut/ser_inst/MODE}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/FORMAT}
add wave -noreg -logic {/tb_top/dut/ser_inst/RUN}
add wave -noreg -logic {/tb_top/dut/ser_inst/FIFO_RE}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/FIFO_RDATA}
add wave -noreg -logic {/tb_top/dut/ser_inst/FIFO_EMPTY}
add wave -noreg -logic {/tb_top/dut/ser_inst/FIFO_UNDERFLOW}
add wave -noreg -logic {/tb_top/dut/ser_inst/EOF}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/ZERO_HIGH_TIMING}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/ZERO_LOW_TIMING}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/ONE_HIGH_TIMING}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/ONE_LOW_TIMING}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/RESET_CYCLE_TIMING}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/RESET_CODE_TIMING}
add wave -noreg -logic {/tb_top/dut/ser_inst/SER_OUT}

add wave -named_row "Internal" -bold -height 32 -color 255,0,0
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/frsm_state}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/sosm_state}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/fbuf}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/fbuf_run}
add wave -noreg -logic {/tb_top/dut/ser_inst/fbuf_valid}
add wave -noreg -logic {/tb_top/dut/ser_inst/fbuf_ready}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/frsm_counter}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/bindex}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/timing_count}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/reset_count}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/zero_high_timing_i}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/zero_low_timing_i}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/one_high_timing_i}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/one_low_timing_i}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/reset_cycle_timing_i}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/reset_code_timing_i}
add wave -noreg -logic {/tb_top/dut/ser_inst/eof_empty}
add wave -noreg -logic {/tb_top/dut/ser_inst/eof_decr}
add wave -noreg -hexadecimal -literal {/tb_top/dut/ser_inst/eof_count}
cursor "Cursor 1" 0ps
transcript on
