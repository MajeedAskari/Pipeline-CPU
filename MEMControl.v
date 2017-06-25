module Control(
  input [5:0] opcode,
  output reg Jump,Branch,MemRead,
  output reg MemWrite,bne
  );


 always@(opcode) begin
if(opcode == 6'b000101)
bne = 1'b1;
else bne = 1'b0;

  case (opcode)
    5'b0 : // R-Type
	begin
	  Jump = 0;
	  Branch = 0;
	  MemRead = 0;
	  MemWrite = 0;
	end
    6'b001000 : // addi
	begin
	  Jump = 0;
	  Branch = 0;
	  MemRead = 0;
	  MemWrite = 0;
	end
    6'b000010 : // j
	begin
	  Jump = 1;
	  Branch = 0;
	  MemRead = 0;
	  MemWrite = 0;
	end
    6'b001101 : // ori
	begin
	  Jump = 0;
	  Branch = 0;
	  MemRead = 0;
	  MemWrite = 0;
	end
    6'b001100 : // andi
	begin
	  Jump = 0;
	  Branch = 0;
	  MemRead = 0;
	  MemWrite = 0;
	end
    6'b001010 : // slti
	begin
	  Jump = 0;
	  Branch = 0;
	  MemRead = 0;
	  MemWrite = 0;
	end
    6'b101011 : // sw
	begin
	  Jump = 0;
	  Branch = 0;
	  MemRead = 0;
	  MemWrite = 1;
	end
    6'b100011 : // lw
	begin
	  Jump = 0;
	  Branch = 0;
	  MemRead = 1;
	  MemWrite = 0;
	end
    6'b000100 : // beq
	begin
	  Jump = 0;
	  Branch = 1;
	  MemRead = 0;
	  MemWrite = 0;
	end
    6'b000101 : // bne
	begin
	  Jump = 0;
	  Branch = 1;
	  MemRead = 0;
	  MemWrite = 0;
	end
    endcase
end
endmodule 