//aluop
`define ADD 3'b000
`define SUB 3'b001
`define AND 3'b010
`define OR  3'b011
`define SLT 3'b100
`define LUI 3'b101
`define EQB 3'b110
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
`define op_sw       6'b101011
`define op_lw       6'b100011
`define op_beq      6'b000100
`define op_j        6'b000010
`define op_jal      6'b000011
//s
`define NONE        2'b00
`define BEQ         2'b01
`define J_JAL       2'b10
`define JR          2'b11