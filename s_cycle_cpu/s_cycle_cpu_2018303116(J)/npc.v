`include "header.v"
module npc(npc,npc_t,instr_index,offset,a,zero,s);

    output reg [31:0] npc;
    input [31:0] npc_t;  //npc_t = pc+4
    input [25:0] instr_index;
    input [31:0] offset;  //指令低16位符号扩展
    input [31:0] a;  //alu模块a输出
    input zero;   //alu模块zero输出
    input [1:0] s;  //ctrl模块产生，确定当前指令类型

    always @(*)
		begin
		npc = npc_t;
			case(s)
				`NONE: npc = npc_t;
				`BEQ:
					begin
						if(zero)
							npc = npc_t + {offset[29:0], 2'b00};
						else
							npc = npc_t;
					end
				`J_JAL: npc = {npc_t[31:28], instr_index, 2'b00};
				`JR: npc = a;
				
				default:	npc = 32'hxxxxxxxx;
			endcase
		end

endmodule