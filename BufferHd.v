

	module BufferHd(clk,we,INPUT_DATA,OUTPUT_DATA);

	input clk, we;

	input [31:0] INPUT_DATA;
	output [31:0] OUTPUT_DATA;

	reg [31:0] buff;

	always @ (posedge clk)
		begin
			// Write
			if (we)
				buff <= INPUT_DATA;
		end
	assign OUTPUT_DATA = buff;

	endmodule