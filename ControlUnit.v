module ControlUnit(
	input [5:0] opcode,
	input inSign,
	input clock,
	input branch,
	input reset,
	output reg [2:0] RegDst,
	output reg ALUSrc,
	output reg writeREG,
	output reg MemWrite,
	output reg ExtendSign,
	output reg OutputSign,
	output reg [1:0] PCSign,
	output reg flagWriteInst,
	output reg FlagWriteHD,
	output reg singOut
);


	reg [1:0] currentState;
	reg [1:0] nextState;
	

	always@(posedge clock) begin
		if (reset)
			currentState <= 0;
		else
			currentState <= nextState;	
	end

	always@(*) begin
		nextState = currentState;
		case(currentState)
			0: nextState = 1;
			1: nextState = 1;	
		endcase
	end
	
	always@(*) begin
		  
		  
		  
		flagWriteInst = 0;
		FlagWriteHD = 0;
		singOut = 0;
		  
        if(currentState == 0) begin //resetCPU
				PCSign = 2'b11;
				OutputSign = 0;
				ExtendSign = 0;
				RegDst = 3'bxx;
				ALUSrc = 1'bx;
				MemWrite = 0;
				writeREG = 0;
        end else begin
		
		    case(opcode[5:0])
		
			    0: begin //add
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'b01;
				    ALUSrc = 0;
				    MemWrite = 0;
				    writeREG = 1;
			    end
			
			    1:begin //addi
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 1;
				    RegDst = 3'b01;
				    ALUSrc = 1;
				    MemWrite = 0;
				    writeREG = 1;
			    end
			
			    2: begin //sub
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'b01;
				    ALUSrc = 0;
				    MemWrite = 0;
				    writeREG = 1;
			    end
			
			    3:begin //subi
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 1;
				    RegDst = 3'b01;
				    ALUSrc = 1;
				    MemWrite = 0;
				    writeREG = 1;
			    end
			
			    4: begin //not
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'b01;
				    ALUSrc = 0;
				    MemWrite = 0;
				    writeREG = 1;
			    end
			
			    5:begin //seq MODIFICADO and
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'b01;
				    ALUSrc = 0;
				    MemWrite = 0;
				    writeREG = 1;
			    end
			
			    6: begin //sne MODIFICADO andi
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'b01;
				    ALUSrc = 0;
				    MemWrite = 0;
				    writeREG = 1;
			    end
			
			    7:begin //slt MODIFICADO or
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'b01;
				    ALUSrc = 0;
				    MemWrite = 0;
				    writeREG = 1;
			    end
			
			    8: begin //sle MODIFICADO ori
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'b01;
				    ALUSrc = 0;
				    MemWrite = 0;
				    writeREG = 1;
			    end
			
			    9:begin //sgt MODIFICADO slt
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'b01;
				    ALUSrc = 0;
				    MemWrite = 0;
				    writeREG = 1;
			    end
			
			    10: begin //sge MODIFICADO slti
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'b01;
				    ALUSrc = 0;
				    MemWrite = 0;
				    writeREG = 1;
			    end
			
			    11:begin //lw
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 1;
				    RegDst = 3'b00;
				    ALUSrc = 0;
				    MemWrite = 0;
				    writeREG = 1;
			    end

			    12:begin //li
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 1;
				    RegDst = 3'b11;
				    ALUSrc = 1;
				    MemWrite = 0;
				    writeREG = 1;
			    end

			    13:begin //lwr AJUSTAR
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'b00;
				    ALUSrc = 0;
				    MemWrite = 0;
				    writeREG = 1;
			    end
				 
			    14: begin //sw
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 1;
				    RegDst = 3'bxx;
				    ALUSrc = 0;
				    MemWrite = 1;
				    writeREG = 0;
			    end

				15: begin //swr AJUSTAR
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'bxx;
				    ALUSrc = 0;
				    MemWrite = 1;
				    writeREG = 0;
			    end
			
			    16:begin //move
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'b01;
				    ALUSrc = 0;
				    MemWrite = 0;
				    writeREG = 1;
			    end
			
			    17: begin //beq
			      case(branch)
					    0: begin //branch não tomado
						    PCSign = 2'b00;
						    OutputSign = 0;
						    ExtendSign = 0;
						    RegDst = 3'b01;
						    ALUSrc = 0;
						    MemWrite = 0;
						    writeREG = 0;
     					 end
					    1: begin //branch tomado
						    PCSign = 2'b01;
						    OutputSign = 0;
						    ExtendSign = 1;
						    RegDst = 3'b01;
						    ALUSrc = 0;
						    MemWrite = 0;
						    writeREG = 0;						
					    end
				    endcase 
			    end
			
			    18:begin //bne
			      case(branch)
					    0: begin //branch tomado
						    PCSign = 2'b01;
						    OutputSign = 0;
						    ExtendSign = 0;
						    RegDst = 3'bxx;
						    ALUSrc = 0;
						    MemWrite = 0;
						    writeREG = 0;
     					 end
					    1: begin //branch não tomado
						    PCSign = 2'b00;
						    OutputSign = 0;
						    ExtendSign = 0;
						    RegDst = 3'bxx;
						    ALUSrc = 0;
						    MemWrite = 0;
						    writeREG = 0;						
					    end
				    endcase 				
			    end

			    19:begin //blt
					case(branch)
					    0: begin //branch não tomado
						    PCSign = 2'b00;
						    OutputSign = 0;
						    ExtendSign = 0;
						    RegDst = 3'bxx;
						    ALUSrc = 0;
						    MemWrite = 0;
						    writeREG = 0;
     					end
					    1: begin //branch tomado
						    PCSign = 2'b01;
						    OutputSign = 0;
						    ExtendSign = 1;
						    RegDst = 3'bxx;
						    ALUSrc = 0;
						    MemWrite = 0;
						    writeREG = 0;						
					    end
				    endcase 				
			    end

			    20:begin //bgt
			      case(branch) 
							 0: begin //branch não tomado
								 PCSign = 2'b00;
								 OutputSign = 0;
								 ExtendSign = 0;
								 RegDst = 3'b01;
								 ALUSrc = 0;
								 MemWrite = 0;
								 writeREG = 0;
							end
							 1: begin //branch tomado
								 PCSign = 2'b01;
								 OutputSign = 0;
								 ExtendSign = 1;
								 RegDst = 3'b01;
								 ALUSrc = 0;
								 MemWrite = 0;
								 writeREG = 0;						
							 end
				    endcase 				
			    end
			
			    21: begin //jump
				    PCSign = 2'b01;
				    OutputSign = 0;
				    ExtendSign = 1;
				    RegDst = 3'b01;
				    ALUSrc = 1;
				    MemWrite = 0;
				    writeREG = 0;
			    end
			
			    22:begin //jr
				    PCSign = 2'b01;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'b01;
				    ALUSrc = 0;
				    MemWrite = 0;
				    writeREG = 0;
			    end
			
			    23: begin //nop
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'bxx;
				    ALUSrc = 1'bx;
				    MemWrite = 0;
				    writeREG = 0;
			    end
			
			    24:begin //hlt
				    PCSign = 2'b10;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'bxx;
				    ALUSrc = 1'bx;
				    MemWrite = 0;
				    writeREG = 0;
			    end

			    25: begin //in
					 PCSign = 2'b00;
					 OutputSign = 0;
					 ExtendSign = 1;
					 RegDst = 3'b10;
					 ALUSrc = 1'bx;
					 MemWrite = 0;
					 writeREG = 1;
				 end
				 
			    26:begin //out
				    PCSign = 2'b00;
				    OutputSign = 1;
				    ExtendSign = 0;
				    RegDst = 3'bxx;
				    ALUSrc = 1'bx;
				    MemWrite = 0;
				    writeREG = 0;
					 singOut = 1;
			    end				 
				 			 
				 
			    30:begin //RegToHD
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'bxx;
				    ALUSrc = 1'bx;
				    MemWrite = 0;
				    writeREG = 0;
					 FlagWriteHD = 1;
			    end
				 		 
				 
			    31:begin //HDtoReg
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'b100;
				    ALUSrc = 1'bx;
				    MemWrite = 0;
				    writeREG = 1;
			    end
				 				 
			    32:begin //HDMI
				    PCSign = 2'b00;
				    OutputSign = 0;
				    ExtendSign = 0;
				    RegDst = 3'bxx;
				    ALUSrc = 1'bx;
				    MemWrite = 0;
				    writeREG = 0;
					 flagWriteInst = 1;
			    end		 
				 			 
				 
				default: begin
					PCSign = 2'b11;
					OutputSign = 0;
					ExtendSign = 0;
					RegDst = 3'bxx;
					ALUSrc = 1'bx;
					MemWrite = 0;
					writeREG = 0;
				end
		    endcase
	    end //end else
	end
	

endmodule 
