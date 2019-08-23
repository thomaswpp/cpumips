module Mux(
	input [2:0] sign		,
	input [31:0] dataRam	,
	input [31:0] dataAlu	,
	input [31:0] dataIn	,
	input [31:0] dataExt	,
	input [31:0] dataHd	,
	output reg[31:0] dataOut
);

	
	always@(*) begin
		case(sign[1:0])
			0: dataOut = dataRam;
			1: dataOut = dataAlu;
			2: dataOut = dataIn;
			3: dataOut = dataExt;
			4: dataOut = dataHd;
			default: dataOut = 32'bz;
		endcase
	end
	

endmodule 
