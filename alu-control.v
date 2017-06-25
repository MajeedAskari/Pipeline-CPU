module aluControl(input [1:0] ALUOp, input [5:0] funct, output reg [3:0] aluo);

  always@(ALUOp,funct)
  case(ALUOp)
    2'b00 :
	aluo=0010; //add
    2'b01 :
	aluo=0110;
    2'b10 :
     case(funct)
       6'b100000 : aluo=0000;  // add
       6'b100010 : aluo=0001;  // sub
       6'b100100 : aluo=0010;  // and
       6'b100101 : aluo=0011;  // or
       6'b101010 : aluo=0111;  // slt
     endcase
   endcase
 endmodule
