module ADD(X,Y,Z);

input [31:0] X,Y;
output reg [31:0] Z;

always@(*)
	begin
		Z = X+Y;
	end
endmodule
		

