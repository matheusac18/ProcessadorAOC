module PC(clk, pc_in, pc_out, reset, halt);

input [31:0] pc_in;
input clk, reset, halt;

output reg [31:0] pc_out;


always@(negedge clk)
begin
	if(reset==1)
		begin
			pc_out = 0;
		end
	else if(halt == 1)
		begin
		end
	else
		begin
			pc_out = pc_in;
		end
end

endmodule

/*module PC(clk, pc_in, pc_out, reset, halt, nhalt, reg1, reg2);

input [31:0] pc_in;
input clk, reset, halt, nhalt;

output reg [31:0] pc_out;

output reg reg1 = 1, reg2 = 0;

always@(negedge clk)
begin
		if(halt == 0 && (reg1 != reg2))
			pc_out = pc_in;
	
		if(halt && (reg1 == reg2))
			begin
				pc_out = pc_in;
				reg1 = ~reg1;
			end
end

always@(posedge nhalt)
begin
	reg2 = ~reg2;
end

endmodule*/
