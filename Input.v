module Input(
	clock	,
	sign	,
	keyIn	,
	dataOut
);

	input clock;
	input sign;
	input [15:0] keyIn;
	
	output reg[15:0] dataOut;
	
	always@(posedge clock) begin
	
		if(sign) begin
			dataOut = keyIn;
		end
		
	end

endmodule 
