//此测试程序针对于添加完跳转指令后最终的单周期CPU
//不需要修改，配套code_fibonacci2.txt使用
`timescale 10ns/1ns
module s_cycle_cpu_tb;

reg CLOCK;
reg RESET;

s_cycle_cpu CPU(CLOCK,RESET);

always
   #5 CLOCK = ~CLOCK;
   
initial
    $readmemh("code_fibonacci2.txt", CPU.IM.ins_memory); //用code_fibonacci3.txt初始化指令存储器
   	   
integer i;

initial
   begin
	  CLOCK = 1; RESET = 1;
	  #2 RESET = 0;
	     for(i=0;i<32;i=i+1)
		    CPU.GPR.gp_registers[i] = 0;   
	  #4 RESET = 1;	
   end  
   
always @(CPU.PC.pc)
	begin
		if(CPU.PC.pc == 32'h0000_3054)//程序最后一条指令地址
		  begin
		   $display("display execute time is %6d",$time);
		   $display("display ----------------------------------------------------");
		   #50 for(i=0;i<32;i=i+1)//仿真结束时打印寄存器的值
			        $display("display gp_registers[%2d] = %8h",i,CPU.GPR.gp_registers[i]);
			   $display("display ----------------------------------------------------");
		       for(i=0;i<64;i=i+1)//仿真结束时打印数据存储器前32个字的值
			        $display("display data_memory[%2d] = %8h",i,CPU.DM.data_memory[i]);
			   $finish;
		  end
	end
endmodule