`include "header.v"
module ctrl(clk,rst,reg_write,aluop,op,funct,regdst,extop,alusrc,memwrite,memread,s,r31,pc_write,ir_write,a_write,b_write,c_write);

    input clk;
    input rst;
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
    output reg pc_write;
    output reg ir_write;
    output reg a_write;
    output reg b_write;
    output reg c_write;
    reg [2:0]  stage;
    reg [2:0] nstage; // next stage

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            stage <= `IF;
        end
        else
            stage <= nstage;
    end

    always @(stage)
		begin
            reg_write = 0; /*regdst = 1'bx; extop = 1'bx; alusrc = 1'bx; aluop = 5'bxxxxx;*/ memwrite = 0; //memread = 1'bx; r31 = 0;
            pc_write = 0; ir_write = 0; a_write = 0; b_write = 0; c_write = 0;
            case (stage)
                `IF: begin
                    ir_write = 1;
                    s = `NONE;
                    nstage = `ID;
                end
                `ID: begin
                    nstage = `EX;
                    regdst = 0;
                    alusrc = 1;
                    memread = 0;
                    a_write = 1;
                    b_write = 1;
                    r31 = 0;
                    case(op)
                        `op_j: begin
                            s = `J_JAL;
                            nstage = `IF;
                            pc_write = 1;
                        end
                        `op_jal: begin
                            s = `J_JAL;
                            nstage = `WB;
                            pc_write = 1;
                            reg_write = 1;
                            r31 = 1;
                        end
                        `op_R: begin
                            alusrc = 0;
                            regdst = 1;
                            pc_write = 1;
                            case(funct)
                                `funct_jr: begin
                                    s = `JR;
                                end
                            endcase
                        end
                        `op_addi, `op_addiu: begin extop = 1; pc_write = 1; end
                        `op_andi, `op_ori, `op_lui: begin extop = 0; pc_write = 1; end
                        `op_lw: begin extop = 1; pc_write = 1; memread = 1; end
                        `op_sw: begin extop = 1; pc_write = 1; end
                        `op_beq: s = `BEQ;
                    endcase
                end
                `EX: begin
                    nstage = `WB;
                    alusrc = 1; // I type
                    c_write = 1;
                    reg_write = 1;
                    case(op)
                        `op_R: begin
                            alusrc = 0;
                            case(funct)
                                `funct_add:  aluop = `ADD;
                                `funct_addu: aluop = `ADD;
                                `funct_subu: aluop = `SUB;
                                `funct_and:  aluop = `AND;
                                `funct_or:   aluop = `OR;
                                `funct_slt:  aluop = `SLT;
                                `funct_jr: begin
                                    nstage = `IF;
                                    s = `JR;
                                    pc_write = 1;
                                end
                            endcase
                        end
                        `op_addi, `op_addiu: aluop = `ADD;
                        `op_andi: aluop = `AND;
                        `op_ori: aluop = `OR;
                        `op_lui: aluop = `LUI;
                        `op_lw, `op_sw: begin
                            nstage = `MEM;
                            aluop = `ADD;
                            alusrc = 1;
                            reg_write = 0;
                        end
                        `op_beq: begin
                            nstage = `IF;
                            reg_write = 0;
                            alusrc = 0;
                            aluop = `SUB;
                            s = `BEQ;
                            pc_write = 1;
                        end
                    endcase
                end
                `MEM: begin
                    case (op)
                        `op_lw: begin
                            nstage = `WB;
                            reg_write = 1;
                        end
                        `op_sw: begin
                            nstage = `ID;
                            memwrite = 1;
                            ir_write = 1;
                            s = `NONE;
                        end
                        default: nstage = 3'bxxx;
                    endcase
                end
                `WB: begin
                    nstage = `IF;
                    reg_write = 0;
                    case(op)
                        `op_R: begin ir_write = 1; s = `NONE; nstage = `ID; end
                        `op_addi, `op_addiu, `op_andi, `op_ori, `op_lui: begin ir_write = 1; s = `NONE; nstage = `ID; end
                        `op_lw: begin ir_write = 1; s = `NONE; nstage = `ID; end
                        `op_jal: reg_write = 0;
                    endcase
                end
                default: nstage = 3'bxxx;
            endcase
		end

endmodule