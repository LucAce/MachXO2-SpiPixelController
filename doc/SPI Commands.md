# SPI Commands

SPI is a serialzied byte interface and by itself does not define a communication
protocol.  The following SPI communication protocol is used to operate the
SpiPixelController.

Command          | Command Byte | Address Byte | Dummy Byte | Data Byte(s)
---------------- | ------------ | ------------ | ---------- | ------------
Hardware ID      | 0xF0         | -            | 1          | 1
Revision Number  | 0xF1         | -            | 1          | 1
Register Read    | 0x00         | 1            | 1          | 1+
Register Write   | 0x01         | 1            | -          | 1+
Load RGB         | 0x04         | -            | -          | 1+ (3 Bytes for each LED)
Load WRGB        | 0x05         | -            | -          | 1+ (4 Bytes for each LED)
Load Reset Cycle | 0x06         | -            | -          | 1+
Load Reset Code  | 0x07         | -            | -          | 1+

```
Notes:
1) Command fields with "-" indicate they are not present.
2) During Load RGB, Load WRGB, Load Reset Cycle and Load Reset Code commands the
   Status Register value is returned on the MISO. The Status Register has fields
   for the state of the FIFO and can be used for flow control by the Master.
3) During Reset Cycle and Code commands the data byte value is ignored but for
   each byte an additional reset (either cycle or code) will be inserted.
4) Dummy Bytes allow for the FPGA to fetch and load TX buffers and are required
   where indicated.
```
