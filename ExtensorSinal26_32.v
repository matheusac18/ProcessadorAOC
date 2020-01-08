module ExtensorSinal26_32(X,Y);

	input [25:0] X;
	output reg [31:0] Y;
	
	always@(*)
	begin
		Y = {6'b000000,X};
	end
	
endmodule
