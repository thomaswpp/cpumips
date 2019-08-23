
module bios(
	input clock,
	input[31:0] address, 
	output[31:0] instruction,
	output reg flagBios
);

	//RAM Instruction varieble, 23 address
	reg[31:0] instructionRAM[200:0];
		
	initial begin
		flagBios = 0;
		
		//GDC
		/*
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
		*/
		
/*
instructionRAM[0] = {6'd21, 16'd1, 10'd0};
instructionRAM[1] = {6'd12, 5'd11, 16'd0, 5'd0};
instructionRAM[2] = {6'd14, 5'd11, 16'd3, 5'd0};
instructionRAM[3] = {6'd11, 5'd11, 16'd3, 5'd0};
instructionRAM[4] = {6'd12, 5'd12, 16'd38, 5'd0};
instructionRAM[5] = {6'd7, 5'd1, 5'd11, 5'd12, 11'd0};
instructionRAM[6] = {6'd17, 5'd1, 5'd0, 16'd16};
instructionRAM[7] = {6'd12, 5'd11, 16'd0, 5'd0};
instructionRAM[8] = {6'd12, 5'd12, 16'd0, 5'd0};
instructionRAM[9] = {6'd11, 5'd13, 16'd3, 5'd0};
instructionRAM[10] = {6'd32, 5'd11, 5'd12, 5'd13, 11'd0};
instructionRAM[11] = {6'd11, 5'd14, 16'd3, 5'd0};
instructionRAM[12] = {6'd12, 5'd15, 16'd1, 5'd0};
instructionRAM[13] = {6'd0, 5'd2, 5'd14, 5'd15, 11'd0};
instructionRAM[14] = {6'd14, 5'd2, 16'd3, 5'd0};
instructionRAM[15] = {6'd21, 16'd3, 10'd0};
instructionRAM[16] = {6'd24, 26'd0};
*/


//verificar se precisa copiar 32 ou 33 registradores!
instructionRAM[0] = {6'd21, 16'd1, 10'd0};
instructionRAM[1] = {6'd12, 5'd11, 16'd0, 5'd0};
instructionRAM[2] = {6'd14, 5'd11, 16'd3, 5'd0};
instructionRAM[3] = {6'd11, 5'd11, 16'd3, 5'd0};
instructionRAM[4] = {6'd12, 5'd12, 16'd38, 5'd0};
instructionRAM[5] = {6'd7, 5'd1, 5'd11, 5'd12, 11'd0};
instructionRAM[6] = {6'd17, 5'd1, 5'd0, 16'd16};
instructionRAM[7] = {6'd12, 5'd11, 16'd0, 5'd0};
instructionRAM[8] = {6'd12, 5'd12, 16'd0, 5'd0};
instructionRAM[9] = {6'd11, 5'd13, 16'd3, 5'd0};
instructionRAM[10] = {6'd32, 5'd11, 5'd12, 5'd13, 11'd0};
instructionRAM[11] = {6'd11, 5'd14, 16'd3, 5'd0};
instructionRAM[12] = {6'd12, 5'd15, 16'd1, 5'd0};
instructionRAM[13] = {6'd0, 5'd2, 5'd14, 5'd15, 11'd0};
instructionRAM[14] = {6'd14, 5'd2, 16'd3, 5'd0};
instructionRAM[15] = {6'd21, 16'd3, 10'd0};
instructionRAM[16] = {6'd12, 5'd14, 16'd0, 5'd0};
instructionRAM[17] = {6'd14, 5'd14, 16'd3, 5'd0};
instructionRAM[18] = {6'd11, 5'd14, 16'd3, 5'd0};
instructionRAM[19] = {6'd12, 5'd15, 16'd32, 5'd0};
instructionRAM[20] = {6'd7, 5'd2, 5'd14, 5'd15, 11'd0};
instructionRAM[21] = {6'd17, 5'd2, 5'd0, 16'd27};
instructionRAM[22] = {6'd11, 5'd14, 16'd3, 5'd0};
instructionRAM[23] = {6'd12, 5'd15, 16'd0, 5'd0};
instructionRAM[24] = {6'd12, 5'd16, 16'd0, 5'd0};
instructionRAM[25] = {6'd30, 5'd14, 5'd15, 16'd0};
instructionRAM[26] = {6'd21, 16'd18, 10'd0};
instructionRAM[27] = {6'd24, 26'd0};


		
	end
	
	always@(posedge clock) 
	begin
		if(address == 16)
			flagBios = 1;
	end
	
	//read instruction
	assign instruction = instructionRAM[address];
endmodule 