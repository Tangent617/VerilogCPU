//此测试程序针对于I型指令和MEM型指令

`timescale 10ns/1ns
module s_cycle_cpu_tb;

reg CLOCK;
reg RESET;

s_cycle_cpu CPU(CLOCK,RESET);

always
   #5 CLOCK = ~CLOCK;
//加载要执行的程序到im
//程序自己写，然后从Mars导出   
initial
   $readmemh("code_MEM.txt",CPU.IM.ins_memory); //用code_MEM.txt初始化指令存储器
//根据需要给数据存储器和寄存器堆设置初值 
//需要加载的数据自己编  
initial
   $readmemh("data_gpr.txt",CPU.GPR.gp_registers); //用cdata_gpr.txt初始化寄存器堆
   
initial
   $readmemh("data_dm.txt",CPU.DM.data_memory); //用data_dm.txt初始化数据存储器
   

integer i;
initial
   begin
	  CLOCK = 0; RESET = 1;
	  #2 RESET = 0;
	  #4 RESET = 1;
	  #130 for(i=0;i<10;i=i+1)//仿真结束时打印寄存器的值
			 $display("display gp_registers[%2d] = %8h",i,CPU.GPR.gp_registers[i]);
		   for(i=0;i<10;i=i+1)//仿真结束时打印数据存储器的值
			 $display("display data_memory[%2d] = %8h",i,CPU.DM.data_memory[i]);
	  $finish;
			
   end
   
endmodule