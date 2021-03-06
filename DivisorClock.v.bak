module DivisorClock (clk_in,clk_out);

	parameter [31:0]divisor=25000000;
	
	reg [31:0]contador;
	input clk_in;
	output reg clk_out = 1'b1;
	
	always@(posedge clk_in)
	begin
		if(contador<divisor) contador = contador + 32'd1;
		else
		begin
			clk_out = ~clk_out;
			contador = 32'd0;
		end
	end

endmodule 

/*module DivisorClock( clk ,rst,out_clk );
output reg out_clk;
input clk ;
input rst;
always @(posedge clk)
begin
if (~rst)
     out_clk <= 1'b0;
else
     out_clk <= ~out_clk;	
end
endmodule*/
