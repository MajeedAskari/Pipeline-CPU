
module branch(input zero,branch,bne, output reg s);

always@(zero,branch,bne)
begin
if (zero == 1 && branch == 1 && bne == 0) s = 1;
else if (zero == 0 && branch == 1 && bne == 1) s = 1;
else s = 0;
end


endmodule 