module CPU();

wire [31:0] mux4TOpc, pcTOadder1, instruction, pc4, adder2TOmux3, readdata1TOalu, readdata2TOmux2,jump_address,
	signextendTOshiftleft2, mux2TOalu, shiftleft2TOadder2, mux3TOmux4,aluresult, memory_readdata, mux5TOwritedata;
wire [27:0] shift1TOmux4, sl1Dec;
wire [4:0] mux1TOregfile, regDstEX, regDstMEM;
wire [3:0] aluControlOut;
wire RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, AluSrc, RegWrite, andTOmux3, aluzero, lt, gt, bne, ZeroEX;

wire [31:0] instructionFetch, pc4Fetch,
	instructionDec, pc4Dec, rd1Dec, rd2Dec, seDec,
	instructionEX, pc4EX, aluresultEX, rd2EX, adder2resEX,
	instructionMEM,	aluresultMEM, readdataMEM; 

reg clk;
initial
clk = 0;
always
#1000 clk = ~clk;		

assign jump_address = {pc4Dec[31:28],sl1Dec};




//IF
PC pc(mux4TOpc,pcTOadder1,clk);														
IMemBank instmemory( 1'b1, pcTOadder1[7:0],instruction);				   
Adder adder1(pcTOadder1,32'b00000000000000000000000000000100,pc4);
mux32 mux3(pc4,adder2resEX, andTOmux3, mux3TOmux4);
mux32 mux4(mux3TOmux4, jump_address, Jump, mux4TOpc);
//IF

// IF/ID	
ifidReg ifid(clk, instruction, pc4, instructionFetch, pc4Fetch);	

//ID	
RegFile regfile(clk,instructionFetch [25:21], instructionFetch [20:16], regDstMEM, mux5TOwritedata, RegWrite, readdata1TOalu, readdata2TOmux2);
ShiftLeft26 shift1(instructionFetch[25:0],shift1TOmux4);
SignExtend signextend(instructionFetch [15:0],signextendTOshiftleft2);
//ID

//	ID/EX
idexReg idex(clk, instructionFetch, pc4Fetch, readdata1TOalu, readdata2TOmux2, signextendTOshiftleft2, shift1TOmux4,
	instructionDec, pc4Dec, rd1Dec, rd2Dec, seDec,
	sl1Dec
	);
 
//EX
Adder adder2(pc4Dec, shiftleft2TOadder2,adder2TOmux3);
ShiftLeft32 shift2(seDec, shiftleft2TOadder2);
ALU alu(rd1Dec, mux2TOalu, aluControlOut, aluresult, aluzero, lt, gt);
mux32 mux2(rd2Dec, seDec, AluSrc, mux2TOalu);
mux5 mux1(instructionDec [20:16],instructionDec [15:11], RegDst,mux1TOregfile);

ALUControl aluctrl(instructionDec [31:26], instructionDec[5:0], RegDst, Jump, aluControlOut, AluSrc );

//EX  

//	EX/MEM
exmemReg exmem(clk, instructionDec, pc4Dec, aluresult, rd2Dec, mux1TOregfile, aluzero, adder2TOmux3,
	instructionEX, aluresultEX, rd2EX, pc4EX,
	regDstEX, ZeroEX, adder2resEX
	);

//MEM
DMemBank datamemory(MemRead, MemWrite, aluresultEX[7:0], rd2EX, memory_readdata);
branch b1(ZeroEX, Branch, bne,andTOmux3);
MEMControl memctrl(instructionEX [31:26], Branch, MemRead, MemWrite, bne);
//MEM

//	MEM/WB
memwbReg memwb(clk, instructionEX, aluresultEX, memory_readdata, regDstEX,
	instructionMEM, aluresultMEM, readdataMEM,
	regDstMEM
	);

//WB
mux32 mux5(aluresultMEM, readdataMEM, MemtoReg, mux5TOwritedata);
WBControl wbcontrol(instructionMEM [31:26] , MemtoReg, RegWrite);
//WB





//Control ctrl(instruction[31:26], instruction[5:0], RegDst, Jump, Branch, MemRead, MemtoReg, aluControlOut, MemWrite, AluSrc, RegWrite, bne);//done
endmodule
