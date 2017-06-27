module StallControl (input s, input [31:0] instructionFetch, instructionDEC, instructionEX, instructionWB,
	output reg pcenable, idifenable, idexNOP, ifidNOP, exmemNOP);
	
	
wire validDestEX, validDestMEM, validDestWB, validRs, validRt;	
wire [4:0] destEX, destMEM, destWB, rs, rt;

destination destEXstage(instructionDEC, destEX, validDestEX);	
destination destMEMstage(instructionEX, destMEM, validDestMEM);
destination destWBstage(instructionWB, destWB, validDestWB);
source src(instructionFetch, rs, validRs, rt, validRt);		   

initial
	begin
		pcenable = 1;
		idifenable = 1;
		idexNOP = 0;
		ifidNOP = 0;
		exmemNOP = 0;
	end

	
	always@(instructionFetch, instructionDEC, instructionEX, instructionWB)
	#20 begin
		// if data hazard
		if ((validDestEX == 1'b1 && validRs == 1'b1 && rs == destEX) || (validDestEX == 1'b1 && validRt == 1'b1 && rt == destEX)
			|| (validDestMEM == 1'b1 && validRs == 1'b1 && rs == destMEM) || (validDestMEM == 1'b1 && validRt == 1'b1 && rt == destMEM)
			|| (validDestWB == 1'b1 && validRs == 1'b1 && rs == destWB) || (validDestWB == 1'b1 && validRt == 1'b1 && rt == destWB))
		begin
			pcenable = 0;
			idifenable = 0;
			idexNOP = 1;
			ifidNOP = 0;
		end
		
		else if(instructionFetch [31:26] == 6'b000010 || instructionDEC	[31:26] == 6'b000010) // jump stall
			begin
				ifidNOP = 1;
			end	
			
		else if((instructionEX [31:26] == 6'b000100 || instructionEX [31:26] == 6'b000101) && s == 1)
			begin
				ifidNOP = 1;
				idexNOP = 1;
				exmemNOP = 1;
			end
		else
		begin
			pcenable = 1;
			idifenable = 1;
			idexNOP = 0;
			ifidNOP = 0;
			exmemNOP = 0;
		end	
		
   end
endmodule






  
  module destination(input [31:0] instruction, output reg [4:0] rd, output reg valid);
	always@(*)
	begin	
 		case (instruction [31:26])
		6'b111111 : // NOP
		begin
			valid = 0;
		end
		
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
 			valid = 1;
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
  			valid = 1;
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
	
  
  module source(input [31:0] instruction, output reg [4:0] rs, output reg validrs, output reg [4:0] rt,output reg validrt );
  always@(instruction)
    begin  
     case (instruction [31:26])
	  6'b111111 : // NOP
	 begin
	 	validrs = 0;
		validrt = 0;
	 end
	  
     6'b0 : // R-Type
     begin
      	rs = instruction [25:21];
      	validrs = 1;
     	rt = instruction [20:16];
     	validrt = 1;
     end
	 
      6'b001000 : // addi
     begin
     	rs = instruction [25:21];
     	validrs = 1;
     	validrt = 0;
     end
	 
     6'b000010 : // j
     begin
     	validrs = 0;
     	validrt = 0;
     end
	 
     6'b001101 : // ori
     begin
     	rs = instruction [25:21];
     	validrs = 1;
     	validrt = 0;
     end
      6'b001100 : // andi
     begin
     	rs = instruction [25:21];
     	validrs = 1;
     	validrt = 0;
     end
	 
      6'b001010 : // slti
     begin
     	rs = instruction [25:21];
      	validrs = 1;
     	validrt = 0;
     end
	 
      6'b101011 : // sw
     begin
     	rs = instruction [25:21];
     	validrs = 1;
     	rt = instruction [20:16];
     	validrt = 1;
     end
	 
      6'b100011 : // lw
     begin
     	rs = instruction [25:21];
     	validrs = 1;
     	validrt = 0;
     end
	 
     6'b000100 : // beq
     begin
     	rs = instruction [25:21];
     	validrs = 1;
     	rt = instruction [20:16];
     	validrt = 1;
     end
	 
     6'b000101 : // bne
     begin
     	rs = instruction [25:21];
     	validrs = 1;
     	rt = instruction [20:16];
    	validrt = 1;
     end
	 
    endcase  
  end
  endmodule