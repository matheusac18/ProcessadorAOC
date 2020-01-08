module Halt(clk, nhalt, nhalt_out);

input nhalt, clk;
output reg nhalt_out;

reg estado = 0;

always@(posedge clk)
	if(nhalt == 1 && estado == 0)
		begin
			nhalt_out = 1;
			estado = 1;
		end
	else if(estado == 1)
		begin
			nhalt_out = 0;
		end
	else if(nhalt == 0)
		begin
			estado = 0;
		end
endmodule
