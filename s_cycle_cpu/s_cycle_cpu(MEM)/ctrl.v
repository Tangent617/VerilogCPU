`include "header.v"
module ctrl(reg_write,aluop,op,funct,regdst,extop,alusrc,memwrite,memread);

    output reg reg_write;
    output reg [2:0] aluop;
    input [5:0] op;
    input [5:0] funct;
    output reg extop;
	output reg alusrc;
	output reg regdst;
    output reg memread;
	output reg memwrite;

    /*assign reg_write = (op == `op_R)? 1 : 0;
    assign aluop =  (op == `op_R) ? (funct == `funct_addu) ? `ADD:
                                    (funct == `funct_subu) ? `SUB:
                                    (funct == `funct_add) ? `ADD:
                                    (funct == `funct_and) ? `AND:
                                    (funct == `funct_or) ? `OR:
                                    (funct == `funct_slt) ? `SLT:
                                                            `ADD:
                    (op == `op_addi) ? `ADD:
                    (op == `op_addiu) ? `ADD:
                    (op == `op_andi) ? `AND:
                    (op == `op_ori) ? `OR:
                    (op == `op_lui) ? `LUI:
                    `ADD; */
    always @(*)
		begin
            reg_write = 0; regdst = 0; extop = 0; alusrc = 1; aluop = `ADD; memwrite = 0; memread = 0;
			case(op)
				`op_R:
					begin
                        reg_write = 1; regdst = 1; extop = 0; alusrc = 0;
                        case (funct)
                            `funct_addu: aluop = `ADD;
                            `funct_subu: aluop = `SUB;
                            `funct_add: aluop = `ADD;
                            `funct_and: aluop = `AND;
                            `funct_or: aluop = `OR;
                            `funct_slt: aluop = `SLT;
                        endcase
					end
                `op_addi: begin reg_write = 1; regdst = 0; extop = 1; alusrc = 1; aluop = `ADD; end
                `op_addiu: begin reg_write = 1; regdst = 0; extop = 1; alusrc = 1; aluop = `ADD; end
                `op_andi: begin reg_write = 1; regdst = 0; extop = 0; alusrc = 1; aluop = `AND; end
                `op_ori: begin reg_write = 1; regdst = 0; extop = 0; alusrc = 1; aluop = `OR; end
                `op_lui: begin reg_write = 1; regdst = 0; extop = 0; alusrc = 1; aluop = `LUI; end
                `op_lw: begin reg_write = 1; regdst = 0; extop = 1; alusrc = 1; aluop = `ADD; memwrite = 0; memread = 1; end
                `op_sw: begin reg_write = 0; regdst = 1; extop = 1; alusrc = 1; aluop = `ADD; memwrite = 1; memread = 0; end
					
			endcase
		end

endmodule