#******************************************************************************
#
#  Copyright (c) 2019-2020 LucAce
#
#  Permission is hereby granted, free of charge, to any person obtaining a
#  copy of this software and associated documentation files (the "Software"),
#  to deal in the Software without restriction, including without limitation
#  the rights to use, copy, modify, merge, publish, distribute, sublicense,
#  and/or sell copies of the Software, and to permit persons to whom the
#  Software is furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
#  DEALINGS IN THE SOFTWARE.
#
#******************************************************************************

# Set the BASE_PATH variable to the root of the project files
set BASE_PATH "C:\Temp\MachXO2-SpiPixelController"

cd $BASE_PATH/sim/lib

if {![file exists rtl_verilog]} {
    vlib rtl_verilog
}
endif

design create rtl_verilog .
design open rtl_verilog
adel -all

cd $BASE_PATH/sim

vlog -dbg ../rtl/fifo_dc_efb.v
vlog -dbg ../rtl/slave_efb.v
vlog -dbg ../rtl/ctrl.v
vlog -dbg ../rtl/regs.v
vlog -dbg ../rtl/ser.v
vlog -dbg ../rtl/top.v

vlog -dbg tb/tb_gpo.v

vsim +access +r -L ovi_machxo2 -PL pmi_work tb_top

do waves/wave_tb.do

run -all
