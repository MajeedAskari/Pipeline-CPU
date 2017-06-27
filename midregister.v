module ifidReg(input NOP, enable, clk, input [31:0] inst, input [31:0] pc4in, output reg [31:0] instout, output reg [31:0] pc4out);


initial begin
	instout = 32'hff000000;
end

always@(posedge clk) begin
	if (NOP == 1)
	begin
		instout = 32'hff000000;
	end
	else if(enable == 1'b1 && NOP == 1'b0)
		begin
			instout = inst;
			pc4out = pc4in;	
		end
end	 
endmodule					


module idexReg(input NOP,
  input clk, input [31:0] inst, input [31:0] pc4in, input [31:0] rd1, input [31:0] rd2, input [31:0] se1, input [27:0] sl1,
  output reg [31:0] instout, output reg [31:0] pc4out, output reg [31:0] rd1out, output reg [31:0] rd2out, output reg [31:0] se1out,
  output reg [27:0] sl1out
  );

initial begin
  instout = 32'hff000000;
end

always@(posedge clk) begin
if (NOP == 1)
	begin
		instout = 32'hff000000;
	end
else
	begin
    	instout = inst;
    	pc4out = pc4in;
    	rd1out = rd1;
    	rd2out = rd2;
    	se1out = se1;
    	sl1out = sl1;
	end

end   
endmodule	



module exmemReg(input NOP,
	input clk, input [31:0] inst, input [31:0] pc4in, input [31:0] aluresult, input [31:0] rd2, input [4:0] regDst, input Zero, input [31:0] adder1res,
	output reg [31:0] instout, output reg [31:0] aluresultout, output reg [31:0] rd2out, output reg [31:0] pc4out,
	output reg [4:0] regDstout, output reg Zeroout, output reg [31:0] adder1resout,
	);

initial begin
	instout = 32'hff000000;
end

always@(posedge clk) begin
	if (NOP == 1)
	begin
		instout = 32'hff000000;
	end
	else
	begin
		instout = inst;
		pc4out = pc4in;
		aluresultout = aluresult;
		rd2out = rd2;
		regDstout = regDst;
		Zeroout = Zero;
		adder1resout = adder1res; 
	end
	
end	 
endmodule

module memwbReg(
	input clk, input [31:0] inst, input [31:0] aluresult, input [31:0] readdata, input [4:0] regDst,
	output reg [31:0] instout, output reg [31:0] aluresultout, output reg [31:0] readdataout,
	output reg [4:0] regDstout,
	);

initial begin
	instout = 32'hff000000;
end

always@(posedge clk) begin
	instout = inst;
	aluresultout = aluresult;
	readdataout = readdata;
	regDstout = regDst;
end	 
endmodule