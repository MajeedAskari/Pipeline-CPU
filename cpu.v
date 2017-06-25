module CPU();

wire [31:0] mux4TOpc, pcTOadder1, instruction, adder1TOadder2, adder2TOmux3, readdata1TOalu, readdata2TOmux2,jump_address,
	signextendTOshiftleft2, mux2TOalu, shiftleft2TOadder2, mux3TOmux4,aluresult, memory_readdata, mux5TOwritedata;
wire [27:0] shift1TOmux4;
wire [4:0] mux1TOregfile;
wire [3:0] aluControlOut;
wire RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, AluSrc, RegWrite, andTOmux3, aluzero, lt, gt, bne;


reg clk;
initial
clk = 0;
always
#1000 clk = ~clk;		

assign jump_address = {adder1TOadder2[31:28],shift1TOmux4};
PC pc(mux4TOpc,pcTOadder1,clk);
														
IMemBank instmemory( 1'b1, pcTOadder1[7:0],instruction);
DMemBank datamemory( MemRead, MemWrite, aluresult[7:0], readdata2TOmux2, memory_readdata);

ALU alu(readdata1TOalu, mux2TOalu, aluControlOut, aluresult, aluzero, lt, gt);

Adder adder1(pcTOadder1,32'b00000000000000000000000000000100,adder1TOadder2);
Adder adder2(adder1TOadder2, shiftleft2TOadder2,adder2TOmux3);

SignExtend signextend(instruction [15:0],signextendTOshiftleft2);
ShiftLeft26 shift1(instruction[25:0],shift1TOmux4);
ShiftLeft32 shift2(signextendTOshiftleft2, shiftleft2TOadder2);

RegFile regfile(clk,instruction [25:21], instruction [20:16], mux1TOregfile, mux5TOwritedata, RegWrite, readdata1TOalu, readdata2TOmux2);

mux5 mux1(instruction [20:16],instruction [15:11], RegDst,mux1TOregfile);
mux32 mux2(readdata2TOmux2,signextendTOshiftleft2, AluSrc, mux2TOalu);
mux32 mux3(adder1TOadder2,adder2TOmux3, andTOmux3, mux3TOmux4);
mux32 mux4(mux3TOmux4, jump_address, Jump, mux4TOpc);
mux32 mux5(aluresult, memory_readdata, MemtoReg, mux5TOwritedata);
branch b1(aluzero, Branch, bne,andTOmux3);
//and a1(andTOmux3, Branch, aluzero);//done

//aluControl aluc(ALUOp, instruction[5:0], );//done

Control ctrl(instruction[31:26], instruction[5:0], RegDst, Jump, Branch, MemRead, MemtoReg, aluControlOut, MemWrite, AluSrc, RegWrite, bne);//done
endmodule
