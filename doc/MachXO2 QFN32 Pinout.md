# SpiPixelController Device Pinout

FPGA Function | Dual Function | QFN32 Pin | Design Signal
------------- | ------------- | --------- | -------------
PL9A          | PCLKT3_0      | 4         | LED_OUT
PL9B          | PCLKC3_0      | 5         | ERROR
VCCIO3        | -             | 6         | 3.3V
VCCIO2        | -             | 7         | 3.3V
PB4C          | CSSPIN        | 8         | -
PB6C          | MCLK/CCLK     | 9         | SCLK
PB6D          | SO/SPISO      | 10        | MISO
PB9A          | PCLKT2_0      | 11        | GPO[1]
PB9B          | PCLKC2_0      | 12        | GPO[0]
PB11A         | PCLKT2_1      | 13        | RST_N
PB11B         | PCLKC2_1      | 14        | SCSN
VCCIO2        | -             | 15        | 3.3V
PB20C         | SN            | 16        | -
PB20D         | SI/SISPI      | 17        | MOSI
VCC           | -             | 18        | 3.3V
VCCIO1        | -             | 19        | 3.3V
PR5D          | PCLKC1_0      | 20        | FIFO_AEMPTY
PR5C          | PCLKT1_0      | 21        | FIFO_AFULL
PT17D         | DONE          | 23        | -
VCCIO0        | -             | 24        | 3.3V
PT15D         | PROGRAMN      | 25        | -
PT15C         | JTAGENB       | 26        | -
PT12D         | SDA/PCLKC0_0  | 27        | -
PT12C         | SCL/PCLKT0_0  | 28        | -
PT11D         | TMS           | 29        | -
PT11C         | TCK           | 30        | -
VCCIO0        | -             | 31        | 3.3V
PT10D         | TDI           | 32        | -
PT10C         | TDO           | 1         | -
VCC           | -             | 2         | 3.3V
GND           | -             | 3         | GND
GND           | -             | 22        | GND


# TinyFPGA AX2 Implementation Pinout

FPGA Function | Dual Function | Design Signal | QFN32 Pin | TinyFPGA AX2 Pin
------------- | ------------- | ------------- | --------- | ----------------
VCC           | -             | -             | Multiple  | 3.3V
GND           | -             | -             | Multiple  | GND
PL9A          | PCLKT3_0      | LED_OUT       | 4         | 16
PL9B          | PCLKC3_0      | ERROR         | 5         | 17
PB6C          | MCLK/CCLK     | SCLK          | 9         | 19
PB6D          | SO/SPISO      | MISO          | 10        | 20
PB9A          | PCLKT2_0      | GPO[1]        | 11        | 21
PB9B          | PCLKC2_0      | GPO[0]        | 12        | 22
PB11A         | PCLKT2_1      | RST_N         | 13        | 1
PB11B         | PCLKC2_1      | SCSN          | 14        | 2
PB20D         | SI/SISPI      | MOSI          | 17        | 4
PR5D          | PCLKC1_0      | FIFO_AEMPTY   | 20        | 5
PR5C          | PCLKT1_0      | FIFO_AFULL    | 21        | 6
