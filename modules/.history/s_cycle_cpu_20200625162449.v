module s_cycle_cpu(clock,reset);

    //输入
    input clock;
    input reset;

    wire [31:0] data_out;
    wire [31:0] pc;
    wire [31:0] a;  
    wire [31:0] b;
    wire [31:0] instruction;
    wire [31:0] c;

    wire mem_write;
    wire [31:0] address;
    wire [31:0] data_in;
    wire [31:0] npc;
    wire reg_write;
    wire [4:0] rs; //读寄存器1
    wire [4:0] rt; //读寄存器2
    wire [4:0] num_write; //写寄存器
    wire [31:0] data_write; //写数据

    dm DM(.data_out(data_out),.clock(clock),.mem_write(mem_write),.address(address),.data_in(data_in));
    pc PC(.pc(pc),.clock(clock),.reset(reset),.npc(npc));
    gpr GPR(.a(a),.b(b),.clock(clock),.reg_write(reg_write),.num_write(num_write),.rs(rs),.rt(rt),.data_write(data_write));
    im IM(.instruction(instruction),.pc(pc));
    alu ALU(.c(c),.a(a),.b(b));

endmodule