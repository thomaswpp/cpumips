module Display(
	signOut		, 
	inNumber	,
	outNumber   ,
);

	input signOut;
	input[3:0] inNumber;
	
	output reg[6:0] outNumber;
	
	always@(*) begin
        if(signOut) begin
		    case(inNumber)
			    0: outNumber = 7'b0000001; //1
			    1: outNumber = 7'b1001111; //79
			    2: outNumber = 7'b0010010; //18
			    3: outNumber = 7'b0000110; //6
			    4: outNumber = 7'b1001100; //76
			    5: outNumber = 7'b0100100; //36
			    6: outNumber = 7'b0100000; //32
			    7: outNumber = 7'b0001101; //13
			    8: outNumber = 7'b0000000; //0
			    9: outNumber = 7'b0000100; //4
			    10: outNumber = 7'b1111110; //126
			    default: outNumber = 7'b1111111; //127
		    endcase
        end else
		  outNumber = 7'b1111111; //127
		  //end else
				//outNumber = 7'b1111111; //127
	end
	

endmodule 
