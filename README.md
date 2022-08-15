# Single-Cycle-32-bit-MIPS-Processor
## Introduction:
The project aims to implement a 32-bit single-cycle MIPS RISC (Reduced Instruction Set Computer) processor based on Harvard architecture using verilog HDL.
The processor is simulated on ***ModelSim*** tool, and Synthesis is made using ***Intel® Quartus® Prime*** and also implemented on ***Cyclone® IV FPGA***.

## MIPS Architecture:
![MIPS Architecture](https://user-images.githubusercontent.com/76248514/157418934-4f0b8410-d47a-46b3-9e9e-1b9cb26d3596.png)

## Top Module:
This processer is implemented using four different parts: Datapath, Control unit, Data memory and Instruction memory.

![MIPS Modules](https://user-images.githubusercontent.com/76248514/157419464-bfe28036-8732-4061-bfd6-741ea0b64957.png)

## Simulation results:
The project was tested on three different machine code programs:
#### Program 1: Calculate GCD of 180 and 120
![test_1_waveform](https://user-images.githubusercontent.com/82821323/184582707-480dd2c4-82ca-444e-980d-ab72b1866c01.png)

#### Program 2: Calculate factorial of number 6
![test_2_waveform](https://user-images.githubusercontent.com/82821323/184582727-66c9d9b4-66c6-4579-a6bb-fe6c6a4e051f.png)

#### Program 3: Outputs the Fibonacci series numbers sequentially
![test_3_waveform](https://user-images.githubusercontent.com/82821323/184582734-919e7ee9-2fce-4594-ab77-a323fd331a82.png)

## Reference:
David M. Harris, Sarah L. Harris - Digital Design and Computer Architecture, 2nd Edition.
