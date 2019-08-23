module Output(
	input signOut				,
	input [31:0] outLine		,
	input exibirFlag,
	output [6:0] signDsp		,
	output [6:0] DspHundreds, 
	output [6:0] DspTens		, 
	output [6:0] DspOnes					
);

	reg [3:0] Hundreds;
	reg [3:0] Tens;
	reg [3:0] Ones;
	reg [3:0] negative;
	
	reg [31:0] data;
	
	integer i;
	
	always@(outLine) 
	begin
		if(exibirFlag == 1)
		begin
			if(outLine[31] == 1)
				data = ~(outLine - 1);
			else
				data = outLine;
						
			
			Hundreds = 4'd0;
			Tens = 4'd0;
			Ones = 4'd0;
			
			
			for (i=9; i>=0; i=i-1) 
			begin
				
				if(Hundreds >= 5)
					Hundreds = Hundreds + 3;
				if(Tens >= 5)
					Tens = Tens + 3;
				if(Ones >= 5)
					Ones = Ones + 3;				
				
				Hundreds = Hundreds << 1;
				Hundreds[0] = Tens[3];
				
				Tens = Tens << 1;
				Tens[0] = Ones[3];
				
				Ones = Ones << 1;
				Ones[0] = data[i];
				
			end
		end				
	end
	
	
	Display S (.signOut(signOut), .inNumber(negative) , .outNumber(signDsp));
	Display A (.signOut(signOut), .inNumber(Hundreds), .outNumber(DspHundreds));
	Display B (.signOut(signOut), .inNumber(Tens), .outNumber(DspTens));
	Display C (.signOut(signOut), .inNumber(Ones), .outNumber(DspOnes));
	
	
endmodule 