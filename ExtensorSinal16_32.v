module ExtensorSinal16_32(X,Y);

	input [15:0] X;
	output reg [31:0] Y;
	
	always@(*)
	begin
		if(X[15])
			Y = {16'b1111111111111111,X};
		else
			Y = {16'b0000000000000000,X};
	end
	
endmodule
