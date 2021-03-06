//module CPU(clk50M, reset, nhalt, inputs, inputInst, outputInst, neg, dezena7, unidade7,unidade7pc, dezena7pc, unidade7PID, centena7pc, milhar7pc);
//
//input clk50M, reset, nhalt;
//input [15:0] inputs;
//
//output inputInst, outputInst, neg;
//
////output [6:0] dezena7, unidade7, centena7,und_milhar7, dez_milhar7, cent_milhar7, unidade7pc, dezena7pc, unidade7Timer, dezena7Timer;
//output [6:0] dezena7, unidade7, unidade7pc, dezena7pc, centena7pc, milhar7pc, unidade7PID;
//
////ligações entre o BCD e o Display7seg
//wire [3:0] dez_milhao, und_milhao, cent_milhar, dez_milhar, und_milhar, centena, dezena, unidade, unidadePC, dezenaPC, centenaPC, milharPC, unidadeTimer, dezenaTimer, unidadePID;
//
////conexoes internas do modulo
//wire [31:0] pc_inc, pc_desvio, ImmExtend, AddrExtend,  OutMuxBranch, OutMuxJump, pc_inMux, OutDataMemory, EntradaDados, instrucao,RegOut2,pc_out, outPID, SaidaDados, AluResult,RegWriteIn, RegWriteIn2, OutMuxJumpR, RegOut1, AluOpB,countTimer, pc_timer, BufferOutput, HdOutput,JalJumpRegResult;
//wire [4:0] writeRegAddr;
//wire MuxSelBranch,AluZero,nhalt_db, clk, halt_s;
//
//wire [31:0] pc_in;
//
//wire TimerMux;
//
////sinais de controle
//wire ALUSrc, Branch, Jump, JumpR, MemOp, OpIO,halt, RegWrite, RegWrite2, HdWrite, BufferWrite, InstMemWrite, JalJumpReg, opPID;
//wire [1:0] RegDst, MemToReg, MemToReg2, enableTimer;
//wire [4:0]ALUOp;
//
////DivisorClock ClkDiv(clk50M,1,clk);
//
//PID pid(.data(RegOut1),.out(outPID),.opPID(opPID), .clock(clk));
//
//ConversorBCD BCDConverterPID(.value(outPID),.unidade(unidadePID));
//
//Display7Segmentos unidade7pid(unidadePID,unidade7PID);
//
//DivisorClock ClkDiv(clk50M,clk);
//
//HardDisk HD(.clk(clk),.we(HdWrite), .OUTPUT_DATA(HdOutput), .INPUT_DATA(BufferOutput), .s(RegOut1),.t(RegOut2));
//
//BufferHd HdBuffer(.clk(clk),.we(BufferWrite), .OUTPUT_DATA(BufferOutput), .INPUT_DATA(RegOut1));
//
//Timer TrocadorContexto(.clk(clk),.pc_in(pc_in),.count(countTimer),.halt(halt_s), .finish(TimerMux), .pc_out(pc_timer), .rw(enableTimer));
//
//ControlUnit CRTL(instrucao[31:26],instrucao[5:0],halt,RegWrite,ALUSrc,Branch,Jump,JumpR,MemOp,OpIO,RegDst,MemToReg,ALUOp,outputInst,inputInst, MemToReg2, enableTimer,HdWrite,BufferWrite, InstMemWrite,JalJumpReg,opPID);
//
//StateMachine stm(nhalt,halt,halt_s,clk);
//
//PC ContadorPrograma(clk,pc_inMux, pc_out, reset, halt_s);
//
//ADD IncrementaPC(32'd1, pc_out, pc_inc);
//
//InstructionMemory MemoriaInstrucao(.read_addr(pc_out[10:0]),.q(instrucao),.write_addr(AluResult[7:0]),.data(RegOut2), .write_clock(clk), .read_clock(clk50M), .we(InstMemWrite));
//
//Mux4_5bits MuxBancoRegistrador(instrucao[20:16], instrucao[25:21], 5'b11111, instrucao[15:11], writeRegAddr, RegDst);
//
//RegisterBank BancoRegistradores(instrucao[25:21], instrucao[20:16], writeRegAddr, RegOut1, RegOut2, RegWriteIn2, clk, RegWrite);
//
//ExtensorSinal16_32 Extensor16a32(instrucao[15:0],ImmExtend);
//
//ExtensorSinal26_32 Extensor26a32(instrucao[25:0], AddrExtend);
//
//Mux2_32bits MuxEntradaULA(RegOut2,ImmExtend, AluOpB, ALUSrc);
//
//Mux2_32bits MuxTrocaContexto(pc_in,32'd151, pc_inMux, TimerMux);
//
//ALU ULA(ALUOp,RegOut1, AluOpB, AluZero,instrucao[10:6],AluResult);
//
//ADD SomaDesvio(ImmExtend, pc_inc, pc_desvio);
//
//ADD SomaRegImediato(ImmExtend, RegOut1, JalJumpRegResult);
//
//PortaAND ANDPort(AluZero, Branch, MuxSelBranch);
//
//Mux2_32bits MuxBranch(pc_inc,pc_desvio, OutMuxBranch, MuxSelBranch);//primeiro mux dos desvios
//
//Mux2_32bits MuxJump(OutMuxBranch, AddrExtend, OutMuxJump, Jump);//segundo mux dos desvios
//
//Mux2_32bits MuxJumpR(OutMuxJump, RegOut1, OutMuxJumpR, JumpR);//terceiro mux dos desvios, ligado ao pc
//
//Mux2_32bits MuxJumpJalReg(OutMuxJumpR, JalJumpRegResult, pc_in, JalJumpReg);//quarto mux dos desvios, recebe o anteiror e registrador somado ao imediato
//
//DataMemory MemoriaDados(RegOut2, AluResult[11:0], MemOp, clk, OutDataMemory);
//
//IOModule EntradaSaida(inputs, RegOut1, EntradaDados, SaidaDados, OpIO, clk, instrucao[5:0]); 
//
//Mux4_32bits MuxWriteRegister(OutDataMemory, pc_inc, AluResult, EntradaDados, RegWriteIn, MemToReg);
//
//Mux4_32bits MuxWriteRegister2(RegWriteIn, pc_timer, HdOutput, 32'd0, RegWriteIn2, MemToReg2);
//
//ConversorBCD BCDConverterPC(.value(pc_out),.unidade(unidadePC),.dezena(dezenaPC), .und_milhar(milharPC), .centena(centenaPC));
//
//ConversorBCD BCDConverterTimer(.value(countTimer),.unidade(unidadeTimer),.dezena(dezenaTimer));
//
//ConversorBCD BCDConverter(.value(SaidaDados), .centena(centena), .dezena(dezena), .unidade(unidade), .neg(neg));
////ConversorBCD BCDConverter(SaidaDados,dez_milhao, und_milhao, cent_milhar, dez_milhar, und_milhar, centena, dezena, unidade,neg);
//
//Display7Segmentos unidade7segPC(unidadePC,unidade7pc);
//Display7Segmentos dezena7segPC(dezenaPC,dezena7pc);
//Display7Segmentos centena7segPC(centenaPC,centena7pc);
//Display7Segmentos milhar7segPC(milharPC,milhar7pc);
//
//Display7Segmentos unidade7segTimer(unidadeTimer,unidade7Timer);
//Display7Segmentos dezena7segTimer(dezenaTimer,dezena7Timer);
//
//Display7Segmentos unidade7seg(unidade,unidade7);
//Display7Segmentos dezena7seg(dezena,dezena7);
//Display7Segmentos centena7seg(centena,centena7);
////Display7Segmentos und_milhar7seg(und_milhar,und_milhar7);
////Display7Segmentos cent_milhar7seg(cent_milhar,cent_milhar7);
////Display7Segmentos dez_milhar7seg(dez_milhar,dez_milhar7);
////Display7Segmentos und_milhao7seg(und_milhao,und_milhao7);
////Display7Segmentos dez_milhao7seg(dez_milhao,dez_milhao7);
//
//endmodule 



module CPU(clk50M, reset, nhalt, inputs, inputInst, outputInst, neg, dezena7, unidade7,unidade7pc, dezena7pc, unidade7PID, centena7pc, milhar7pc,unidadePID,pc_out,SaidaDados);

input clk50M, reset, nhalt;
input [15:0] inputs;

output inputInst, outputInst, neg;

//output [6:0] dezena7, unidade7, centena7,und_milhar7, dez_milhar7, cent_milhar7, unidade7pc, dezena7pc, unidade7Timer, dezena7Timer;
output [6:0] dezena7, unidade7, unidade7pc, dezena7pc, centena7pc, milhar7pc, unidade7PID;


//ligações entre o BCD e o Display7seg
wire [3:0] dez_milhao, und_milhao, cent_milhar, dez_milhar, und_milhar, centena, dezena, unidade, unidadePC, dezenaPC, centenaPC, milharPC, unidadeTimer, dezenaTimer;
output wire [3:0] unidadePID;


//conexoes internas do modulo
wire [31:0] pc_inc, pc_desvio, ImmExtend, AddrExtend,  OutMuxBranch, OutMuxJump, pc_inMux, OutDataMemory, EntradaDados, instrucao,RegOut2, outPID, AluResult,RegWriteIn, RegWriteIn2, OutMuxJumpR, RegOut1, AluOpB,countTimer, pc_timer, BufferOutput, HdOutput,JalJumpRegResult;
output wire [31:0] SaidaDados;
output wire [31:0] pc_out;
wire [4:0] writeRegAddr;
wire MuxSelBranch,AluZero,nhalt_db, clk, halt_s;

wire [31:0] pc_in;

wire TimerMux;

//sinais de controle
wire ALUSrc, Branch, Jump, JumpR, MemOp, OpIO,halt, RegWrite, RegWrite2, HdWrite, BufferWrite, InstMemWrite, JalJumpReg, opPID;
wire [1:0] RegDst, MemToReg, MemToReg2, enableTimer;
wire [4:0]ALUOp;

//DivisorClock ClkDiv(clk50M,1,clk);

PID pid(.data(RegOut1),.out(outPID),.opPID(opPID), .clock(clk));

ConversorBCD BCDConverterPID(.value(outPID),.unidade(unidadePID));

Display7Segmentos unidade7pid(unidadePID,unidade7PID);

DivisorClock ClkDiv(clk50M,clk);

HardDisk HD(.clk(clk),.we(HdWrite), .OUTPUT_DATA(HdOutput), .INPUT_DATA(BufferOutput), .s(RegOut1),.t(RegOut2));

BufferHd HdBuffer(.clk(clk),.we(BufferWrite), .OUTPUT_DATA(BufferOutput), .INPUT_DATA(RegOut1));

Timer TrocadorContexto(.clk(clk),.pc_in(pc_in),.count(countTimer),.halt(halt_s), .finish(TimerMux), .pc_out(pc_timer), .rw(enableTimer));

ControlUnit CRTL(instrucao[31:26],instrucao[5:0],halt,RegWrite,ALUSrc,Branch,Jump,JumpR,MemOp,OpIO,RegDst,MemToReg,ALUOp,outputInst,inputInst, MemToReg2, enableTimer,HdWrite,BufferWrite, InstMemWrite,JalJumpReg,opPID);

StateMachine stm(nhalt,halt,halt_s,clk);

PC ContadorPrograma(clk,pc_inMux, pc_out, reset, halt_s);

ADD IncrementaPC(32'd1, pc_out, pc_inc);

InstructionMemory MemoriaInstrucao(.read_addr(pc_out[10:0]),.q(instrucao),.write_addr(AluResult[7:0]),.data(RegOut2), .write_clock(clk), .read_clock(clk50M), .we(InstMemWrite));

Mux4_5bits MuxBancoRegistrador(instrucao[20:16], instrucao[25:21], 5'b11111, instrucao[15:11], writeRegAddr, RegDst);

RegisterBank BancoRegistradores(instrucao[25:21], instrucao[20:16], writeRegAddr, RegOut1, RegOut2, RegWriteIn2, clk, RegWrite);

ExtensorSinal16_32 Extensor16a32(instrucao[15:0],ImmExtend);

ExtensorSinal26_32 Extensor26a32(instrucao[25:0], AddrExtend);

Mux2_32bits MuxEntradaULA(RegOut2,ImmExtend, AluOpB, ALUSrc);

Mux2_32bits MuxTrocaContexto(pc_in,32'd151, pc_inMux, TimerMux);

ALU ULA(ALUOp,RegOut1, AluOpB, AluZero,instrucao[10:6],AluResult);

ADD SomaDesvio(ImmExtend, pc_inc, pc_desvio);

ADD SomaRegImediato(ImmExtend, RegOut1, JalJumpRegResult);

PortaAND ANDPort(AluZero, Branch, MuxSelBranch);

Mux2_32bits MuxBranch(pc_inc,pc_desvio, OutMuxBranch, MuxSelBranch);//primeiro mux dos desvios

Mux2_32bits MuxJump(OutMuxBranch, AddrExtend, OutMuxJump, Jump);//segundo mux dos desvios

Mux2_32bits MuxJumpR(OutMuxJump, RegOut1, OutMuxJumpR, JumpR);//terceiro mux dos desvios, ligado ao pc

Mux2_32bits MuxJumpJalReg(OutMuxJumpR, JalJumpRegResult, pc_in, JalJumpReg);//quarto mux dos desvios, recebe o anteiror e registrador somado ao imediato

DataMemory MemoriaDados(RegOut2, AluResult[11:0], MemOp, clk, OutDataMemory);

IOModule EntradaSaida(inputs, RegOut1, EntradaDados, SaidaDados, OpIO, clk, instrucao[5:0]); 

Mux4_32bits MuxWriteRegister(OutDataMemory, pc_inc, AluResult, EntradaDados, RegWriteIn, MemToReg);

Mux4_32bits MuxWriteRegister2(RegWriteIn, pc_timer, HdOutput, 32'd0, RegWriteIn2, MemToReg2);

ConversorBCD BCDConverterPC(.value(pc_out),.unidade(unidadePC),.dezena(dezenaPC), .und_milhar(milharPC), .centena(centenaPC));

ConversorBCD BCDConverterTimer(.value(countTimer),.unidade(unidadeTimer),.dezena(dezenaTimer));

ConversorBCD BCDConverter(.value(SaidaDados), .centena(centena), .dezena(dezena), .unidade(unidade), .neg(neg));
//ConversorBCD BCDConverter(SaidaDados,dez_milhao, und_milhao, cent_milhar, dez_milhar, und_milhar, centena, dezena, unidade,neg);

Display7Segmentos unidade7segPC(unidadePC,unidade7pc);
Display7Segmentos dezena7segPC(dezenaPC,dezena7pc);
Display7Segmentos centena7segPC(centenaPC,centena7pc);
Display7Segmentos milhar7segPC(milharPC,milhar7pc);

Display7Segmentos unidade7segTimer(unidadeTimer,unidade7Timer);
Display7Segmentos dezena7segTimer(dezenaTimer,dezena7Timer);

Display7Segmentos unidade7seg(unidade,unidade7);
Display7Segmentos dezena7seg(dezena,dezena7);
Display7Segmentos centena7seg(centena,centena7);
//Display7Segmentos und_milhar7seg(und_milhar,und_milhar7);
//Display7Segmentos cent_milhar7seg(cent_milhar,cent_milhar7);
//Display7Segmentos dez_milhar7seg(dez_milhar,dez_milhar7);
//Display7Segmentos und_milhao7seg(und_milhao,und_milhao7);
//Display7Segmentos dez_milhao7seg(dez_milhao,dez_milhao7);

endmodule 

