`include "header.v"
module alu(c,a,b,aluop);

    output reg signed [31:0] c;
    input signed [31:0] a;
    input signed [31:0] b;
    input [2:0] aluop;

    always @(a or b or aluop)
        case (aluop)
            `ADD: c = a + b;
            `SUB: c = a - b;
            `AND: c = a & b;
            `OR: c = a | b;
            `SLT: c = (a < b) ? 32'd1 : 32'd0;
            `LUI: c = b << 16;
            default: c = a + b;
        endcase
    
endmodule