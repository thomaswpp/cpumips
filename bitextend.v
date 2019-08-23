module bitextend(
	sign	, 
	in_16	, 
	out_32
);

	input sign;
	input [15:0] in_16;
	
	output reg [31:0] out_32;
	
	always@(*) begin
		if(sign) begin
			if(in_16[15] == 1) //nro negativo
				out_32 = { 16'd1, in_16 };	
			else begin
				out_32 = { 16'd0, in_16 };
			end
		end
		
	end

endmodule 
