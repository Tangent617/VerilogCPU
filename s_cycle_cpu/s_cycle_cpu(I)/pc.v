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