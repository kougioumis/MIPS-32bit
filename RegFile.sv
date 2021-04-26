module RegFile (clock, reset, raA, raB, wa, wen, wd, rdA, rdB);

// was completed in Lab5

	input reset;
	input clock;
	input        wen;
	input [4:0]  wa;
	input [31:0] wd;
	input [4:0]   raA;
	input [4:0]   raB;
	output [31:0] rdA;
	output [31:0] rdB;

	reg [31:0] regfile[0:31];  
	//wire rdA, rdB;
	integer i;
	
always @(negedge clock)
	begin
	if (~(reset)) 
		begin
		for ( i=0;  i<31; i=i+1)begin
			regfile[i]<=0;
		end
	end
	else 
	begin
		if (wen)
		regfile[wa]<=wd;
		//else !if (reset)
		
		end
	end
	assign rdA=regfile[raA];
	assign rdB=regfile[raB];
endmodule

