`include "header.v"
module m_cycle_cpu(clock,reset);

    //输入
    input clock;
    input reset;

    wire [31:0] npc;
    wire [31:0] pc;
    wire [31:0] inst_in, inst;
    wire [4:0] rs; //读寄存器1
    wire [4:0] rt; //读寄存器2
    wire [4:0] rd;
    wire reg_write;
    wire [31:0] a, a_in;  
    wire [31:0] b, b_in;
    wire [31:0] b1;
    wire [31:0] c, c_in;
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
    wire [31:0] npc_t;
    wire [25:0] instr_index;
    wire zero;
    wire [1:0] s;
    wire r31;
    wire pc_write;
    wire ir_write;
    wire a_write, b_write, c_write;

    assign npc_t = pc + 4;
    assign op = inst [31:26];
    assign rs = inst [25:21];
	assign rt = inst [20:16];
	assign rd = inst [15:11];
    assign funct = inst [5:0];
    assign imm = inst [15:0];
    assign instr_index = inst [25:0];
    assign num_write = r31 ? 5'd31 : (regdst ? rd : rt);
    assign b1 = alusrc ? eximm : b;
    assign bus_out = r31 ? (pc + 4) : (memread ? data_out : c);

    pc PC(.pc(pc),.clock(clock),.reset(reset),.npc(npc),.pc_write(pc_write));
    im IM(.instruction(inst_in),.pc(pc));
    ctrl CTRL(.clk(clock),.rst(reset),.reg_write(reg_write),.aluop(aluop),.op(op),.funct(funct),.regdst(regdst),.extop(extop),.alusrc(alusrc),.memwrite(memwrite),.memread(memread),.s(s),.r31(r31),.pc_write(pc_write),.ir_write(ir_write),.a_write(a_write),.b_write(b_write),.c_write(c_write));
    ext EXT(.imm16(imm),.ext_op(extop),.imm32(eximm));
    gpr GPR(.a(a_in),.b(b_in),.clock(clock),.reg_write(reg_write),.num_write(num_write),.rs(rs),.rt(rt),.data_write(bus_out));
    alu ALU(.c(c_in),.a(a),.b(b1),.aluop(aluop),.zero(zero));
    npc NPC(.npc(npc),.npc_t(npc_t),.instr_index(instr_index),.offset(eximm),.a(a),.zero(zero),.s(s));
    dm DM(.data_out(data_out),.clock(clock),.mem_write(memwrite),.address(c),.data_in(b));
    fsm IR(.clk(clock),.in(inst_in),.out(inst),.write(ir_write));
    fsm ADR(.clk(clock),.in(a_in),.out(a),.write(a_write));
    fsm BDR(.clk(clock),.in(b_in),.out(b),.write(b_write));
    fsm CDR(.clk(clock),.in(c_in),.out(c),.write(c_write));

endmodule