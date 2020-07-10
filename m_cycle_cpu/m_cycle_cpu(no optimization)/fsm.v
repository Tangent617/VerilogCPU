module fsm(clk, in, out, write);

   output [31:0] out;

   input write;
   input [31:0] in;
   input clk;

   reg [31:0] data;

   always @(negedge clk) begin
      if (write)
         data <= in;
   end

   assign out = data;

endmodule