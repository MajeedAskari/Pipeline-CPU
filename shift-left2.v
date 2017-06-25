module ShiftLeft26 (input [25:0] in,output [27:0] out);
  wire [25:0] temp;
  assign out = {in,2'b0};

endmodule		 

module ShiftLeft32 (input [31:0] in,output [31:0] out);
  wire [31:0] temp;
  
 // assign temp = in << 2;
  assign out = {in,2'b0};
endmodule 