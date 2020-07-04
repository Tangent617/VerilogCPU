//aluop
`define ADD 3'b000
`define SUB 3'b001
`define AND 3'b010
`define OR  3'b011
`define SLT 3'b100
`define LUI 3'b101
//funct (when op=0)
`define funct_addu  6'b100001
`define funct_subu  6'b100011
`define funct_add   6'b100000
`define funct_and   6'b100100
`define funct_or    6'b100101
`define funct_slt   6'b101010
`define funct_jr    6'b001000
//op
`define op_R        6'b000000
`define op_addi     6'b001000
`define op_addiu    6'b001001
`define op_andi     6'b001100
`define op_ori      6'b001101
`define op_lui      6'b001111