module alu(c,a,b);

    output [31:0] c;
    input [31:0] a;
    input [31:0] b;

    assign c = a + b;

endmodule