`timescale 1ns/1ps
`include "RegFile"
`include "Memory"
`include "ALU"
`include "DataMemory"
`include "sign_extension"



module cpu(clock, reset);
input clock, reset;
wire [4:0] WReg, raA, raB, wa;
wire [5:0] op, funct;
wire [31:0] pcin, out, S_extOut, BranchAddress, MD_out, MD_DataOut;
wire inA, inB, ALU_zero, ALU_out, wen, ren, FSM_RegWrite, FSM_ALUSrc, FSM_MemWrite, FSM_MemToReg, FSM_MemRead, FSM_Branch, FSM_RegDst, AND;
wire [15:0] S_extIn;

reg [31:0]pcout,pc;
always @(posedge clock )
begin
if (reset)
	pc=0;
else 
pc =  pcin;
//assign pcout=32'b0;
end

assign wen=1;
assign ren=0;

Memory b(ren, wen, pcout, din, dout);


assign out= dout;
assign op=out[31:26];
assign funct=out[5:0];

FSMALL cd(op, funct, MemToReg, MemWrite, MemRead , Branch, ALUSrc, RegDst, RegWrite, ALUOp, ALUControl);

assign op=ALUControl;
assign raA=out[25:21]; //adres $t2        add $to, $t1, $t2
assign raB=out[20:16]; // addres $t1
assign wa=out[15:11];  //addres $t0
assign S_extIn= out[15:0];


sign_extension i(S_extIn, S_extOut);


assign S_extOut=S_extOut;
assign FSM_RegWrite=RegWrite;
assign FSM_ALUSrc=ALUSrc;
assign FSM_MemWrite=MemWrite;
assign FSM_MemToReg=MemToReg;
assign FSM_MemRead=MemRead;
assign FSM_Branch=Branch;
assign FSM_RegDst=RegDst;


assign WReg = (RegDst==1)? wa : raB; 


RegFile e(clock, reset, raA, raB, WReg, FSM_RegWrite, MD_DataOut, rdA, rdB);

assign inB = (ALUSrc==1)? rdB : S_extOut; 


assign inA=rdA;
assign S_extOut= S_extOut << 2 ;
assign Branch_Address= S_extOut + pcout ;





ALU g(out, zero, inA, inB, op);
assign ALU_zero=zero;
assign AND = FSM_Branch & ALU_zero ;

assign ALU_out=out;
assign pcin= (AND)? Branch_Address : pcout ;

always @(posedge clock)
begin

	pcout =  pc+4 ;

end

DataMemory h(ALU_out, FSM_WriteData, FSM_MemWrite, FSM_MemRead, rDataOut);

assign MD_DataOut=rDataOut;
assign MD_out= (FSM_MemToReg==1)? MD_DataOut : ALU_out ;


endmodule 
