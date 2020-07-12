# VerilogCPU

![](https://img.shields.io/badge/language-Verilog-blue.svg) ![](https://img.shields.io/badge/license-MIT-000000.svg)

A mips CPU written by verilog.

## modules

Include some modules of a single cycle CPU which *only* support **addu** instruction.

- [dm](https://github.com/Tangent617/VerilogCPU/blob/master/modules/dm.v)
- [pc](https://github.com/Tangent617/VerilogCPU/blob/master/modules/pc.v)
- [gpr](https://github.com/Tangent617/VerilogCPU/blob/master/modules/gpr.v)
- [im](https://github.com/Tangent617/VerilogCPU/blob/master/modules/im.v)
- [alu](https://github.com/Tangent617/VerilogCPU/blob/master/modules/alu.v)
- [s_cycle_cpu](https://github.com/Tangent617/VerilogCPU/blob/master/modules/s_cycle_cpu.v)(ADDU)

and a [testbench for pc](https://github.com/Tangent617/VerilogCPU/blob/master/modules/pc_tb.v) to test the function of it.

## s_cycle_cpu

### R-type

Add support for R-type instructions including **addu**, **subu**, **add**, **and**, **or**, **slt**.

Add a [ctrl](https://github.com/Tangent617/VerilogCPU/blob/master/s_cycle_cpu/s_cycle_cpu(R)/ctrl.v) module to generate control signal according to the type of instruction.

### I-type

Add support for I-type instructions including **addi**, **addiu**, **andi**, **ori**, **lui** on the base of R-type CPU.

Add a [testbench](https://github.com/Tangent617/VerilogCPU/blob/master/s_cycle_cpu/s_cycle_cpu(I)/s_cycle_cpu_tb23.v) for testing.

### MEM-type

Add support for mem-type instructions including **lw**, **sw** on the base of I-type CPU.

### J-type

Add support for J-type instructions including **beq**, **j**, **jal**, **jr** on the base of MEM-type CPU.

Add a [npc](https://github.com/Tangent617/VerilogCPU/blob/master/s_cycle_cpu/s_cycle_cpu(J)/npc.v) module to calculate npc.

A new [testbench](https://github.com/Tangent617/VerilogCPU/blob/master/s_cycle_cpu/s_cycle_cpu(J)/s_cycle_cpu_tb4.v) and an [example program](https://github.com/Tangent617/VerilogCPU/blob/master/s_cycle_cpu/s_cycle_cpu(J)/code_fibonacci2.txt) which the tb requires.

## m_cycle_cpu

### no optimization

Change the single-cycle-cpu into a multi-cycle-cpu.

![m_cycle_cpu(no optimization)](https://course.educg.net/userfiles/image/2020/1594005653934007386.png)

### optimization

The multi-cycle-cpu after optimization that can reduce a clock cycle after R, I, lw and sw to increase running speed.

> Reference: https://github.com/anjianfeng/VerilogMIPS-multicycle-uart

## Next step

Add support for **sll**, **lb**, **blez**.

## In the end

😁 Welcome to create issues and pull requests.

😅 ***NOT*** welcome to copy this repo and submit as your own homework.

