module InstructionMemory
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=8)
(
	input [(ADDR_WIDTH-1):0] addr,
	output [(DATA_WIDTH-1):0] q
);

	reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];

	initial
	begin
		$readmemb("instrucoes.txt", rom, 0, 255);
	end

	assign q = rom[addr];

endmodule


