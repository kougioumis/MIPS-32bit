// Define top-level testbench
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Top level has no inputs or outputs
// It only needs to instantiate CPU, Drive the inputs to CPU (clock, reset)
// and monitor the outputs. This is what all testbenches do

`include "constants.h"    // Header file with opcodes
`timescale 1ns/1ps


module cpu_tb;
integer   i;
reg       clock, reset;    // Clock and reset signals

// Instantiate CPU here with name cpu0
cpu cpu0(clock, reset);

// Initialization and signal generation



  // Initialize the module 
initial begin
	
   //cpu0.pcout=1'b0;
   clock = 1'b0;       
   reset = 1'b1;  // Apply reset for a few cycles
   #(4*5/*`clock_period*/) reset = (~(reset));

   
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Generate clock and reset signal here



  // Initialize Register File with initial values. 
  // cpu0 is the name of the cpu instance
  // cpu_regs is the name of the register file instance in the CPU verilog file 
  // data[] is the register file array 
//initial 
//    begin  


	// Initilization of Instruction Memory
//cpu0.b.data[0] = 32'h012A4020; //add

//cpu0.b.data[4] = 32'h012A4023; //sub R/6,R5,R4
//cpu0.b.data[8] = 32'h2128000C;

      for (i = 0; i <= 33; i = i+1)
        cpu0.e.regfile[i] = 0;   // Note that R0 = 0 in MIPS 

       for (i = 0; i<= 4096; i = i+2)
	cpu0.b.data[i]=32'h012A4020;  
	cpu0.b.data[i+1]=32'h012A4023; 

      

 // Initialize Data Memory. You have to develop "program.hex" as a text file 
  // which containsthe instruction opcodes as 32-bit hexadecimal values.
  //$readmemh("filenew.hex", cpu0.b.data);

  // Edw, to "program.hex" einai ena arxeio pou prepei na brisketai sto 
  // directory pou trexete th Verilog kai na einai ths morfhs:
  
  // @0    00000000
  // @4    20100009
  // @8    00000000
  // @C    00000000
  // ...
  
  // H aristerh sthlh, meta to @, exei th dieythynsh ths mnhmhs (hex),
  // kai h deksia sthlh ta dedomena sth dieythynsh ayth (pali hex).
  // Sto paradeigma pio panw, oi lekseis stis dieythynseis 0, 8 kai 12
  // einai 0, kai sth dieythynsh 4 exei thn timh 32'h20100009. An o PC
  // diabasei thn dieythynsh 4, h timh ekei exei thn entolh
  //   addi $16 <- $0 + 9

  // To deytero orisma ths $readmemh einai pou akribws brisketai h mnhmh
  // pou tha arxikopoihthei. Sto paradeigma, to "dat0" einai to onoma pou
  // dwsame sto instance tou datapath. To "mem" einai to onoma pou exei
  // to instance ths mnhmhs MESA sto datapath, kai to "data" einai to 
  // onoma pou exei to pragmatiko array ths mhnhs mesa sto module ths.
  // An exete dwsei diaforetika onomata, allakste thn $readmemh.

  // Enallaktika, an sas boleyei perissotero, yparxei h entolh $readmemb
  // me thn akribws idia syntaksh. H aristerh sthlh tou arxeiou exei
  // thn idia morfh (dieythynseis se hex), alla h deksia sthlh exei
  // ta dedomena sto dyadiko. Etsi h add mporouse na einai:

  // @4    00100000000100000000000000001001

  // ... h kai akoma kalytera:
  
  // @4    001000_00000_10000_0000000000001001

  // (h Verilog epitrepei diaxwristika underscores).


  // Termatismos ekteleshs:
  // $finish;

end  // initial 

always 
   #(/*`clock_period*/ 5 / 2) clock = ~clock;  
   

endmodule