module PortaAND(X,Y,Z);

input X,Y;
output reg Z;

always@(*)
begin
	Z = X & Y;
end

endmodule 