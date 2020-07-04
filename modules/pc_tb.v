`timescale 10ns / 10ns
module pc_tb;

wire [31:0] PC;
reg CLOCK;
reg RESET;
reg [31:0] NPC;

pc PC_TEST (PC, CLOCK, RESET, NPC);

initial
    $monitor("monitor CLOCK = %d, RESET = %d, NPC = %8h : PC = %8h", CLOCK, RESET, NPC, PC);

always
    begin
        #5 CLOCK = ~CLOCK;
    end

initial
    begin
        CLOCK = 1;
        RESET = 1;
        NPC = 32'h0000_0000;
        #2 RESET = 0; NPC = 32'h0000_2000;
        #4 RESET = 1;
        #10 NPC = 32'h0000_2000;
        #10 NPC = 32'h0001_0000;
        #20 $finish;
    end

endmodule