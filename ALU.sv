module ALU #(parameter N=32) (out, zero, inA, inB, op);

// was completed in Lab5
output [N-1:0] out;
  output zero;
  input  [N-1:0] inA, inB;
  input  [3:0] op;

reg [N-1:0] out;

always @(op)

begin

  if (op==4'b0000)
    out<= inA & inB;

  else if(op==4'b0001)
    out<= inA | inB;

  else if(op==4'b0010)
    out<= inA + inB;

  else if(op==4'b0110)

    out<= inA + (~inB+1'b1);

  else if(op==4'b0111)
    out<=((inA <inB)?1:0);

  else if(op==4'b1010)
    out<= ~( inA | inB);
  
  else 
    out= 32'bx;
end



reg zero;

always @(op)
begin

#1 if (out)
    zero<=0'b0;
   else 
    zero<=0'b1;
    
end

endmodule



