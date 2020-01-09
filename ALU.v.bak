module ALU(ALUOp, opA, opB, zero, shamt, result);
	
	input [4:0] ALUOp;
	input [31:0] opA, opB;
	input [5:0] shamt;
	output reg zero;
	output reg [31:0] result;
	

	
	always@(*)
	begin
		result = 32'd0;
		zero = 0;
		case(ALUOp)
			5'b00000: result <= opA + opB;//soma
			5'b00001: result <= opA - opB;//subtração
			5'b00010://tratamento da divisão por zero
						begin
							if($signed(opB)==0)
								result <= opA;
							else
								result <= $signed(opA) / $signed(opB);//divisão
						end
			5'b00011: result <= $signed({opA[15:0]}) * $signed({opB[15:0]});//multiplicação
			5'b00100: result <= opA & opB;//and bit a bit;
			5'b00101: result <= opA | opB;//or bit a bit
			5'b00110: result = ~(opA | opB);//nor
			5'b00111: //set less than
						begin
							if(opA<opB)
								result = 1;
							else
								result = 0;
						end
			5'b01000: result <= opA << shamt;//desloca para esquerda;
			5'b01001: result <= opA >> shamt;//desloca para direita
			
			5'b01010: //brench less than zero
						begin
							if($signed(opA)<0)
								zero <= 1;
							else
								zero <= 0;
						end
			5'b01011: //brench greater than zero
						begin
							if($signed(opA)>0)
								zero <= 1;
							else
								zero <= 0;
						end
			5'b01100://brench equal zero
						begin
							if(opA==0)
								zero <= 1;
							else
								zero <= 0;
						end
			5'b01101://brench on equal
						begin
							if(opA==opB)
								zero <= 1;
							else
								zero <= 0;
						end
			5'b01110://brench not equal
						begin
							if(opA != opB)
								zero <= 1;
							else
								zero <= 0;
						end
			5'b01111:result <= opA % opB;//mod	
			
			5'b10000://lui
						begin
							result = {opB[15:0],opA[15:0]};
						end
		
			default: result <= 32'd0;
						
		endcase
		
	end
	
endmodule 