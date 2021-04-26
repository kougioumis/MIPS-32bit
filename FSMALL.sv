module FSMALL(op, funct, MemToReg, MemWrite, MemRead, Branch, ALUSrc, RegDst, RegWrite, ALUOp, ALUControl);

input [5:0] op, funct;
output [1:0] ALUOp;
output reg MemToReg, MemWrite, MemRead, Branch, ALUSrc, RegDst, RegWrite;
output reg [3:0] ALUControl;
reg [1:0] ALUOp;


always @(op)
//begin
if (op==6'b000000)
begin
	MemToReg=1'b0;
	MemWrite=1'b0;
	MemRead=1'b0;
	Branch=1'b0;
	ALUSrc=1'b0;
	RegDst=1'b1;
	RegWrite=1'b1;
	ALUOp=2'b10;
end

else if (op==6'b100011)
begin 
	MemToReg=1'b1;
	MemWrite=1'b0;
	MemRead=1'b1;
	Branch=1'b0;
	ALUSrc=1'b1;
	RegDst=1'b0;
	RegWrite=1'b1;
	ALUOp=2'b00;
end
else if (op==6'b101011)
begin
	MemToReg=1'bx;
	MemWrite=1'b1;
	MemRead=1'b0;
	Branch=1'b0;
	ALUSrc=1'b1;
	RegDst=1'bx;
	RegWrite=1'b0;
	ALUOp=2'b00;
end

else if (op==6'b000100)
begin
	MemToReg=1'bx;
	MemWrite=1'b0;
	MemRead=1'b0;
	Branch=1'b1;
	ALUSrc=1'b0;
	RegDst=1'bx;
	RegWrite=1'b0;
	ALUOp=2'b01;
end



else
begin
	MemToReg=1'bx;
	MemWrite=1'bx;
	Branch=1'bx;
	ALUSrc=1'bx;
	RegDst=1'bx;
	RegWrite=1'bx;
	ALUOp=2'bx;
end

//end
always@(ALUOp)
begin
case(funct)
	6'b100000: //add
	ALUControl=4'b0010;
	
	6'b100010: //sub
	ALUControl=4'b0110;
	
	6'b100100: //and
	ALUControl=4'b0000;
	
	6'b100101: //or
	ALUControl=4'b0001;
	
	6'b101010: //slt
	ALUControl=4'b0111;
	
	6'b111110: //ulopoihsh NOR gia opcode=111110
	ALUControl=4'b1010;
default:
//if (ALUOp==2'b00)


ALUControl = ( ALUOp==2'b00 )? 4'b0010 : 4'b0110 ;


endcase
end
//end
endmodule