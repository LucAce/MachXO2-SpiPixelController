# WS2812 Nominal Timing Register Values

WS2812 Nominal High+Low Timing: 1.25us +/- 600ns


### Logic 0 Timing

Logic 0 | Nominal (ns) | Tolerance (ns)
------- | ------------ | --------------
TOH     | 350          | 150
TOL     | 800          | 150
TOH+TOL | 1150         | 600


### Logic 1 Timing

Logic 1 | Nominal (ns) | Tolerance (ns)
------- | ------------ | --------------
T1H     | 700          | 150
T1L     | 600          | 150
T1H+T1L | 1300         | 600


### Reset Code

Operation  | Minimum (ns) | Tolerance (ns)
---------- | ------------ | --------------
Reset Code | 50000        | -


### Oscillator

Clock     | Frequency (Mhz) | Period (ns)
--------- | --------------- | --------------
OSCH      | 44.33           | 22.5581


### Logic 0 Register Values

Logic 0 | Divisor  | Register Value | FPGA Timing (ns)
------- | -------- | -------------- | ----------------
TOH     | 15.5155  | 16             | 360.93
TOL     | 35.464   | 36             | 812.09
TOH+TOL | 50.9795  | 52             | 1173.02


### Logic 1 Register Values

Logic 1 | Divisor  | Register Value | FPGA Timing (ns)
------- | ------- | -------------- | ----------------
T1H     | 31.031  | 32             | 721.86
T1L     | 26.598  | 27             | 609.07
T1H+T1L | 57.629  | 59             | 1330.93


### Reset Code Register Value

Operation  | Divisor  | Register Value | FPGA Timing (ns)
---------- | -------- | -------------- | ----------------
Reset Code | 17.316   | 18             | 51973.83

```
Notes:
1)  The Reset Code register value is multiplied by 128 in system.
```
