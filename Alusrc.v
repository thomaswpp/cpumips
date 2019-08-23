module Alusrc
(
	input sign,
	input [31:0] dataReg,
	input [31:0] dataExt,
	output reg [31:0] dataOut

);


	always@(*) begin
		case(sign) 
			0: dataOut = dataReg; 
			1: dataOut = dataExt;
			default: dataOut = 32'bz;
		endcase
		
	end

endmodule 