module Adder(input [31:0] in1, input [31:0] in2, output reg [31:0] result);

  always@(in1, in2)
  begin    
     result = in1 + in2;      
  end  

endmodule
