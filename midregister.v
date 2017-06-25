module ifidReg(input clk, input [31:0] inst, input [31:0] pc4in, output reg [31:0] instout, output reg [31:0] pc4out);


reg	[31:0] instruction, pc4;

initial begin
	instout = 32'h00000020;
end

always@(posedge clk) begin
	instout = inst;
	pc4out = pc4in;
end	 
endmodule					


module idexReg(
	input clk, input [31:0] inst, input [31:0] pc4in, input [31:0] rd1, input [31:0] rd2, input [31:0] se,
	output reg [31:0] instout, output reg [31:0] pc4out, output reg [31:0] rd1out, output reg [31:0] rd2out, output reg [31:0] seout
	);


reg	[31:0] instruction, pc4;

initial begin
	instout = 32'h00000020;
end

always@(posedge clk) begin
	instout = inst;
	pc4out = pc4in;
	rd1out = rd1;
	rd2out = rd2;
	seout = se;
end	 
endmodule	



module exmemReg(
	input clk, input [31:0] inst, input [31:0] aluresult, input [31:0] rd2, input [4:0] regDst, input Zero, input [31:0] adder1res,
	output reg [31:0] instout, output reg [31:0] aluresultout, output reg [31:0] rd2out,
	output reg [4:0] regDstout, output reg Zeroout, output reg [31:0] adder1resout,
	);


reg	[31:0] instruction, pc4;

initial begin
	instout = 32'h00000020;
end

always@(posedge clk) begin
	instout = inst;
	aluresultout = aluresult;
	rd2out = rd2;
	regDstout = regDst;
	Zeroout = Zero;
	adder1resout = adder1res;
end	 
endmodule

module memwbReg(
	input clk, input [31:0] inst, input [31:0] aluresult, input [31:0] readdata, input [4:0] regDst,
	output reg [31:0] instout, output reg [31:0] aluresultout, output reg [31:0] readdataout,
	output reg [4:0] regDstout,
	);


reg	[31:0] instruction, pc4;

initial begin
	instout = 32'h00000020;
end

always@(posedge clk) begin
	instout = inst;
	aluresultout = aluresult;
	readdataout = readdata;
	regDstout = regDst;
end	 
endmodule