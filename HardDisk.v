
module HardDisk
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=13) // 8 = 256; 9 = 512; 10 = 1024;
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addrRHD, addrWHD,
	input we, read_clock, write_clock,
	output reg [(DATA_WIDTH-1):0] q
);	
	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] HD[2**ADDR_WIDTH-1:0];
	
	
	initial begin	
	//FIBONACCI
HD[0] = { 6'd21, 16'd29, 10'd0 };
HD[1] = { 6'd12, 5'd1, 16'd0, 5'd0 };
HD[2] = { 6'd14, 5'd1, 16'd2, 5'd0 };
HD[3] = { 6'd12, 5'd1, 16'd0, 5'd0 };
HD[4] = { 6'd14, 5'd1, 16'd3, 5'd0 };
HD[5] = { 6'd12, 5'd1, 16'd1, 5'd0 };
HD[6] = { 6'd14, 5'd1, 16'd4, 5'd0 };
HD[7] = { 6'd12, 5'd1, 16'd0, 5'd0 };
HD[8] = { 6'd14, 5'd1, 16'd5, 5'd0 };
HD[9] = { 6'd11, 5'd1, 16'd2, 5'd0 };
HD[10] = { 6'd11, 5'd2, 16'd1, 5'd0 };
HD[11] = { 6'd7, 5'd10, 5'd1, 5'd2, 11'd0 };
HD[12] = { 6'd17, 5'd10, 5'd0, 16'd26};
HD[13] = { 6'd11, 5'd1, 16'd3, 5'd0 };
HD[14] = { 6'd11, 5'd2, 16'd4, 5'd0 };
HD[15] = { 6'd0, 5'd11, 5'd1, 5'd2, 11'd0 };
HD[16] = { 6'd14, 5'd11, 16'd5, 5'd0 };
HD[17] = { 6'd11, 5'd1, 16'd4, 5'd0 };
HD[18] = { 6'd14, 5'd1, 16'd3, 5'd0 };//
HD[19] = { 6'd11, 5'd1, 16'd5, 5'd0 };
HD[20] = { 6'd14, 5'd1, 16'd4, 5'd0 };
HD[21] = { 6'd11, 5'd1, 16'd2, 5'd0 };
HD[22] = { 6'd12, 5'd2, 16'd1, 5'd0 };
HD[23] = { 6'd0, 5'd12, 5'd1, 5'd2, 11'd0 };
HD[24] = { 6'd14, 5'd12, 16'd2, 5'd0 };
HD[25] = { 6'd21, 16'd9, 10'd0 };
HD[26] = { 6'd11, 5'd30, 16'd3, 5'd0 };
HD[27] = { 6'd11, 5'd31, 16'd0, 5'd0 };
HD[28] = { 6'd22, 5'd31, 21'd0 };
HD[29] = { 6'd25, 5'd13, 21'd0 };
HD[30] = { 6'd14, 5'd13, 16'd7, 5'd0 };
HD[31] = { 6'd11, 5'd1, 16'd7, 5'd0 };
HD[32] = { 6'd14, 5'd1, 16'd1, 5'd0 };
HD[33] = { 6'd12, 5'd1, 16'd36, 5'd0 };
HD[34] = { 6'd14, 5'd1, 16'd0, 5'd0 };
HD[35] = { 6'd21, 16'd1, 10'd0 };
HD[36] = { 6'd26, 5'd30, 21'd0 };
HD[37] = { 6'd24, 26'd0 };
	end
	
	always @ (posedge write_clock)
	begin
		// Write
		if (we)
		begin
			//addrWHD <= wsetor + (wtrilha * 1000);
			HD[addrWHD] <= data;			
		end
	end
	
	always @ (posedge read_clock)
	begin
		// Read 		
		//addrRHD <= rsetor + (rtrilha * 1000);
		q <= HD[addrRHD];
	end
	
endmodule

	

/*
// Quartus Prime Verilog Template
// Simple Dual Port RAM with separate read/write addresses and
// separate read/write clocks

module simple_dual_port_ram_dual_clock
#(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=6)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] read_addr, write_addr,
	input we, read_clock, write_clock,
	output reg [(DATA_WIDTH-1):0] q
);
	
	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	
	always @ (posedge write_clock)
	begin
		// Write
		if (we)
			ram[write_addr] <= data;
	end
	
	always @ (posedge read_clock)
	begin
		// Read 
		q <= ram[read_addr];
	end
	
endmodule

*/

/*

module DataMemory(
	dataIn	    , 
	address	    , 
	wsign		, 
	clock		, 
	dataOut
);

	input[31:0] dataIn;
	input wsign;
	input clock;
	input[31:0] address;
	
	output[31:0] dataOut;

	//Variable RAM
	reg [31:0] RAM[127:0]; //128 address
	
	//escrita da memoria
	always@(posedge clock) begin
	
		if(wsign) begin
			RAM[address] = dataIn;
		end 
		
	end
	
	//Leitura da memoria
	assign dataOut = RAM[address];
	
endmodule 
*/
