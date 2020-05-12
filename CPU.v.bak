module CPU(clk50M, reset, nhalt, inputs, inputInst, outputInst, neg, dezena7, unidade7, centena7, und_milhar7, dez_milhar7, cent_milhar7,unidade7pc, dezena7pc);

input clk50M, reset, nhalt;
input [15:0] inputs;

output inputInst, outputInst, neg;

output [6:0] dezena7, unidade7, centena7,und_milhar7, dez_milhar7, cent_milhar7, unidade7pc, dezena7pc;

//ligações entre o BCD e o Display7seg
wire [3:0] dez_milhao, und_milhao, cent_milhar, dez_milhar, und_milhar, centena, dezena, unidade, unidadePC, dezenaPC;

//conexoes internas do modulo
wire [31:0] pc_inc, pc_desvio, ImmExtend, AddrExtend,  OutMuxBranch, OutMuxJump, pc_in, OutDataMemory, EntradaDados, instrucao,RegOut2,pc_out, SaidaDados, AluResult,RegWriteIn, RegOut1, AluOpB;
wire [4:0] writeRegAddr;
wire MuxSelBranch,AluZero,nhalt_db, clk, halt_s;


//sinais de controle
wire ALUSrc, Branch, Jump, JumpR, MemOp, OpIO,halt, RegWrite;
wire [1:0] RegDst, MemToReg;
wire [4:0]ALUOp;

//DivisorClock ClkDiv(clk50M,1,clk);

DivisorClock ClkDiv(clk50M,clk);

ControlUnit CRTL(instrucao[31:26],instrucao[5:0],halt,RegWrite,ALUSrc,Branch,Jump,JumpR,MemOp,OpIO,RegDst,MemToReg,ALUOp,outputInst,inputInst);

StateMachine stm(nhalt,halt,halt_s,clk);

PC ContadorPrograma(clk,pc_in, pc_out, reset, halt_s);

ADD IncrementaPC(32'd1, pc_out, pc_inc);

InstructionMemory MemoriaInstrucao(pc_out[7:0],instrucao);

Mux4_5bits MuxBancoRegistrador(instrucao[20:16], instrucao[25:21], 5'b11111, instrucao[15:11], writeRegAddr, RegDst);

RegisterBank BancoRegistradores(instrucao[25:21], instrucao[20:16], writeRegAddr, RegOut1, RegOut2, RegWriteIn, clk, RegWrite);

ExtensorSinal16_32 Extensor16a32(instrucao[15:0],ImmExtend);

ExtensorSinal26_32 Extensor26a32(instrucao[25:0], AddrExtend);

Mux2_32bits MuxEntradaULA(RegOut2,ImmExtend, AluOpB, ALUSrc);

ALU ULA(ALUOp,RegOut1, AluOpB, AluZero,instrucao[10:6],AluResult);

ADD SomaDesvio(ImmExtend, pc_inc, pc_desvio);

PortaAND ANDPort(AluZero, Branch, MuxSelBranch);

Mux2_32bits MuxBranch(pc_inc,pc_desvio, OutMuxBranch, MuxSelBranch);//primeiro mux dos desvios

Mux2_32bits MuxJump(OutMuxBranch, AddrExtend, OutMuxJump, Jump);//segundo mux dos desvios

Mux2_32bits MuxJumpR(OutMuxJump, RegOut1, pc_in, JumpR);//terceiro mux dos desvios, ligado ao pc

DataMemory MemoriaDados(RegOut2, AluResult[7:0], MemOp, clk, OutDataMemory);

IOModule EntradaSaida(inputs, RegOut1, EntradaDados, SaidaDados, OpIO, clk, instrucao[5:0]); 

Mux4_32bits MuxWriteRegister(OutDataMemory, pc_inc, AluResult, EntradaDados, RegWriteIn, MemToReg);

ConversorBCD BCDConverterPC(.value(pc_out),.unidade(unidadePC),.dezena(dezenaPC));

ConversorBCD BCDConverter(SaidaDados,dez_milhao, und_milhao, cent_milhar, dez_milhar, und_milhar, centena, dezena, unidade,neg);

Display7Segmentos unidade7segPC(unidadePC,unidade7pc);
Display7Segmentos dezena7segPC(dezenaPC,dezena7pc);

Display7Segmentos unidade7seg(unidade,unidade7);
Display7Segmentos dezena7seg(dezena,dezena7);
Display7Segmentos centena7seg(centena,centena7);
Display7Segmentos und_milhar7seg(und_milhar,und_milhar7);
Display7Segmentos cent_milhar7seg(cent_milhar,cent_milhar7);
Display7Segmentos dez_milhar7seg(dez_milhar,dez_milhar7);
Display7Segmentos und_milhao7seg(und_milhao,und_milhao7);
Display7Segmentos dez_milhao7seg(dez_milhao,dez_milhao7);

endmodule 





