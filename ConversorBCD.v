module ConversorBCD(value,dez_milhao, und_milhao, cent_milhar, dez_milhar, und_milhar, centena, dezena, unidade,neg);
	input [31:0] value;
	
	output reg [3:0] dez_milhao, und_milhao, cent_milhar, dez_milhar, und_milhar, centena, dezena, unidade;
	output reg neg;
	
	reg [31:0] abs_value;
	
	integer i;
	//adicionar o tutorial como referencia
	
	always@(value)
	begin
		if ($signed(value)<0)
			begin
				neg = 1;
				abs_value = ~(value-32'b00000000000000000000000000000001);
			end
		else
		begin
			neg = 0;
			abs_value = value;
		end
	end
	
	
	
	always@(abs_value)
	begin
		
		dez_milhao = 4'd0;
		und_milhao = 4'd0;
		cent_milhar = 4'd0;
		dez_milhar = 4'd0;
		und_milhar = 4'd0;
		centena = 4'd0;
		dezena = 4'd0;
		unidade = 4'd0;
		
		for(i=31; i>=0; i = i-1)
		begin
			if (dez_milhao>4)
				dez_milhao = dez_milhao + 3;
				
			if (und_milhao>4)
				und_milhao = und_milhao + 3;
				
			if (cent_milhar>4)
				cent_milhar = cent_milhar + 3;
				
			if (dez_milhar>4)
				dez_milhar = dez_milhar + 3;
				
			if (und_milhar>4)
				und_milhar = und_milhar + 3;
				
			if (centena>4)
				centena = centena + 3;
				
			if (dezena>4)
				dezena = dezena + 3;
				
			if (unidade>4)
				unidade = unidade + 3;
				
			dez_milhao = dez_milhao << 1;
			dez_milhao[0] = und_milhao[3];
			
			und_milhao = und_milhao << 1;
			und_milhao[0] = cent_milhar[3];
			
			cent_milhar = cent_milhar << 1;
			cent_milhar[0] = dez_milhar[3];

			dez_milhar = dez_milhar << 1;
			dez_milhar[0] = und_milhar[3];
			
			und_milhar = und_milhar << 1;
			und_milhar[0] = centena[3];
			
			centena = centena << 1;
			centena[0] = dezena[3];
			
			dezena = dezena << 1;
			dezena[0] = unidade[3];
			
			unidade = unidade <<1; 
			unidade[0] = abs_value[i];
			
		end
	end
	
endmodule 