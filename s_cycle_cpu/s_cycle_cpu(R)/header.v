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