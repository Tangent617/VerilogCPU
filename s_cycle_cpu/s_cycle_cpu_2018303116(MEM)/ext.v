module ext (
	input [15:0] immediate, 
	input ExtSel, 
	output [31:0] extended_immediate
    );
	assign extended_immediate = (ExtSel)?{{16{immediate[15]}}, immediate[15:0]}
											:{{16{1'b0}}, immediate[15:0]};
endmodule