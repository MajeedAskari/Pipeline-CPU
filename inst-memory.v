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
	mem_array[0] = 32'h200f0008;/*
	mem_array[1] = 32'hac0f0000;
	mem_array[2] = 32'h200f0017;
	mem_array[3] = 32'hac0f0001;
	mem_array[4] = 32'h200f002b;
	mem_array[5] = 32'hac0f0002;
	mem_array[6] = 32'h8c010000;
	mem_array[7] = 32'h8c020000;
	mem_array[8] = 32'h0000f020;
	mem_array[9] = 32'h201d000a;
	mem_array[10] = 32'h03bee022;
	mem_array[11] = 32'h13800009;
	mem_array[12] = 32'h8fd40000;
	mem_array[13] = 32'h0034d82a;
	mem_array[14] = 32'h13600001;
	mem_array[15] = 32'h02800820;
	mem_array[16] = 32'h0282d82a;
	mem_array[17] = 32'h13600001;
	mem_array[18] = 32'h02801020;
	mem_array[19] = 32'h23de0001; 
	mem_array[20] = 32'h0800000a; */
  end
 
  always@(memread, address, mem_array[address])
  begin
    if(memread)begin
      readdata = mem_array[address];
    end
  end

endmodule

