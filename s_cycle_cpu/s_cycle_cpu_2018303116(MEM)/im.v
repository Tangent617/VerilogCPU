module im(instruction,pc);

    output [31:0] instruction;
    input [31:0] pc;

    reg [31:0] ins_memory[1023:0]; //4k指令存储器

    assign instruction = ins_memory[pc[11:0]>>2];

endmodule