module ALUControl(
  input [5:0] opcode,input [5:0] funct,
  output reg RegDst,
  output reg Jump,
  output reg [3:0] aluo,
  output reg AluSrc
  );


 always@(opcode,funct) begin

  case (opcode)
	  
	6'b111111 : // NOP
	begin
	  RegDst = 0;
	  Jump = 0;
	  aluo = 0000; //add
	  AluSrc = 0;
	end
	
    6'b0 : // R-Type
	begin
	  RegDst = 1;
	  Jump = 0;
	  case(funct)
	    6'b100000 : aluo=0000;  // add
	    6'b100010 : aluo=0001;  // sub
	    6'b100100 : aluo=0010;  // and
	    6'b100101 : aluo=0011;  // or
	    6'b101010 : aluo=0111;  // slt
	  endcase
	  AluSrc = 0;
	end
    6'b001000 : // addi
	begin
	  RegDst = 0;
	  Jump = 0;
	  AluSrc = 1;
	end
    6'b000010 : // j
	begin
	  Jump = 1;
	  RegDst = 0;
	  aluo=0010;
	  AluSrc = 0;
	end
    6'b001101 : // ori
	begin
	  RegDst = 0;
	  aluo=0011; //or
	  AluSrc = 1;
	  Jump = 0;
	end
    6'b001100 : // andi
	begin
	  RegDst = 0;
	  aluo=0010; //and
	  AluSrc = 1;
	  Jump = 0;
	end
    6'b001010 : // slti
	begin
	  RegDst = 0;
	  aluo=1111; //slt
	  AluSrc = 1;
	  Jump = 0;
	end
    6'b101011 : // sw
	begin
	  RegDst = 0;
	  aluo=0000; //add
	  AluSrc = 1;
	  Jump = 0;
	end
    6'b100011 : // lw
	begin
	  RegDst = 0;
	  aluo=0000; //add
	  AluSrc = 1;
	  Jump = 0;
	end
    6'b000100 : // beq
	begin
	  RegDst = 0;
	  aluo=0001; //sub
	  AluSrc = 0;
	  Jump = 0;
	end
    6'b000101 : // bne
	begin
	  RegDst = 0;
	  aluo=0001; //sub
	  AluSrc = 0;
	  Jump = 0;
	end
    endcase
end
endmodule 