/*module ext (
	input [15:0] immediate, 
	input ExtSel, 
	output [31:0] extended_immediate
    );
	assign extended_immediate = (ExtSel)?{{16{immediate[15]}}, immediate[15:0]}
											:{{16{1'b0}}, immediate[15:0]};
endmodule*/

module ext(imm16, ext_op, imm32);

    output reg [31:0] imm32;
    input ext_op;
    input [15:0] imm16;

    always @(*) begin
        case (ext_op)
            0: imm32 = {{16{1'b0}}, imm16};
            1: imm32 = {{16{imm16[15]}}, imm16};
        endcase
    end

endmodule