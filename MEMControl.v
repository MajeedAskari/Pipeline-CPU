module MEMControl(
  input [5:0] opcode,
  output reg Branch,MemRead,
  output reg MemWrite,bne
  );


 always@(opcode) begin
if(opcode == 6'b000101)
bne = 1'b1;
else bne = 1'b0;

  case (opcode)
	6'b111111 : // NOP
	begin
	  Branch = 0;
	  MemRead = 0;
	  MemWrite = 0;
	end
	
    6'b0 : // R-Type
	begin
	  Branch = 0;
	  MemRead = 0;
	  MemWrite = 0;
	end
    6'b001000 : // addi
	begin
	  Branch = 0;
	  MemRead = 0;
	  MemWrite = 0;
	end
    6'b000010 : // j
	begin
	  Branch = 0;
	  MemRead = 0;
	  MemWrite = 0;
	end
    6'b001101 : // ori
	begin
	  Branch = 0;
	  MemRead = 0;
	  MemWrite = 0;
	end
    6'b001100 : // andi
	begin
	  Branch = 0;
	  MemRead = 0;
	  MemWrite = 0;
	end
    6'b001010 : // slti
	begin
	  Branch = 0;
	  MemRead = 0;
	  MemWrite = 0;
	end
    6'b101011 : // sw
	begin
	  Branch = 0;
	  MemRead = 0;
	  MemWrite = 1;
	end
    6'b100011 : // lw
	begin
	  Branch = 0;
	  MemRead = 1;
	  MemWrite = 0;
	end
    6'b000100 : // beq
	begin
	  Branch = 1;
	  MemRead = 0;
	  MemWrite = 0;
	end
    6'b000101 : // bne
	begin
	  Branch = 1;
	  MemRead = 0;
	  MemWrite = 0;
	end
    endcase
end
endmodule 