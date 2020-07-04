`include "header.v"
module ctrl(reg_write,aluop,op,funct);

    output reg_write;
    output [2:0] aluop;
    input [5:0] op;
    input [5:0] funct;

    assign reg_write = (op == `op_R)? 1 : 0;
    assign aluop = (op == `op_R) ?  (funct == `funct_addu) ? `ADD:
                                    (funct == `funct_subu) ? `SUB:
                                    (funct == `funct_add) ? `ADD:
                                    (funct == `funct_and) ? `AND:
                                    (funct == `funct_or) ? `OR:
                                    (funct == `funct_slt) ? `SLT:
                                                            `ADD:
                                    `ADD;

endmodule