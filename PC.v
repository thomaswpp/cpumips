module PC(
	clock				, 
	sign				, 
	address			, 
	pc ,
	flagBios,
	flagMuxBios
);
	 
	reg flagBiosAnterior;
	
	 input[31:0] address;
	 input[1:0] sign;
	 input clock;
	 input flagBios;
	 output reg flagMuxBios;
	 
	 
	 output reg[31:0] pc;

    integer firstclk = 1;
	 
	 
	 always@(posedge clock) begin
        if(firstclk)begin
            pc = 0;
			firstclk <= 0;
			flagBiosAnterior <= flagBios;
		end
		else 
		begin
			case(sign)
				0:	pc = pc + 1; //increment + 1	
				1: pc = address; //newaddress
				2: pc = pc; //hlt
				3: pc = 0; // resetCPU
			endcase	
		
		end	
		if(flagBios == 1 && flagBiosAnterior == 0)
		begin
			pc = 0; // inicia memoria de instruçoes
			//flagMuxBios = 1;
		end
		flagMuxBios <= flagBios;
		flagBiosAnterior <= flagBios;
		
	 end
	 
endmodule 
