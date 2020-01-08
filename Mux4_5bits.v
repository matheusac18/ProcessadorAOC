module Mux4_5bits(A,B,C,D,Z,seletor);

input [4:0] A,B,C,D;
input [1:0] seletor;
output reg [4:0] Z;

always@(*)
	begin
		case(seletor)
			2'b00: Z=A;
			2'b01: Z=B;
			2'b10: Z=C;
			2'b11: Z=D;
			default: Z=5'b00000;
		endcase
	end
endmodule 