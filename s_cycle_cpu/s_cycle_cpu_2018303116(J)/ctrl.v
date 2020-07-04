`include "header.v"
module ctrl(reg_write,aluop,op,funct,regdst,extop,alusrc,memwrite,memread,s,r31);

    output reg reg_write;
    output reg [2:0] aluop;
    input [5:0] op;
    input [5:0] funct;
    output reg extop;
	output reg alusrc;
	output reg regdst;
    output reg memread;
	output reg memwrite;
    output reg [1:0] s;
    output reg r31;

    always @(*)
		begin
            reg_write = 1'bx; regdst = 1'bx; extop = 1'bx; alusrc = 1'bx; aluop = 5'bxxxxx; memwrite = 1'bx; memread = 1'bx; s = `NONE; r31 = 1'b0;
			case(op)
				`op_R:
					begin
                        reg_write = 1; regdst = 1; extop = 0; alusrc = 0; memwrite = 0; memread = 0;
                        case (funct)
                            `funct_addu: aluop = `ADD;
                            `funct_subu: aluop = `SUB;
                            `funct_add: aluop = `ADD;
                            `funct_and: aluop = `AND;
                            `funct_or: aluop = `OR;
                            `funct_slt: aluop = `SLT;
                            `funct_jr: begin reg_write = 0; s = `JR; end
                        endcase
					end
                `op_addi: begin reg_write = 1; regdst = 0; extop = 1; alusrc = 1; aluop = `ADD; memwrite = 0; memread = 0; end
                `op_addiu: begin reg_write = 1; regdst = 0; extop = 1; alusrc = 1; aluop = `ADD; memwrite = 0; memread = 0; end
                `op_andi: begin reg_write = 1; regdst = 0; extop = 0; alusrc = 1; aluop = `AND; memwrite = 0; memread = 0; end
                `op_ori: begin reg_write = 1; regdst = 0; extop = 0; alusrc = 1; aluop = `OR; memwrite = 0; memread = 0; end
                `op_lui: begin reg_write = 1; regdst = 0; extop = 0; alusrc = 1; aluop = `LUI; memwrite = 0; memread = 0; end
                `op_lw: begin reg_write = 1; regdst = 0; extop = 1; alusrc = 1; aluop = `ADD; memwrite = 0; memread = 1; end
                //`op_sw: begin reg_write = 0; regdst = 1; extop = 1; alusrc = 1; aluop = `ADD; memwrite = 1; memread = 0; end
                `op_sw: begin reg_write = 0; extop = 1; alusrc = 1; aluop = `ADD; memwrite = 1; end
                `op_beq: begin reg_write = 0; regdst = 1; extop = 1; alusrc = 0; aluop = `SUB; memwrite = 0; s = `BEQ; end
                `op_j: begin reg_write = 0; memwrite = 0; s = `J_JAL; end
                `op_jal: begin reg_write = 1; regdst = 0; alusrc = 0; aluop = `EQB; memwrite = 0; memread = 0; s = `J_JAL; r31 = 1; end
					
			endcase
		end

endmodule