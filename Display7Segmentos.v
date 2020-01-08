module Display7Segmentos(entrada,saida);
	input [3:0]entrada;
	reg [6:0] sinais;
	output [6:0]saida;
	always@(*)
	begin
		case(entrada)
			4'B0000: sinais = 7'B0000001;//0
			4'B0001: sinais = 7'B1001111;//1
			4'B0010: sinais = 7'B0010010;//2
			4'B0011: sinais = 7'B0000110;//3
			4'B0100: sinais = 7'B1001100;//4
			4'B0101: sinais = 7'B0100100;//5
			4'B0110: sinais = 7'B0100000;//6
			4'B0111: sinais = 7'B0001111;//7
			4'B1000: sinais = 7'B0000000;//8
			4'B1001: sinais = 7'B0000100;//9
			default: sinais = 7'B1111111;//acima de 9
		endcase
	end
	
	assign saida = sinais;
	
endmodule 