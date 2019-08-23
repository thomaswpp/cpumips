module alu(
    input [4:0] aluOp        , 
    input [31:0] operandoA   , 
    input [31:0] operandoB   , 
    output reg [31:0] aluOut , 
    output zero        		  , 
    input [15:0] shamt
);
	
	always@(aluOp or operandoA or operandoB) begin
	
		case(aluOp[4:0])
			0:  aluOut = operandoA; //move
			1:  aluOut = operandoA + operandoB; //add
			2:  aluOut = operandoA - operandoB; //sub
			3:  aluOut = operandoA & operandoB; //and
			4:  aluOut = operandoA | operandoB; //or
			5:  aluOut = ~operandoA; //not
			6:  aluOut = operandoA ^ operandoB; //xor
			7:  aluOut = operandoA == operandoB ? 1 : 0; //eq
			8:  aluOut = operandoA < operandoB ? 1 : 0; //slt
			9:  aluOut = operandoA > operandoB ? 1 : 0; //sgt
			10: aluOut = operandoA < operandoB ? 0 : 1; //blt
			11: aluOut = operandoA > operandoB ? 0 : 1; //bgt	
			//12: aluOut = operandoA << shamt; //sll
			//13: aluOut = operandoA >> shamt; //slr
			14:  aluOut = operandoA != operandoB ? 1 : 0; //diff
			15:  aluOut = operandoA <= operandoB ? 1 : 0; //sle
			16:  aluOut = operandoA >= operandoB ? 1 : 0; //sge
         default aluOut = 32'bz;
		endcase
	end
	
   assign zero = (aluOut==0);

endmodule	
