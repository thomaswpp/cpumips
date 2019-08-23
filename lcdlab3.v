module lcdlab3(
  input CLOCK_50,	//	50 MHz clock
  input [3:0] KEY,      //	Pushbutton[3:0]
  input [17:0] SW,	//	Toggle Switch[17:0]
  input [3:0] TensBin1, 
  input [3:0] OnesBin1,
  input [3:0] TensBin2, 
  input [3:0] OnesBin2,
  input [3:0] TensBin3, 
  input [3:0] OnesBin3,
		//output [6:0]	HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,  // Seven Segment Digits
  //output [8:0] LEDG,  //	LED Green
  //output [17:0] LEDR,  //	LED Red
  //inout [35:0] GPIO_0,GPIO_1,	//	GPIO Connections
//	LCD Module 16X2
  output LCD_ON,	// LCD Power ON/OFF
  output LCD_BLON,	// LCD Back Light ON/OFF
  output LCD_RW,	// LCD Read/Write Select, 0 = Write, 1 = Read
  output LCD_EN,	// LCD Enable
  output LCD_RS,	// LCD Command/Data Select, 0 = Command, 1 = Data
  inout [7:0] LCD_DATA	// LCD Data bus 8 bits
);

wire  [8:0] LEDG;
wire [17:0] LEDR;
wire [35:0] GPIO_0,GPIO_1;

//	All inout port turn to tri-state
assign	GPIO_0		=	36'hzzzzzzzzz;
assign	GPIO_1		=	36'hzzzzzzzzz;


wire [6:0] myclock;
wire RST;
assign RST = KEY[0];

// reset delay gives some time for peripherals to initialize
wire DLY_RST;
Reset_Delay r0(	.iCLK(CLOCK_50),.oRESET(DLY_RST) );

// Send switches to red leds 
assign LEDR = SW;

// turn LCD ON
assign	LCD_ON		=	1'b1;
assign	LCD_BLON	=	1'b1;

wire [3:0] hex5, hex4, hex3, hex2, hex1, hex0;
assign hex5 = TensBin3;
assign hex4 = OnesBin3;
assign hex3 = TensBin2;
assign hex2 = OnesBin2;
assign hex1 = TensBin1;
assign hex0 = OnesBin1;


LCD_Display u1(
// Host Side
   .iCLK_50MHZ(CLOCK_50),
   .iRST_N(DLY_RST),
   .hex0(hex0),
   .hex1(hex1),
	.hex2(hex2),
	.hex3(hex3),
	.hex4(hex4),
	.hex5(hex5),
// LCD Side
   .DATA_BUS(LCD_DATA),
   .LCD_RW(LCD_RW),
   .LCD_E(LCD_EN),
   .LCD_RS(LCD_RS)
);


// blank unused 7-segment digits

endmodule