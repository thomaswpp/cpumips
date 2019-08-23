module MuxBios(
	input sign		,
	input [31:0] instBios	,
	input [31:0] inst	,
	output reg[31:0] dataOut
);

	always@(*) begin
		case(sign)
			0: dataOut = instBios;
			1: dataOut = inst;
			default: dataOut = instBios;
		endcase
	end	
endmodule 

