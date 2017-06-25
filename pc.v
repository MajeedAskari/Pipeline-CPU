module PC(input [31:0] in, output [31:0] out, input clk);
reg [31:0] counter;

initial
counter = 32'b0;

assign out = counter;

always@(posedge clk)
counter  = in;

endmodule 
