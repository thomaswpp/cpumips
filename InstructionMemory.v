
/*
module InstructionMemory(
	address	, 
	clock		, 
	instruction,
	clk
);
*/
// Quartus Prime Verilog Template
// Simple Dual Port RAM with separate read/write addresses and
// separate read/write clocks
	
module InstructionMemory
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=13)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] read_setor, write_setor, 
	input [12:0] read_trilha, write_trilha,
	input write_clock, read_clock, flagWrite, 
	output reg [(DATA_WIDTH-1):0] instruction
);
	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] instructionRAM[2**ADDR_WIDTH-1:0];
	reg [31:0] enderecoW, enderecoR;
	
	always @ (posedge write_clock)
	begin
		// Write
		
		//Funcao que será usada, esta comentado apenas para teste
		if (flagWrite)
		begin
//			enderecoW <= write_setor + (write_trilha * 1000);
			instructionRAM[write_setor] <= data;	
		
		end	
	

	//FIBONACCI
	/*
instructionRAM[0] = { 6'd21, 16'd29, 10'd0 };
instructionRAM[1] = { 6'd12, 5'd1, 16'd0, 5'd0 };
instructionRAM[2] = { 6'd14, 5'd1, 16'd2, 5'd0 };
instructionRAM[3] = { 6'd12, 5'd1, 16'd0, 5'd0 };
instructionRAM[4] = { 6'd14, 5'd1, 16'd3, 5'd0 };
instructionRAM[5] = { 6'd12, 5'd1, 16'd1, 5'd0 };
instructionRAM[6] = { 6'd14, 5'd1, 16'd4, 5'd0 };
instructionRAM[7] = { 6'd12, 5'd1, 16'd0, 5'd0 };
instructionRAM[8] = { 6'd14, 5'd1, 16'd5, 5'd0 };
instructionRAM[9] = { 6'd11, 5'd1, 16'd2, 5'd0 };
instructionRAM[10] = { 6'd11, 5'd2, 16'd1, 5'd0 };
instructionRAM[11] = { 6'd7, 5'd10, 5'd1, 5'd2, 11'd0 };
instructionRAM[12] = { 6'd17, 5'd10, 5'd0, 16'd26};
instructionRAM[13] = { 6'd11, 5'd1, 16'd3, 5'd0 };
instructionRAM[14] = { 6'd11, 5'd2, 16'd4, 5'd0 };
instructionRAM[15] = { 6'd0, 5'd11, 5'd1, 5'd2, 11'd0 };
instructionRAM[16] = { 6'd14, 5'd11, 16'd5, 5'd0 };
instructionRAM[17] = { 6'd11, 5'd1, 16'd4, 5'd0 };
instructionRAM[18] = { 6'd14, 5'd1, 16'd3, 5'd0 };
instructionRAM[19] = { 6'd11, 5'd1, 16'd5, 5'd0 };
instructionRAM[20] = { 6'd14, 5'd1, 16'd4, 5'd0 };
instructionRAM[21] = { 6'd11, 5'd1, 16'd2, 5'd0 };
instructionRAM[22] = { 6'd12, 5'd2, 16'd1, 5'd0 };
instructionRAM[23] = { 6'd0, 5'd12, 5'd1, 5'd2, 11'd0 };
instructionRAM[24] = { 6'd14, 5'd12, 16'd2, 5'd0 };
instructionRAM[25] = { 6'd21, 16'd9, 10'd0 };
instructionRAM[26] = { 6'd11, 5'd30, 16'd3, 5'd0 };
instructionRAM[27] = { 6'd11, 5'd31, 16'd0, 5'd0 };
instructionRAM[28] = { 6'd22, 5'd31, 21'd0 };
instructionRAM[29] = { 6'd25, 5'd13, 21'd0 };
instructionRAM[30] = { 6'd14, 5'd13, 16'd7, 5'd0 };
instructionRAM[31] = { 6'd11, 5'd1, 16'd7, 5'd0 };
instructionRAM[32] = { 6'd14, 5'd1, 16'd1, 5'd0 };
instructionRAM[33] = { 6'd12, 5'd1, 16'd36, 5'd0 };
instructionRAM[34] = { 6'd14, 5'd1, 16'd0, 5'd0 };
instructionRAM[35] = { 6'd21, 16'd1, 10'd0 };
instructionRAM[36] = { 6'd26, 5'd30, 21'd0 };
instructionRAM[37] = { 6'd24, 26'd0 };
*/
		
	end
	
	always @ (posedge read_clock)
	begin
		// Read 
		//if(read_trilha == 0)
		//	enderecoR <= read_setor;		
		//else
		//	enderecoR <= read_setor + 1000;
		instruction <= instructionRAM[read_setor];
		//q <= ram[read_addr];
	end
	
endmodule
	
/*
//BACKUP

	input[31:0] address;
	input clock;
	input clk;
	
	output[31:0] instruction;
	
	integer firstclock = 1;

	
	//RAM Instruction varieble, 23 address
	reg[31:0] instructionRAM[200:0];
	
	always@(posedge clock) begin
		if(firstclock) begin	

instructionRAM[0] = { 6'd21, 16'd22, 10'd0 };
instructionRAM[1] = { 6'd11, 5'd1, 16'd1, 5'd0 };
instructionRAM[2] = { 6'd11, 5'd2, 16'd2, 5'd0 };
instructionRAM[3] = { 6'd6, 5'd10, 5'd1, 5'd2, 11'd0 };
instructionRAM[4] = { 6'd17, 5'd10, 5'd0, 16'd19};
instructionRAM[5] = { 6'd11, 5'd1, 16'd1, 5'd0 };
instructionRAM[6] = { 6'd11, 5'd2, 16'd2, 5'd0 };
instructionRAM[7] = { 6'd9, 5'd11, 5'd1, 5'd2, 11'd0 };
instructionRAM[8] = { 6'd17, 5'd11, 5'd0, 16'd14};
instructionRAM[9] = { 6'd11, 5'd1, 16'd1, 5'd0 };
instructionRAM[10] = { 6'd11, 5'd2, 16'd2, 5'd0 };
instructionRAM[11] = { 6'd2, 5'd12, 5'd1, 5'd2, 11'd0 };
instructionRAM[12] = { 6'd14, 5'd12, 16'd1, 5'd0 };
instructionRAM[13] = { 6'd21, 16'd18, 10'd0 };
instructionRAM[14] = { 6'd11, 5'd1, 16'd2, 5'd0 };
instructionRAM[15] = { 6'd11, 5'd2, 16'd1, 5'd0 };
instructionRAM[16] = { 6'd2, 5'd13, 5'd1, 5'd2, 11'd0 };
instructionRAM[17] = { 6'd14, 5'd13, 16'd2, 5'd0 };
instructionRAM[18] = { 6'd21, 16'd1, 10'd0 };
instructionRAM[19] = { 6'd11, 5'd30, 16'd1, 5'd0 };
instructionRAM[20] = { 6'd11, 5'd31, 16'd0, 5'd0 };
instructionRAM[21] = { 6'd22, 5'd31, 21'd0 };
instructionRAM[22] = { 6'd12, 5'd1, 16'd0, 5'd0 };
instructionRAM[23] = { 6'd26, 5'd1, 21'd0 };
instructionRAM[24] = { 6'd25, 5'd14, 21'd0 };
instructionRAM[25] = { 6'd14, 5'd14, 16'd4, 5'd0 };
instructionRAM[26] = { 6'd25, 5'd15, 21'd0 };
instructionRAM[27] = { 6'd14, 5'd15, 16'd5, 5'd0 };
instructionRAM[28] = { 6'd11, 5'd1, 16'd4, 5'd0 };
instructionRAM[29] = { 6'd14, 5'd1, 16'd1, 5'd0 };
instructionRAM[30] = { 6'd11, 5'd1, 16'd5, 5'd0 };
instructionRAM[31] = { 6'd14, 5'd1, 16'd2, 5'd0 };
instructionRAM[32] = { 6'd12, 5'd1, 16'd35, 5'd0 };
instructionRAM[33] = { 6'd14, 5'd1, 16'd0, 5'd0 };
instructionRAM[34] = { 6'd21, 16'd1, 10'd0 };
instructionRAM[35] = { 6'd26, 5'd30, 21'd0 };
instructionRAM[36] = { 6'd24, 26'd0 };

			firstclock <= 0;
		end
	end
	
	//read instruction
	assign instruction = instructionRAM[address];
endmodule 
	*/
	

