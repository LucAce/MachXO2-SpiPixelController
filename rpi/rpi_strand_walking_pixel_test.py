#!/usr/bin/python3
#******************************************************************************
#
# Copyright (c) 2019-2020 LucAce
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
#******************************************************************************
#
# File:  rpi_strand_walking_pixel_test.py
# Date:  Sun Aug 18 12:00:00 EDT 2019
#
# Functional Description:
#
#   Raspberry Pi Strand Walking Pixel Test
#
# Notes:
#
#   - Raspbery Pi SPI Master Code
#   - RPi Board Pin 36 is used as an Active Low FPGA Logic Reset
#   - RPi CE0 is used for the FPGA User SPI Slave Chip Select
#
#******************************************************************************

import sys
import time
import spidev
import RPi.GPIO as GPIO

def spi_transfer(msg):
    count = 0
    sys.stdout.write("TX:")
    for i in range(0, len(msg)):
        if (((count % 8) == 0) and (count != 0)):
            sys.stdout.write("\n    0x%02X" % msg[i])
        else:
            sys.stdout.write(" 0x%02X" % msg[i])
        count += 1
    sys.stdout.write("\n")

    count = 0
    retval = spi.xfer2(msg)
    sys.stdout.write("RX:")
    for i in range(0, len(retval)):
        if (((count % 8) == 0) and (count != 0)):
            sys.stdout.write("\n    0x%02X" % retval[i])
        else:
            sys.stdout.write(" 0x%02X" % retval[i])
        count += 1
    sys.stdout.write("\n")

    sys.stdout.flush()
    return retval

def hwid_read():
    sys.stdout.write("HW ID Read:\n")
    msg = [0xF0, 0x00, 0x00]
    retval = spi_transfer(msg)
    print()
    time.sleep(1)

def revision_read():
    sys.stdout.write("Revision Read:\n")
    msg = [0xF1, 0x00, 0x00]
    retval = spi_transfer(msg)
    print()
    time.sleep(1)

def reg_read(offset, wcount):
    sys.stdout.write("Register Read:\n")
    msg = [0x00, offset, 0x00]
    for i in range(0, wcount):
        msg.append(0x00)
    retval = spi_transfer(msg)
    print()
    time.sleep(1)

def reg_write(offset, wdata):
    sys.stdout.write("Register Write:\n")
    msg = [0x01, offset]
    for i in range(0, len(wdata)):
        msg.append(wdata[i])
    retval = spi_transfer(msg)
    print()
    time.sleep(1)

def rgb_load(rgb):
    sys.stdout.write("Load RGB:\n")
    msg = [0x04]
    msg.extend(rgb)
    retval = spi_transfer(msg)
    print()

def rgb_reset_code():
    sys.stdout.write("Load Reset Code:\n")
    msg = [0x07, 0xA5]
    retval = spi_transfer(msg)
    print()
    time.sleep(.5)


RESET_PIN = 36
BUS_ID = 0
DEVICE_ID = 0
LED_COUNT = 60

# Reset is on board pin 36
GPIO.setmode(GPIO.BOARD)
GPIO.setup(RESET_PIN, GPIO.OUT)

# Enable SPI
spi = spidev.SpiDev()
spi.open(BUS_ID, DEVICE_ID)

# Set SPI speed and mode
spi.max_speed_hz = 1953000
spi.mode = 0

print ("\nReset FPGA Fabric Logic")
GPIO.output(RESET_PIN, 0)
time.sleep(1)
GPIO.output(RESET_PIN, 1)
time.sleep(1)
print()

print ("Issue Hardware Protocol Command, 3 Bytes")
hwid_read()

print ("Issue Hardware Revision Command, 3 Bytes")
revision_read()

print ("Issue Register Write Command (Reset Code Timing), 3 Bytes")
reg_write(0x0C, [0xA0])

print ("Issue Register Reads Command (All Registers)")
reg_read(0x00, 0x0D)

print ("Issue Register Write Command (Scratch Pad), 6 Bytes")
reg_write(0xF2, [0x12, 0x34, 0x56, 0x78])
reg_read(0xF2, 4)

print ("Issue RGB Commands")
loop_count = 1
while (1):
    if loop_count == 1:
        on_color  = [0xFF, 0x00, 0x00]
        off_color = [0x00, 0x00, 0x00]
        loop_count = 2
    elif loop_count == 2:
        on_color  = [0x00, 0xFF, 0x00]
        off_color = [0x00, 0x00, 0x00]
        loop_count = 3
    elif loop_count == 3:
        on_color  = [0x00, 0x00, 0xFF]
        off_color = [0x00, 0x00, 0x00]
        loop_count = 4
    else:
        on_color  = [0xFF, 0xFF, 0xFF]
        off_color = [0x00, 0x00, 0x00]
        loop_count = 1

    # Forward Counting
    for i in range (0, LED_COUNT):
        msg = []
        for j in range (0, LED_COUNT):
            if j == i:
                msg.extend(on_color)
            else:
                msg.extend(off_color)

        rgb_load(msg)
        rgb_reset_code()

    # Backward Counting
    for i in range (LED_COUNT-2, -1, -1):
        msg = []
        for j in range (0, LED_COUNT):
            if j == i:
                msg.extend(on_color)
            else:
                msg.extend(off_color)

        rgb_load(msg)
        rgb_reset_code()

spi.close()
exit()
