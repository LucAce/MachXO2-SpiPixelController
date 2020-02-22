# Device Registers

The device registers are accessed using the SPI Register Read and Register Write commands.  The second byte
of those commands is the Address or Offset to a specific register.


## Device Register Map

Offset | Register Name               | Bit 7 | Bit 6  | Bit 5    | Bit 4     | Bit 3 | Bit 2 | Bit 1   | Bit 0
------ | --------------------------- | ----- | ------ | -------- | --------- | ----- | ----- | ------- | -----
0x00   | Status Register             | -     | WERROR | OVERFLOW | UNDERFLOW | AF    | AE    | F       | E
0x01   | Configuration Register      | -     | -      | -        | -         | -     | -     | Mode    | Enable
0x02   | Format Register             | 7     | 6      | 5        | 4         | 3     | 2     | 1       | 0
0x03   | Almost Full - MSB Register  | -     | -      | -        | -         | -     | 10    | 9       | 8
0x04   | Almost Full - LSB Register  | 7     | 6      | 5        | 4         | 3     | 2     | 1       | 0
0x05   | Almost Empty - MSB Register | -     | -      | -        | -         | -     | 10    | 9       | 8
0x06   | Almost Empty - LSB Register | 7     | 6      | 5        | 4         | 3     | 2     | 1       | 0
0x07   | Zero High Timing Register   | 7     | 6      | 5        | 4         | 3     | 2     | 1       | 0
0x08   | Zero Low Timing Register    | 7     | 6      | 5        | 4         | 3     | 2     | 1       | 0
0x09   | One High Timing Register    | 7     | 6      | 5        | 4         | 3     | 2     | 1       | 0
0x0A   | One Low Timing Register     | 7     | 6      | 5        | 4         | 3     | 2     | 1       | 0
0x0B   | Reset Cycle Timing Register | 7     | 6      | 5        | 4         | 3     | 2     | 1       | 0
0x0C   | Reset Code Timing Register  | 7     | 6      | 5        | 4         | 3     | 2     | 1       | 0
0x0D   | Run-Stop Register           | -     | -      | -        | -         | -     | -     | -       | Run
0xF0   | GPO Value Register          | -     | -      | -        | -         | -     | -     | GPO1    | GPO0
0xF1   | GPO Enable Register         | -     | -      | -        | -         | -     | -     | GPO1_EN | GPO0_EN
0xF2   | Scratch Pad 1 Register      | 7     | 6      | 5        | 4         | 3     | 2     | 1       | 0
0xF3   | Scratch Pad 2 Register      | 7     | 6      | 5        | 4         | 3     | 2     | 1       | 0
0xF4   | Scratch Pad 3 Register      | 7     | 6      | 5        | 4         | 3     | 2     | 1       | 0
0xF5   | Scratch Pad 4 Register      | 7     | 6      | 5        | 4         | 3     | 2     | 1       | 0


## Register Field Types

Type       | Description
---------- | -----------
RO         | Read Only Field
RW         | Read and Write Field
W1C        | Write One Clear Field


## Offset: 0x00 - Status Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7          | RO         | 1'b0       | Reserved
6          | W1C        | 1'b0       | Write Error
5          | W1C        | 1'b0       | FIFO Overflow Error
4          | W1C        | 1'b0       | FIFO Underflow Error
3          | RO         | 1'b0       | FIFO Almost Full
2          | RO         | 1'b1       | FIFO Almost Empty
1          | RO         | 1'b0       | FIFO Full
0          | RO         | 1'b1       | FIFO Empty

```
Notes:
1) Write Error is set when a timing register is written when the FIFO is not empty.
2) FIFO Overflow Error indicates that a Load or Reset command was issued but the FIFO was full.
3) FIFO Underflow Error indicates that the device inserted a Reset Code because there were no
   more pixels in the FIFO to process.  This is only set when operating in continuous mode.
```


## Offset: 0x01 - Configuration Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:2        | RO         | 6'h00      | Reserved
1          | RW         | 1'b0       | Mode - 1'b0: Wait for Reset 1'b1: Continuous
0          | RW         | 1'b1       | Enable


## Offset: 0x02 - Format Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:6        | RW         | 2'b10      | Transmit MSB (31:24); 2’b11: White; 2’b10: Red; 2’b01: Green; 2’b00: Blue
5:4        | RW         | 2'b10      | Transmit MSB (23:15); 2’b11: White; 2’b10: Red; 2’b01: Green; 2’b00: Blue
3:2        | RW         | 2'b01      | Transmit MSB (15: 8); 2’b11: White; 2’b10: Red; 2’b01: Green; 2’b00: Blue
1:0        | RW         | 2'b11      | Transmit MSB ( 7: 0); 2’b11: White; 2’b10: Red; 2’b01: Green; 2’b00: Blue

```
Notes:
1) The Format Register allows the reordering of WRGB/RGB values from the SPI.  It is assumed
   that the WRGB/RGB data from the host will always by received in WRGB format and that the
   Format Register will be used to reorder based on the LED strips requirements.
1) If using an RGB strip set bits 7:6 and 5:4 to the same value which will indicate RGB instead of WRGB mode.
2) The default value is set for WS2812B LEDs where the transmit order is GRB.
```


## Offset: 0x03 - FIFO Almost Full Most Significant Byte Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:3        | RO         | 5'h00      | Reserved
2:0        | RW         | 3'h3       | FIFO Almost Full Register Value bits 10-8

```
Notes:
1) The design does not protect against register tearing.  It is recommened that this value is only
   changed when the FIFO is empty or the output is disabled.
```


## Offset: 0x04 - FIFO Almost Full Least Significant Byte Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:0        | RW         | 8'h99      | FIFO Almost Full Register Value bits 7-0

```
Notes:
1) The design does not protect against register tearing.  It is recommened that this value is only
   changed when the FIFO is empty or the output is disabled.
```


## Offset: 0x05 - FIFO Almost Empty Most Significant Byte Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:3        | RO         | 5'h00      | Reserved
2:0        | RW         | 3'h0       | FIFO Almost Empty Register Value bits 10-8

```
Notes:
1) The design does not protect against register tearing.  It is recommened that this value is only
   changed when the FIFO is empty or the output is disabled.
```


## Offset: 0x06 - FIFO Almost Empty Least Significant Byte Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:0        | RW         | 8'h67      | FIFO Almost Empty Register Value bits 7-0

```
Notes:
1) The design does not protect against register tearing.  It is recommened that this value is only
   changed when the FIFO is empty or the output is disabled.
```


## Offset: 0x07 - Zero High Timing Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:0        | RW         | 8'h12      | Number of clock cycles a WS2812B “Zero” value will be driven high (1)


## Offset: 0x08 - Zero Low Timing Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:0        | RW         | 8'h26      | Number of clock cycles a WS2812B “Zero” value will be driven low (0)



## Offset: 0x09 - One High Timing Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:0        | RW         | 8'h26      | Number of clock cycles a WS2812B “One” value will be driven high (1)


## Offset: 0x0A - One Low Timing Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:0        | RW         | 8'h12      | Number of clock cycles a WS2812B “One” value will be driven low (0)


## Offset: 0x0B - Reset Cycle Timing Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:0        | RW         | 8'h38      | Number of clock cycles a zero will be driven.

```
Notes:
1) This is useful for precise reset control.  Typically when wanting to insert more reset cycles but
   not as many as a Reset Code.
```


## Offset: 0x0C - Reset Code Timing Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:0        | RW         | 8'h09      | Number of clock cycles times 256 a Reset Code will be driven.  Reset Code is driven between LED updates to signal the end of the shifting.


## Offset: 0x0D - Run Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:1        | RO         | 7'h00      | Reserved
0          | RW         | 1'b1       | When set to one the controller will stream out RGB values when they are present in the FIFO.


## Offset: 0xF0 - General Purpose Output Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:2        | RO         | 6'h00      | Reserved
1          | RW         | 1'b0       | General Purpose Bit 1 output value.
0          | RW         | 1'b0       | General Purpose Bit 0 output value.


## Offset: 0xF1 - General Purpose Output Enable Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:2        | RO         | 6'h00      | Reserved
1          | RW         | 1'b0       | General Purpose Bit 1 output enable; 1'b0: General Purpose Bit 1 is tri-stated; 1'b1: General Purpose Bit 1 is driven with the GPO 1 value.
0          | RW         | 1'b0       | General Purpose Bit 0 output enable; 1'b0: General Purpose Bit 1 is tri-stated; 1'b1: General Purpose Bit 1 is driven with the GPO 0 value.


## Offset: 0xF2 - Scratch Pad 1 Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:0        | RW         | 8'h00      | General purpose scratch register.


## Offset: 0xF3 - Scratch Pad 2 Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:0        | RW         | 8'h00      | General purpose scratch register.


## Offset: 0xF4 - Scratch Pad 3 Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:0        | RW         | 8'h00      | General purpose scratch register.


## Offset: 0xF5 - Scratch Pad 4 Register

Bits       | Type       | Reset      | Description
---------- | ---------- | ---------- | -----------
7:0        | RW         | 8'h00      | General purpose scratch register.
