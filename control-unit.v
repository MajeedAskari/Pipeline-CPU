module Control(
  input [5:0] opcode,input [5:0] funct,
  output reg RegDst,Jump,Branch,MemRead,MemtoReg,
  output reg [3:0] aluo,
  output reg MemWrite,AluSrc,RegWrite,bne
  );


 always@(opcode,funct) begin
if(opcode == 6'b000101)
bne = 1'b1;
else bne = 1'b0;
	
  case (opcode)
    6'b0 : // R-Type
	begin
	  RegDst = 1;
	  Jump = 0;
	  Branch = 0;
	  MemRead = 0;
	  MemtoReg = 0;
	  case(funct)
	    6'b100000 : aluo=0000;  // add
	    6'b100010 : aluo=0001;  // sub
	    6'b100100 : aluo=0010;  // and
	    6'b100101 : aluo=0011;  // or
	    6'b101010 : aluo=0111;  // slt
	  endcase
	  MemWrite = 0;
	  AluSrc = 0;
	  RegWrite = 1;
	end
    6'b001000 : // addi
	begin
	  RegDst = 0;
	  Jump = 0;
	  Branch = 0;
	  MemRead = 0;
	  MemtoReg = 0;
	  aluo=0000; //add
	  MemWrite = 0;
	  AluSrc = 1;
	  RegWrite = 1;
	end
    6'b000010 : // j
	begin
	  RegDst = 0;
	  Jump = 1;
	  Branch = 0;
	  MemRead = 0;
	  MemtoReg = 0;
	  aluo=0010;
	  MemWrite = 0;
	  AluSrc = 0;
	  RegWrite = 0;
	end
    6'b001101 : // ori
	begin
	  RegDst = 0;
	  Jump = 0;
	  Branch = 0;
	  MemRead = 0;
	  MemtoReg = 0;
	  aluo=0011; //or
	  MemWrite = 0;
	  AluSrc = 1;
	  RegWrite = 1;
	end
    6'b001100 : // andi
	begin
	  RegDst = 0;
	  Jump = 0;
	  Branch = 0;
	  MemRead = 0;
	  MemtoReg = 0;
	  aluo=0010; //and
	  MemWrite = 0;
	  AluSrc = 1;
	  RegWrite = 1;
	end
    6'b001010 : // slti
	begin
	  RegDst = 0;
	  Jump = 0;
	  Branch = 0;
	  MemRead = 0;
	  MemtoReg = 0;
	  aluo=1111; //slt
	  MemWrite = 0;
	  AluSrc = 1;
	  RegWrite = 1;
	end
    6'b101011 : // sw
	begin
	  RegDst = 0;
	  Jump = 0;
	  Branch = 0;
	  MemRead = 0;
	  MemtoReg = 0;
	  aluo=0000; //add
	  MemWrite = 1;
	  AluSrc = 1;
	  RegWrite = 0;
	end
    6'b100011 : // lw
	begin
	  RegDst = 0;
	  Jump = 0;
	  Branch = 0;
	  MemRead = 1;
	  MemtoReg = 1;
	  aluo=0000; //add
	  MemWrite = 0;
	  AluSrc = 1;
	  RegWrite = 1;
	end
    6'b000100 : // beq
	begin
	  RegDst = 0;
	  Jump = 0;
	  Branch = 1;
	  MemRead = 0;
	  MemtoReg = 1;
	  aluo=0001; //sub
	  MemWrite = 0;
	  AluSrc = 0;
	  RegWrite = 0;
	end
    6'b000101 : // bne
	begin
	  RegDst = 0;
	  Jump = 0;
	  Branch = 1;
	  MemRead = 0;
	  MemtoReg = 1;
	  aluo=0001; //sub
	  MemWrite = 0;
	  AluSrc = 0;
	  RegWrite = 0;
	end
    endcase
end
endmodule 