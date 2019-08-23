module registerFile(
	input wsign				, 
	input clock				,
	input [31:0] wdata	, 
	input [4:0]	 waddr	, 
	input [4:0]	 raddr1  , 
	input [4:0]  raddr2  , 
	output [31:0] rdata1	, 
	output [31:0] rdata2	,
	output [31:0] rdata3
);

	reg[31:0] registers[31:0]; //32 registradores
	integer firstclock = 1;
	always@(posedge clock) begin
		if (firstclock) begin
			registers[0] = 0;
			firstclock = 0;
		end
		if(wsign) begin
			registers[waddr] = wdata;
		end
		
	end

	assign rdata1 = registers[raddr1];
	assign rdata2 = registers[raddr2];
	assign rdata3 = registers[waddr];

endmodule 