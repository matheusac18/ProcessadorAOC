module PID(data, out, opPID, clock);

	input [31:0] data;
	input opPID;
	input clock;
	output [31:0] out;
	reg [31:0] mem_out;
	//saida
	always@(posedge clock)
	begin
		if(opPID==1)
			mem_out <= data;
	end
	
	assign out = mem_out;//saida que será conectada ao conversor BCD
	
endmodule
