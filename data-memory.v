//memory unit
module DMemBank(input memread, input memwrite, input [7:0] address, input [31:0] writedata, output reg [31:0] readdata);
 
  reg [31:0] mem_array [127:0];
  
  integer i;
  initial 
  begin
      for (i=0; i<128; i=i+1)   
     mem_array[i] = 0;
  end
 
  always@(memread, memwrite, address, mem_array[address], writedata)
	  #2
  begin
    if(memread == 1'b1)
	begin
      readdata = mem_array[address];
    end												  
    if(memwrite === 1'b1 && !$isunknown(writedata))
    begin													   
      mem_array[address] = writedata;
    end

  end

endmodule