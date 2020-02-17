# WS2812B Nominal Timing Register Values

WS2812 (v3) Nominal High+Low Timing: 1.25us +/- 600ns


### Logic 0 Timing

Logic 0 | Nominal (ns) | Tolerance (ns)
------- | ------------ | --------------
TOH     | 400          | 150
TOL     | 850          | 150
TOH+TOL | 1250         | 600


### Logic 1 Timing

Logic 1 | Nominal (ns) | Tolerance (ns)
------- | ------------ | --------------
T1H     | 850          | 150
T1L     | 400          | 150
T1H+T1L | 1250         | 600


### Reset Code

Operation  | Minimum (ns) | Tolerance (ns)
---------- | ------------ | --------------
Reset Code | 50000        | -


### Oscillator

Clock     | Frequency (Mhz) | Period (ns)
--------- | --------------- | --------------
OSCH      | 44.33           | 22.5581


### Logic 0 Register Values

Logic 0 | Divisor | Register Value | FPGA Timing (ns)
------- | ------- | -------------- | ----------------
TOH     | 17.732  | 18             | 406.05
TOL     | 37.6805 | 38             | 857.21
TOH+TOL | 55.4125 | 56             | 1263.25


### Logic 1 Register Values

Logic 1 | Divisor | Register Value  | FPGA Timing (ns)
------- | ------- | --------------- | ----------------
T1H     | 37.6805 | 38             | 857.21
T1L     | 17.732  | 18              | 406.05
T1H+T1L | 55.4125 | 56              | 1263.25


### Reset Code Register Value

Operation  | Divisor  | Register Value | FPGA Timing (ns)
---------- | -------- | -------------- | ----------------
Reset Code | 8.658203 | 9              | 51973.83

```
Notes:
1)  The Reset Code register value is multiplied by 256 in system.
```
