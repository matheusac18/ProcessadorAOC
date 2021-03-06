	
	module Timer(clk, pc_in, pc_out, count, rw, finish, halt);

	input [31:0] pc_in;
	input clk,halt;
	input [1:0] rw;

	output reg [31:0] count=0;
	output reg [31:0] pc_out;
	output reg finish;

	reg [31:0] quantum = 8;
	reg onOff = 0;


	always@(posedge clk)
	begin
		if(halt != 1)
		begin
			if(onOff == 1)
				count = count + 1;
			if((onOff == 1) && (count == quantum))
				begin
					finish <= 1;
					pc_out <= pc_in;
					onOff <= 0;
				end
			if(onOff == 0)
				finish <= 0;	
			if(rw[0] == 1)
			begin
				onOff <= rw[1];
				count <= 32'd0;
			end
		end
	end

	endmodule