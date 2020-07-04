`include "header.v"
module alu(c,a,b,aluop,zero);

    output reg signed [31:0] c;
    input signed [31:0] a;
    input signed [31:0] b;
    input [2:0] aluop;
    output reg zero;

    //always @(a or b or aluop)
    always @(*)
    begin
        zero = 0;
        case (aluop)
            `ADD: c <= a + b;
            `SUB: c <= a - b;
            `AND: c <= a & b;
            `OR: c <= a | b;
            `SLT: c <= $signed(a) < $signed(b) ? 32'd1 : 32'd0;
            `LUI: c <= b << 16;
            `EQB: c <= b;
            default: c <= b;
        endcase
        zero <= (c == 0) ? 1 : 0;
    end
    
endmodule