module IOModule(inputs, data, entrada, saida, opIO, clock, funct);

	output reg [31:0]entrada;
	output [31:0] saida;
	
	input [15:0] inputs;
	input [31:0] data;
	input [5:0] funct;
	input clock, opIO;
	
	
	reg [31:0] mem_out;
	
	//saida
	always@(posedge clock)
	begin
		if(opIO==1)
			mem_out <= data;
	end
	
	assign saida = mem_out;//saida que será conectada ao conversor BCD
	
	//entrada
	
	always@(inputs, funct)
	begin
		if(funct<5'd16)
			begin
				entrada = {31'b0,inputs[funct]};//ler a entrada na posição informada pelo funct(0-21)
			end
		else
		begin
			case(funct)
				5'b010110: entrada = {24'b0,inputs[7:0]};//ler valor de 8 bits, pega as primeiras 8 alavancas
				5'b010111: entrada = {16'b0,inputs[15:0]};//ler valor de 16 bits, pega as primeiras 16 alavancas
				default: entrada = 32'd0;
			endcase
		end
	end
endmodule

