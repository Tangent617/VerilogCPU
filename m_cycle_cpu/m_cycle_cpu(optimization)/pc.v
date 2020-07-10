module pc(pc,clock,reset,npc,pc_write);

    output reg [31:0] pc;
    input clock;
    input reset;
    input [31:0] npc;
    input pc_write;

    always @(posedge clock or negedge reset)
        begin
            if (!reset)
                pc <= 32'h00003000;
            else if (pc_write)
                pc <= npc;
        end

endmodule