module RegisterBank(read_end1, read_end2, write_end, read_out1, read_out2, write_in, clock, RegWrite);

input [4:0] read_end1, read_end2, write_end;
input clock, RegWrite;
input [31:0] write_in;

output [31:0] read_out1, read_out2;

reg [31:0] registers [31:0];

reg [4:0] write_addr;
reg [31:0] write_data;
reg write_flag;

initial 
	begin 
		registers[0] = 32'd0;
		
		//registradores do SO
		registers[1] = 32'd0;
		registers[2] = 32'd66;
		registers[3] = 32'd66;
		registers[5] = 32'd0;
		registers[6] = 32'd0;
		
		//registers[20] = 32'd0;
		//registers[21] = 32'd0;
		//registers[18] = 32'd256;
		//registers[19] = 32'd256;
		//registers[30] = 32'd256;
		//registers[29] = 32'd256;
	end 

always@(negedge clock)
	begin
		
		if (write_flag==1) 
			begin
				registers[write_addr] <= write_in;
			end
	end

always@(posedge clock)
	begin
		//registers[0] = 32'b00000000000000000000000000000000;
		write_addr <= write_end;
		write_flag <= RegWrite;
	end
	

assign read_out1 = registers[read_end1];
assign read_out2 = registers[read_end2];


endmodule 



