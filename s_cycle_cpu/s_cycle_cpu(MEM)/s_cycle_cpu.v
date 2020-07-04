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
    wire [31:0] b1;
    wire [31:0] c;
    wire [2:0] aluop;
    wire [5:0] op;
    wire [5:0] funct;
    wire regdst;
	wire extop;
	wire alusrc;
	wire [15:0] imm;
    wire [31:0] eximm;
    wire [4:0] num_write;
    wire memwrite;
    wire memread;
    //wire [31:0] data_in;
	wire [31:0] data_out;
    wire [31:0] bus_out;

    pc PC(.pc(pc),.clock(clock),.reset(reset),.npc(npc));
    assign npc = pc + 4;
    im IM(.instruction(instruction),.pc(pc));
    assign op = instruction [31:26];
    assign rs = instruction [25:21];
	assign rt = instruction [20:16];
	assign rd = instruction [15:11];
    assign funct = instruction [5:0];
    assign imm = instruction [15:0];
	assign num_write = regdst ? rd : rt;
    ctrl CTRL(.reg_write(reg_write),.aluop(aluop),.op(op),.funct(funct),.regdst(regdst),.extop(extop),.alusrc(alusrc),.memwrite(memwrite),.memread(memread));
    ext EXT(.immediate(imm), .ExtSel(extop), .extended_immediate(eximm));
    gpr GPR(.a(a),.b(b),.clock(clock),.reg_write(reg_write),.num_write(num_write),.rs(rs),.rt(rt),.data_write(bus_out));
    assign b1 = alusrc ? eximm : b;
    alu ALU(.c(c),.a(a),.b(b1),.aluop(aluop));
    dm DM(.data_out(data_out),.clock(clock),.mem_write(memwrite),.address(c),.data_in(b));
    assign bus_out = memread ? data_out : c;

endmodule