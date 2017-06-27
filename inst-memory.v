//memory unit
module IMemBank(input memread, input [7:0] addr, output reg [31:0] readdata);
  reg [7:0] address;
  reg [31:0] mem_array [255:0];	   	 
  
  always@(addr)
	  #2
	  begin
		  address = addr >> 2;
	  end
	  
  initial begin	
	  					 			  /*
	mem_array[0] = 32'h200a0034;
	mem_array[1] = 32'h200b0017;
	mem_array[2] = 32'h20010017;
	mem_array[3] = 32'h0141f822;
	mem_array[4] = 32'hac030000;
	mem_array[5] = 32'hac040002;
	mem_array[6] = 32'h0083f82a;
	mem_array[7] = 32'h00c31820;
	mem_array[8] = 32'h00a43022;
	mem_array[9] = 32'h8c1d0000;
	mem_array[10] = 32'hac1c0002; */
	
	
mem_array[0] = 32'h200f0008;
mem_array[1] = 32'hac0f0000;
mem_array[2] = 32'h21ef0017;
mem_array[3] = 32'hac0f0001;
mem_array[4] = 32'h200f002b;
mem_array[5] = 32'hac0f0002;
mem_array[6] = 32'h200f0011;
mem_array[7] = 32'hac0f0003;
mem_array[8] = 32'h20010005;
mem_array[9] = 32'h01e17822;
mem_array[10] = 32'hac0f0004;
mem_array[11] = 32'h200f020a;
mem_array[12] = 32'hac0f0005;
mem_array[13] = 32'h200f0034;
mem_array[14] = 32'hac0f0006;
mem_array[15] = 32'h20010017;
mem_array[16] = 32'h01e17822;
mem_array[17] = 32'hac0f0007;
mem_array[18] = 32'h20010005;
mem_array[19] = 32'h01e17822;
mem_array[20] = 32'hac0f0008;
mem_array[21] = 32'h340f000b;
mem_array[22] = 32'hac0f0009;
mem_array[23] = 32'h8c010000;
mem_array[24] = 32'h8c020000;
mem_array[25] = 32'h0000f020;
mem_array[26] = 32'h201d000a;
mem_array[27] = 32'h03bee022;
mem_array[28] = 32'h13800009;
mem_array[29] = 32'h8fd40000;
mem_array[30] = 32'h0034d82a;
mem_array[31] = 32'h13600001;
mem_array[32] = 32'h02800820;
mem_array[33] = 32'h0282d82a;
mem_array[34] = 32'h13600001;
mem_array[35] = 32'h02801020;
mem_array[36] = 32'h23de0001;
mem_array[37] = 32'h0800001b;
mem_array[38] = 32'h200f0309;
	
  end
 
  always@(memread, address, mem_array[address])
  begin
    if(memread)begin
      readdata = mem_array[address];
    end
  end

endmodule

