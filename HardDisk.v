	
	module HardDisk(clk,we,INPUT_DATA,OUTPUT_DATA,s,t);

	input clk, we;
	input [31:0] s;
	input [31:0] t;
	input [31:0] INPUT_DATA;
	output [31:0] OUTPUT_DATA;

	//reg [31:0] disk[(32*512)-1:0];
	reg [31:0] disk[3:0];

	initial
	begin : INIT
		disk[0] = 32'b00000100001000010000000000000010;//addi r1 r1 2
		disk[1] = 32'b01010000001000000000000000000000;//output r1
	end

	always @ (posedge clk)
		begin
			// Write
			if (we)
				disk[s*2+t] <= INPUT_DATA;
		end
	assign OUTPUT_DATA = disk[s*2+t];

	endmodule