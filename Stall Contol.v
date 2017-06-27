module StallControl (input [31:0] instructionFetch, instructionDEC, instructionEX, output reg pcenable, idexNOP, exmemNOP); 
wire validDestEX, validDestMEM;	
wire [4:0] destEX, destMEM	
destination destEXstage(instructionDEC, destEX, validDestEX);	
destination destMEMstage(instructionEX, destMEM, validDestMEM);	
	
always@(instructionFetch, instructionDEC, instructionEX)
	begin
		if (rs==ws || rt==ws){
  pcenable=1;
  muxenable=1;
  insenable=1;
  }
  
endmodule

  
  module destination(input [31:0] instruction, output reg [4:0] rd, output reg valid);
	always@(instruction)
		begin	
 		case (instruction [31:26])
  		6'b0 : // R-Type
  		begin
 			rd = instruction [15:11];
 			valid = 1;
 		end
  		6'b001000 : // addi
 		begin
 			rd = instruction [20:16];
			valid = 1;
 		end
  		6'b000010 : // j
 		begin
 			valid = 0;
 		end
 		6'b001101 : // ori
 		begin
 			rd = instruction [20:16];
 			valid =1;
 		end
  		6'b001100 : // andi
 		begin
  			rd = instruction [20:16];
 			valid = 1;
 		end
  		6'b001010 : // slti
 		begin
 			rd = instruction [20:16];
 			valid = 1;
 		end
  		6'b101011 : // sw
 		begin
 			rd = instruction [20:16];
 			valid = 0;
 		end
  		6'b100011 : // lw
 		begin
  			rd = instruction [20:16];
  			valid =1;
  		end
 		6'b000100 : // beq
 		begin
  			valid = 0;
  		end
 		6'b000101 : // bne
  		begin
 			valid = 0;
 		end
    endcase	
	end
  endmodule	 