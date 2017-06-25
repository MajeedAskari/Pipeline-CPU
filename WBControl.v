
module WBControl(
  input [5:0] opcode,
  output reg MemtoReg, output reg RegWrite,
  );


 always@(opcode,funct) begin
  case (opcode)
    5'b0 : // R-Type
	begin
	  MemtoReg = 0;
	  RegWrite = 1;
	end
    6'b001000 : // addi
	begin
	  MemtoReg = 0;
	  RegWrite = 1;
	end
    6'b000010 : // j
	begin
	  MemtoReg = 0;
	  RegWrite = 0;
	end
    6'b001101 : // ori
	begin
	  MemtoReg = 0;
	  RegWrite = 1;
	end
    6'b001100 : // andi
	begin
	  MemtoReg = 0;
	  RegWrite = 1;
	end
    6'b001010 : // slti
	begin
	  MemtoReg = 0;
	  RegWrite = 1;
	end
    6'b101011 : // sw
	begin
	  MemtoReg = 0;
	  RegWrite = 0;
	end
    6'b100011 : // lw
	begin
	  MemtoReg = 1;
	  RegWrite = 1;
	end
    6'b000100 : // beq
	begin
	  MemtoReg = 1;
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







