module Mux2_32bits(A,B,Z,seletor);

input [31:0] A,B;
input seletor;
output reg [31:0] Z;

always@(*)
	begin
		case(seletor)
			1'b0: Z=A;
			1'b1: Z=B;
			default: Z=32'd0;
		endcase
	end
endmodule 