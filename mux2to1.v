module mux32(in0, in1, select, mux_out);

input [31:0] in0, in1;
input select;
output [31:0] mux_out;

assign mux_out = (select) ? in1 : in0;

endmodule

module mux5(in0, in1, select, mux_out);

input [4:0] in0, in1;
input select ;
output [4:0] mux_out;

assign mux_out = (select) ? in1 : in0;

endmodule
