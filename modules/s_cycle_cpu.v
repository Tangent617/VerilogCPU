module s_cycle_cpu(clock,reset);

    //输入
    input clock;
    input reset;

    wire [31:0] npc;
    wire [31:0] pc;
    wire [31:0] instruction;
    wire [4:0] rs; //读寄存器1
    wire [4:0] rt; //读寄存器2
    wire [4:0] rd;
    wire reg_write;
    wire [31:0] a;
    wire [31:0] b;
    wire [31:0] c;

    pc PC(.pc(pc),.clock(clock),.reset(reset),.npc(npc));
    assign npc = pc + 4;
    im IM(.instruction(instruction),.pc(pc));
    assign rs = instruction [25:21];
	assign rt = instruction [20:16];
	assign rd = instruction [15:11];
    assign reg_write = 1;
    gpr GPR(.a(a),.b(b),.clock(clock),.reg_write(reg_write),.num_write(rd),.rs(rs),.rt(rt),.data_write(c));
    alu ALU(.c(c),.a(a),.b(b));

endmodule