module DataMemory(Addr, WriteData, MemWrite, MemRead, rDataOut);

input [31:0] Addr, WriteData;
input MemWrite, MemRead;
output reg [31:0] rDataOut;

reg [31:0] DataMemory_array [1023:0]; // 32x32bits registers

always@(Addr or WriteData or MemWrite or MemRead)

if(MemWrite)
begin
	DataMemory_array[Addr]<=WriteData; //write operation
end

always@(Addr or WriteData or MemWrite or MemRead)
if(MemRead)
	rDataOut<=DataMemory_array[Addr];

endmodule