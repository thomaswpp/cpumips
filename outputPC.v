module outputPC(
	input signOut				,
	input [31:0] pc			,
	output [6:0] Dsp6			,
	output [6:0] Dsp5			,
	output [6:0] Dsp4			
);

	
	reg [3:0] six;
	reg [3:0] five;
	reg [3:0] four;
	
	reg [31:0] data;
	
	integer i;
	
	always@(pc) begin
			
		data = pc;
		
		six = 4'd0;
		five = 4'd0;
		four = 4'd0;
		
		for (i=9; i>=0; i=i-1) begin
			
			//PC
			if(six >= 5)
				six = six + 3;
			if(five >= 5)
				five = five + 3;
			if(four >= 5)
				four = four + 3;
				
			six = six << 1;
			six[0] = five[3];
			
			five = five << 1;
			five[0] = four[3];
			
			four = four << 1;	
			four[0] = pc[i];
			
		end
		
	end
	
	
	Display Six 	(.signOut(signOut), .inNumber(six), 	.outNumber(Dsp6));
	Display Five 	(.signOut(signOut), .inNumber(five), 	.outNumber(Dsp5));
	Display Four 	(.signOut(signOut), .inNumber(four), 	.outNumber(Dsp4));
	
endmodule 