module Temporizador(
	input [5:0] opcode,
	input clock50M,
	input enterFlag, 
	output reg clock
);
    reg [19:0] contador;

    always@(posedge clock50M) 
	 begin
		contador <= contador + 1;		
		if(opcode == 25 || opcode == 26)
		begin
			 clock <= enterFlag;
		end
		else
		begin
			 clock <= contador [19];
		end
	end


endmodule 