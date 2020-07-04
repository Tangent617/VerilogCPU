module pc(pc,clock,reset,npc);

    output [31:0] pc;
    input clock;
    input reset;
    input [31:0] npc;

    reg [31:0] data;

    always @(posedge clock or negedge reset)
        begin
            if (reset == 0)
                data <= 32'h00003000;
            else
                data <= npc;
        end

    assign pc = data;

endmodule

module im(instruction,pc);

    output [31:0] instruction;
    input [31:0] pc;

    reg [31:0] ins_memory[1023:0]; //4k指令存储器

    assign instruction = ins_memory[pc[11:0]>>2];

endmodule

module gpr(a,b,clock,reg_write,num_write,rs,rt,data_write);

    output [31:0] a;  
    output [31:0] b;
    input clock;
    input reg_write;
    input [4:0] rs; //读寄存器1
    input [4:0] rt; //读寄存器2
    input [4:0] num_write; //写寄存器
    input [31:0] data_write; //写数据

    reg [31:0] gp_registers[31:0];  //32个寄存器
    integer i;

    initial
    begin
        for (i = 0; i < 32; i = i + 1)
            gp_registers[i] = 32'b0;
    end

    assign a = gp_registers[rs];
    assign b = gp_registers[rt];

    always @(posedge clock)
    begin
        if (reg_write == 1 && num_write != 0)
            gp_registers[num_write] <= data_write;
    end

endmodule

module alu(c,a,b);

    output [31:0] c;
    input [31:0] a;
    input [31:0] b;

    assign c = a + b;

endmodule

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
    gpr GPR(.a(a),.b(b),.clock(clock),.reg_write(reg_write),.num_write(rd),.rs(rs),.rt(rt),.data_write(c));
    alu ALU(.c(c),.a(a),.b(b));

endmodule