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
		write_addr <= write_end;
		write_flag <= RegWrite;
	end
	

assign read_out1 = registers[read_end1];
assign read_out2 = registers[read_end2];


endmodule 



