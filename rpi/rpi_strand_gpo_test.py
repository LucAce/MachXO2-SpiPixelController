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
# File:  rpi_strand_gpo_test.py
# Date:  Sun Aug 18 12:00:00 EDT 2019
#
# Functional Description:
#
#   Raspberry Pi Strand Plus GPO Test
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

metrics = dict()
metrics['loop_count'] = 0
metrics['tx_sum']     = 0
metrics['tx_max']     = 0
metrics['tx_min']     = 10000
fc_count = 0
led_state = 0

def spi_transfer(msg, verbose):
    if (verbose == 1):
        count = 0
        sys.stdout.write("TX:")
        for i in range(0, len(msg)):
            if (((count % 8) == 0) and (count != 0)):
                sys.stdout.write("\n    0x%02X" % msg[i])
            else:
                sys.stdout.write(" 0x%02X" % msg[i])
            count += 1
        sys.stdout.write("\n")

    retval = spi.xfer2(msg)

    if (verbose == 1):
        count = 0
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
    retval = spi_transfer(msg, 1)
    print()

def revision_read():
    sys.stdout.write("Revision Read:\n")
    msg = [0xF1, 0x00, 0x00]
    retval = spi_transfer(msg, 1)
    print()

def reg_read(offset, wcount):
    sys.stdout.write("Register Read:\n")
    msg = [0x00, offset, 0x00]
    for i in range(0, wcount):
        msg.append(0x00)
    retval = spi_transfer(msg, 1)
    print()

def reg_write(offset, wdata):
    sys.stdout.write("Register Write:\n")
    msg = [0x01, offset]
    msg.extend(wdata)
    retval = spi_transfer(msg, 1)
    print()

def rgb_load(rgb):
    global fc_count

    msg = [0x04]
    msg.extend(rgb)
    retval = spi_transfer(msg, 0)

    # Wait until not Almost fulll
    while ((retval[-1] & 0x08) != 0x00):
        # print ("Flow Controlled")
        msg = [0x00, 0x00, 0x00, 0x00]
        retval = spi_transfer(msg, 0)
        fc_count += 1

def rgb_reset_code():
    global fc_count

    msg = [0x07, 0xA5]
    retval = spi_transfer(msg, 0)

    # Wait until not Almost fulll
    while ((retval[-1] & 0x08) !=0x00):
        # print ("Flow Controlled")
        msg = [0x00, 0x00, 0x00, 0x00]
        retval = spi_transfer(msg, 0)
        fc_count += 1


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
spi.max_speed_hz = 15600000
spi.mode = 0

print ("\nReset FPGA Fabric Logic")
GPIO.output(RESET_PIN, 0)
time.sleep(1)
GPIO.output(RESET_PIN, 1)
time.sleep(1)
print()

print ("Issue Hardware Protocol Command")
hwid_read()

print ("Issue Hardware Revision Command")
revision_read()

print ("Issue Register Write Command (Reset Code Timing)")
reg_write(0x0C, [0xA0])

print ("Issue Register Reads Command (All Registers)")
reg_read(0x00, 0x0D)

print ("Issue Register Write Command (Scratch Pad)")
reg_write(0xF2, [0x12, 0x34, 0x56, 0x78])
reg_read(0xF2, 4)

print ("Enabling LEDs")
reg_write(0xF1, [3])

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
    cdelta = 0
    for i in range (0, LED_COUNT):
        msg = []
        for j in range (0, LED_COUNT):
            if j == i:
                msg.extend(on_color)
            else:
                msg.extend(off_color)

        timestamp = time.time()
        rgb_load(msg)
        rgb_reset_code()
        delta = time.time() - timestamp
        cdelta += delta

        metrics['tx_sum'] += delta
        metrics['loop_count'] += 1
        if (delta > metrics['tx_max']):
            metrics['tx_max'] = delta
        if (delta < metrics['tx_min']):
            metrics['tx_min'] = delta

    # Backward Counting
    for i in range (0, LED_COUNT):
        msg = []
        for j in range (0, LED_COUNT):
            if (LED_COUNT-1-j) == i:
                msg.extend(on_color)
            else:
                msg.extend(off_color)

        timestamp = time.time()
        rgb_load(msg)
        rgb_reset_code()
        delta = time.time() - timestamp
        cdelta += delta

        metrics['tx_sum'] += delta
        metrics['loop_count'] += 1
        if (delta > metrics['tx_max']):
            metrics['tx_max'] = delta
        if (delta < metrics['tx_min']):
            metrics['tx_min'] = delta

    # Set PCB LED
    if (led_state == 0):
        reg_write(0xF0, [1])
        led_state = 1
    elif (led_state == 1):
        reg_write(0xF0, [2])
        led_state = 2
    elif (led_state == 2):
        reg_write(0xF0, [3])
        led_state = 3
    else:
        reg_write(0xF0, [0])
        led_state = 0

    # Render Average
    metrics['rend_avg'] = (metrics['tx_sum'] / metrics['loop_count'])
    print("LEDs: %1d; Current Render: %9f; TX Avg: %9f; TX Max: %9f, TX Min: %9f; Flow Control: %5d" % (LED_COUNT, cdelta, metrics['rend_avg'], metrics['tx_max'], metrics['tx_min'], fc_count))
    fc_count = 0

spi.close()
exit()
