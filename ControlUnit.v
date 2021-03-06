module ControlUnit(OpCode, funct, halt, RegWrite, ALUSrc, Branch, Jump, JumpR, MemOp, OpIO, RegDst, MemToReg, ALUOp, outputInst, inputInst, MemToReg2,enableTimer, HdWrite, BufferHdWrite, InstMemWrite,JalJumpReg,opPID);

input [5:0] OpCode, funct;

output reg halt, RegWrite, ALUSrc, Branch, Jump, JumpR, MemOp, OpIO, outputInst, inputInst, HdWrite, BufferHdWrite, InstMemWrite,JalJumpReg,opPID;
output reg [1:0] RegDst, MemToReg, MemToReg2, enableTimer;
output reg [4:0] ALUOp;

always@(*)
begin

	case(OpCode)
	
		6'b000000://instruções do tipo R
			begin
				halt <= 0;
				
				RegDst <= 2'b11;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 0;
				if(funct == 6'b001100)//JR
				begin
					JumpR <=1;
					RegWrite <= 0;
				end
				else
				begin
					JumpR <=0;
					RegWrite <= 1;
				end
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b10;
				MemToReg2 <= 2'b00;
				inputInst = 0;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
				case(funct)
					6'b000001: ALUOp <= 5'b00000;//soma
					6'b000010: ALUOp <= 5'b00001;//sub
					6'b000011: ALUOp <= 5'b00011;//mult
					6'b000100: ALUOp <= 5'b00010;//div
					6'b000101: ALUOp <= 5'b00100;//and
					6'b000110: ALUOp <= 5'b00101;//or
					6'b000111: ALUOp <= 5'b00110;//nor
					6'b001000: ALUOp <= 5'b00111;//slt
					6'b001001: ALUOp <= 5'b01000;//sll
					6'b001010: ALUOp <= 5'b01001;//srl
					6'b001011: ALUOp <= 5'b01111;//mod
					6'b001101: ALUOp <= 5'b10001;//sgt
					6'b001110: ALUOp <= 5'b10010;//slet
					6'b001111: ALUOp <= 5'b10011;//sget
					6'b010000: ALUOp <= 5'b10100;//set
					6'b010001: ALUOp <= 5'b10101;//sdf
					default: ALUOp <= 5'b00000;
				endcase
			end
		6'b000001://addi
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b00;
				ALUSrc <= 1;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b10;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b00000;
				inputInst = 0;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b000010://multi
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b00;
				ALUSrc <= 1;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b10;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b00011;
				inputInst = 0;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b000011://divi
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b00;
				ALUSrc <= 1;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b10;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b00010;
				inputInst = 0;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b000100://andi
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b00;
				ALUSrc <= 1;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b10;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b00100;
				inputInst = 0;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b000101://bltz
			begin
				halt <= 0;
				RegWrite <= 0;
				RegDst <= 2'bXX;
				ALUSrc <= 0;
				Branch <= 1;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'bXX;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b01010;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b000110://BGTZ
			begin
				halt <= 0;
				RegWrite <= 0;
				RegDst <= 2'bXX;
				ALUSrc <= 0;
				Branch <= 1;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'bXX;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b01011;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b000111://BEQZ
			begin
				halt <= 0;
				RegWrite <= 0;
				RegDst <= 2'bXX;
				ALUSrc <= 0;
				Branch <= 1;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'bXX;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b01100;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b001000://BEQ
			begin
				halt <= 0;
				RegWrite <= 0;
				RegDst <= 2'bXX;
				ALUSrc <= 0;
				Branch <= 1;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'bXX;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b01101;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b001001://BNE
			begin
				halt <= 0;
				RegWrite <= 0;
				RegDst <= 2'bXX;
				ALUSrc <= 0;
				Branch <= 1;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'bXX;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b01110;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b010101://LUI
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b01;
				ALUSrc <= 1;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b10;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b10000;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b001010://LW
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b00;
				ALUSrc <= 1;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b00;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b00000;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b001011://SW
			begin
				halt <= 0;
				RegWrite <= 0;
				RegDst <= 2'bXX;
				ALUSrc <= 1;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 1;
				OpIO <= 0;
				MemToReg <= 2'bXX;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b00000;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b001100://ORI
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b00;
				ALUSrc <= 1;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b10;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b00101;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b001101://SLTI
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b00;
				ALUSrc <= 1;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b10;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b00111;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b001110://MODI
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b00;
				ALUSrc <= 1;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b10;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b01111;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b001111://jump
			begin
				halt <= 0;
				RegWrite <= 0;
				RegDst <= 2'b00;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 1;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b00;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b00000;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b010000://jal
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b10;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 1;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b01;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b00000;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b010001://nop
			begin
				halt <= 0;
				RegWrite <= 0;
				RegDst <= 2'b00;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b00;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b00000;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b010010://halt
			begin
				halt <= 1;
				RegWrite <= 0;
				RegDst <= 2'b00;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b00;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b00000;
				inputInst = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				HdWrite = 0;
				BufferHdWrite = 0;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b010011://input
			begin
				halt <= 1;
				RegWrite <= 1;
				RegDst <= 2'b01;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b11;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b00000;
				inputInst = 1;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b010100://output
			begin
				halt <= 1;
				RegWrite <= 0;
				RegDst <= 2'b00;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 1;
				MemToReg <= 2'b00;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b00000;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 1;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b010110://SGTI
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b00;
				ALUSrc <= 1;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b10;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b10001;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b010111://SLETI
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b00;
				ALUSrc <= 1;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b10;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b10010;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b011000://SGETI
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b00;
				ALUSrc <= 1;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b10;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b10011;
				inputInst = 0;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b011001://SETI
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b00;
				ALUSrc <= 1;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b10;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b10100;
				inputInst = 0;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b011010://SDTI
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b00;
				ALUSrc <= 1;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b10;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b10101;
				inputInst = 0;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b011011://GETPC
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b01;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b0;
				ALUOp <= 5'b00000;
				inputInst = 0;
				MemToReg2 <= 2'b01;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b011100://enableTimer
			begin
				halt <= 0;
				RegWrite <= 0;
				RegDst <= 2'b01;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b0;
				ALUOp <= 5'b00000;
				inputInst = 0;
				MemToReg2 <= 2'b00;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				enableTimer <=2'b11;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b011101://disableTimer
			begin
				halt <= 0;
				RegWrite <= 0;
				RegDst <= 2'b00;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b0;
				ALUOp <= 5'b00000;
				inputInst = 0;
				MemToReg2 <= 2'b00;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				enableTimer <=2'b10;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b011110://BufferToHd
			begin
				halt <= 0;
				RegWrite <= 0;
				RegDst <= 2'b00;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b0;
				ALUOp <= 5'b00000;
				inputInst = 0;
				MemToReg2 <= 2'b00;
				outputInst = 0;
				HdWrite = 1;
				BufferHdWrite = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b011111://RegToBuffer
			begin
				halt <= 0;
				RegWrite <= 0;
				RegDst <= 2'b00;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b0;
				ALUOp <= 5'b00000;
				inputInst = 0;
				MemToReg2 <= 2'b00;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 1;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b100000://HdToReg
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b11;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b0;
				ALUOp <= 5'b00000;
				inputInst = 0;
				MemToReg2 <= 2'b10;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
		6'b100001://RegToInst
			begin
				halt <= 0;
				RegWrite <= 0;
				RegDst <= 2'b00;
				ALUSrc <= 1;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b0;
				ALUOp <= 5'b00000;
				inputInst = 0;
				MemToReg2 <= 2'b00;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 1;
				JalJumpReg <= 0;
			end
		6'b100010://JumpAndLinkReg
			begin
				halt <= 0;
				RegWrite <= 1;
				RegDst <= 2'b10;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b01;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b00000;
				inputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				outputInst = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 1;
			end
		6'b100011://JumpReg
			begin
				halt <= 0;
				RegWrite <= 0;
				RegDst <= 2'b00;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b0;
				ALUOp <= 5'b00000;
				inputInst = 0;
				MemToReg2 <= 2'b00;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <=1;
				opPID <= 0;
			end
		6'b100100://ShowPID
			begin
				halt <= 0;
				RegWrite <= 0;
				RegDst <= 2'b00;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b0;
				ALUOp <= 5'b00000;
				inputInst = 0;
				MemToReg2 <= 2'b00;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <=0;
				opPID <= 1;
			end
		default:
			begin
				halt <= 0;
				RegWrite <= 0;
				RegDst <= 2'b00;
				ALUSrc <= 0;
				Branch <= 0;
				Jump <= 0;
				JumpR <=0;
				MemOp <= 0;
				OpIO <= 0;
				MemToReg <= 2'b00;
				MemToReg2 <= 2'b00;
				ALUOp <= 5'b00000;
				inputInst = 0;
				outputInst = 0;
				HdWrite = 0;
				BufferHdWrite = 0;
				enableTimer <=2'b00;
				InstMemWrite <= 0;
				JalJumpReg <= 0;
				opPID <= 0;
			end
			
	endcase
end



endmodule 