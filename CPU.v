module CPU(
	input clk50,
	input reset,
	input inSign,
	input button,
	input [15:0] keyIn, 
	output [6:0] signDsp,
	output [6:0] DspHundreds,
	output [6:0] DspTens,
	output [6:0] DspOnes,
	output [6:0] Dsp6,
	output [6:0] Dsp5,
	output [6:0] Dsp4,	
	output clk,
	output LCD_ON,	// LCD Power ON/OFF
	output LCD_BLON,	// LCD Back Light ON/OFF
	output LCD_RW,	// LCD Read/Write Select, 0 = Write, 1 = Read
	output LCD_EN,	// LCD Enable
	output LCD_RS,	// LCD Command/Data Select, 0 = Command, 1 = Data
	inout [7:0] LCD_DATA	// LCD Data bus 8 bits
);
    
    //ControlUnit
    wire [5:0] opcode;
    wire branch;
    wire writeREG;
    wire ALUSrc;
    wire MemWrite;
    wire ExtendSign;
    wire OutputSign;
    wire [2:0] RegDst;
    wire [1:0] PCSign;
    wire exibirFlag;
	 

    //Bitextend
    reg [15:0] in_16;
    wire [31:0] out_32;

    //PC
    wire [31:0] PC;
    reg [31:0] PCAddress;

    //RAM Instrc
    wire [31:0] instructionInst;
	 wire [31:0] instructionBios;
	 wire [31:0] instruction;	 
	 wire flagBios;
	 wire flagMuxBios;
	 wire flagWriteInst;

    //RAM Data
    wire [31:0] dataRamIn;
    reg [31:0] address;
    wire [31:0] dataRamOut;
    wire [31:0] dataHdOut;

    //REG
    reg [4:0] waddr;
    reg [4:0] raddr1;
    reg [4:0] raddr2;
    wire [31:0] wdata;
    wire [31:0] rdata1;
    wire [31:0] rdata2;
    wire [31:0] rdata3;
	 
	 
	 //HD-MemInst-Reg
	 reg [32:0] rsetor;
	 reg [32:0] rtrilha;
	 reg [32:0] wsetor;
	 reg [32:0] wtrilha;
	wire [31:0] addrRReg;
	wire [31:0] addrWReg;
	wire [31:0] addrRHD;
	wire [31:0] addrWHD;
	
	 //HD
	 wire FlagWriteHD;
	 

    //Alu
    reg [4:0] aluOp;
    reg [15:0] shamt;
    reg [31:0] operandoA;
    wire [31:0] operandoB;
    wire [31:0] aluOut;
    wire zero;
    
    //Output
    wire signOut;
    reg [31:0] outLine;
    
    //Input
    wire [31:0] dataIn; 
    
Temporizador(
	 .opcode(opcode)              ,
    .clock50M(clk50),
	 .enterFlag(inSign), 
    .clock(clk)
);


//DeBounce(
//    .clk(clk50)             ,
//    .n_reset(1)             ,
//    .button_in(button)  , 
//    .DB_out(clk)            
//);
    
ControlUnit(
   .opcode(opcode)              ,
    .inSign(inSign)             ,
    .clock(clk)                 ,
    .branch(branch)             ,
    .reset(reset)               ,
    .RegDst(RegDst)             ,
    .ALUSrc(ALUSrc)             ,
    .writeREG(writeREG)         ,
    .MemWrite(MemWrite)         ,
    .ExtendSign(ExtendSign)     ,
    .OutputSign(signOut)        ,
    .PCSign(PCSign)				  ,
	.flagWriteInst(flagWriteInst),
	.FlagWriteHD(FlagWriteHD),
	.singOut(exibirFlag)

);

PC( 
    .clock(clk)             ,
    .sign(PCSign)           ,
    .address(PCAddress)     ,
    .pc(PC),	 
	.flagBios(flagBios),
	.flagMuxBios(flagMuxBios)
);

InstructionMemory(
	 .data(dataHdOut),
    .read_setor(PC)              , 
	 .write_setor(rsetor)		, 
	 .read_trilha(0),
	 .write_trilha(0),
    .write_clock(clk50)               , 
	 .read_clock(clk50)					,
	 .flagWrite(flagWriteInst),
    .instruction(instructionInst)
);

//Trilha deve receber o programa atual
//Ou o programa a ser copiado
ConvertAddr(
	.rsetor(rsetor)		,
	.rtrilha(0)		,
	.wsetor(wsetor)		,
	.wtrilha(0)		,
	.addrRReg(addrRReg)	, //raddr1
	.addrWReg(addrWReg)	, //waddr
	.addrRHD(addrRHD)		,
	.addrWHD(addrWHD)		,
);

HardDisk(
    .data(rdata1)     	   , 
	 .addrRHD(addrRHD)  		,
	 .addrWHD(addrWHD) 		,
    .we(FlagWriteHD)       , 
    .read_clock(clk50)     , 
    .write_clock(clk50)    , 
    .q(dataHdOut)
);

bios(
	 .clock(clk)						 ,
    .address(PC)                  , 
    .instruction(instructionBios) ,
	 .flagBios(flagBios)
);

MuxBios(
    .sign(flagMuxBios), 
    .instBios(instructionBios),
	 .inst(instructionInst),
	 .dataOut(instruction)
);


registerFile(
    .wsign(writeREG), 
    .clock(clk)     ,
    .wdata(wdata)   , 
    .waddr(waddr)   ,  //addrWReg
    .raddr1(raddr1) , //addrRReg ??
    .raddr2(raddr2) , 
    .rdata1(rdata1) , 
    .rdata2(rdata2) ,
    .rdata3(rdata3)
);

DataMemory(
    .data(rdata1)     , 
    .read_addr(address)   , 
	 .write_addr(address),
    .we(MemWrite)    , 
    .read_clock(clk50)   , 
    .write_clock(clk50)   , 
    .q(dataRamOut)
);

Mux(
    .sign(RegDst)         ,
    .dataRam(dataRamOut)  , 
    .dataAlu(aluOut)      ,
    .dataIn(dataIn)       ,
    .dataExt(out_32)      ,
	 .dataHd(dataHdOut)	  ,
    .dataOut(wdata)
);



Alusrc(
    .sign(ALUSrc)       ,
    .dataReg(rdata2)    ,
    .dataExt(out_32)    ,
    .dataOut(operandoB)
);

bitextend A (
    .sign(ExtendSign)   , 
    .in_16(in_16)       , 
    .out_32(out_32)
);

bitextend B(
    .sign(ExtendSign)   , 
    .in_16(keyIn)       , 
    .out_32(dataIn)
);

alu(
    .aluOp(aluOp)           , 
    .operandoA(operandoA)   , 
    .operandoB(operandoB)   , 
    .aluOut(aluOut)         , 
    .zero(zero)             , 
    .shamt(shamt)
);

Input
(
    .clock(clk)			,
    .sign(inSign)			,
    .keyIn(keyIn)			,
    .dataOut(dataOutIn)
);

Output(
    .signOut(signOut)			,
    .outLine(outLine)			,
	 .exibirFlag(exibirFlag)	,
    .signDsp(signDsp)			,
    .DspHundreds(DspHundreds)	, 
    .DspTens(DspTens)			, 
    .DspOnes(DspOnes)			
);

OutputPC(
    .pc(PC)					,
    .Dsp6(Dsp6)			, 
    .Dsp5(Dsp5)			, 
    .Dsp4(Dsp4)					
);

lcdlab3(
  .CLOCK_50(clk50),	//	50 MHz clock
  .KEY(0),      //	Pushbutton[3:0]
  .SW(0),	//	Toggle Switch[17:0]
  .TensBin1(0), 
  .OnesBin1(0),
  .TensBin2(0), 
  .OnesBin2(0),
  .TensBin3(0), 
  .OnesBin3(0),
  //output [6:0]	HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,  // Seven Segment Digits
  //output [8:0] LEDG,  //	LED Green
  //output [17:0] LEDR,  //	LED Red
  //inout [35:0] GPIO_0,GPIO_1,	//	GPIO Connections
//	LCD Module 16X2
  .LCD_ON(LCD_ON),	// LCD Power ON/OFF
  .LCD_BLON(LCD_BLON),	// LCD Back Light ON/OFF
  .LCD_RW(LCD_RW),	// LCD Read/Write Select, 0 = Write, 1 = Read
  .LCD_EN(LCD_EN),	// LCD Enable
  .LCD_RS(LCD_RS),	// LCD Command/Data Select, 0 = Command, 1 = Data
  .LCD_DATA(LCD_DATA)	// LCD Data bus 8 bits

);


    assign opcode = instruction[31:26];
    assign branch = zero;

    always@(*) begin
         
        case (opcode)
            0: begin //add
                //Address Reg
                waddr  = instruction[25:21];
                raddr1 = instruction[20:16];
                raddr2 = instruction[15:11];
                //Alu
                operandoA = rdata1;
                aluOp = 1;
            end

            1: begin //addi
                //Address Reg
                waddr  = instruction[25:21];
                raddr1 = instruction[20:16];
                in_16  = instruction[15:0];
                //Alu
                operandoA = rdata1;
                aluOp = 1;
            end

            2: begin //sub
                //Address Reg
                waddr  = instruction[25:21];
                raddr1 = instruction[20:16];
                raddr2 = instruction[15:11];
                //Alu
                operandoA = rdata1;
                aluOp = 2;
            end

            3: begin //subi
                //Address Reg
                waddr  = instruction[25:21];
                raddr1 = instruction[20:16];
                in_16  = instruction[15:0];
                //Alu
                operandoA = rdata1;
                aluOp = 2;
            end
        
            4: begin //not
                //Address Reg
                waddr  = instruction[25:21];
                raddr1 = instruction[20:16];
                //Alu
                operandoA = rdata1;
                aluOp = 5;              
            end

            5: begin //seq MODIFICADO and
                //Address Reg
                waddr  = instruction[25:21];
                raddr1 = instruction[20:16];
                raddr2 = instruction[15:11];
                //Alu
                operandoA = rdata1;
                aluOp = 7;
            end

            6: begin //sne MODIFICADO andi
                //Address Reg
                waddr  = instruction[25:21];
                raddr1 = instruction[20:16];
                raddr2 = instruction[15:11];
                //Alu
                operandoA = rdata1;
                aluOp = 14;
            end

            7: begin //slt MODIFICADO or
                //Address Reg
                waddr  = instruction[25:21];
                raddr1 = instruction[20:16];
                raddr2 = instruction[15:11];
                //Alu
                operandoA = rdata1;
                aluOp = 8;
            end

            8: begin //sle MODIFICADO ori
                //Address Reg
                waddr  = instruction[25:21];
                raddr1 = instruction[20:16];
                raddr2 = instruction[15:11];
                //Alu
                operandoA = rdata1;
                aluOp = 15;
            end

            9: begin //sgt MODIFICADO slt
                //Address Reg
                waddr  = instruction[25:21];
                raddr1 = instruction[20:16];
                raddr2 = instruction[15:11];
                //Alu
                operandoA = rdata1;
                aluOp = 9;                   
            end

            10: begin //sge MODIFICADO slti
                //Address Reg
                waddr  = instruction[25:21];
                raddr1 = instruction[20:16];
                raddr2 = instruction[15:11];
                //Alu
                operandoA = rdata1;
                aluOp = 16;              
            end
                
            11: begin //lw
                //Address Reg/RAM
                waddr   = instruction[25:21];
                address = instruction[20:5];              
            end

            12: begin //li
                //Address Reg/RAM
                waddr = instruction[25:21];
                in_16 = instruction[20:5];
            end

            13: begin //lwr
                //Address Reg/RAM
                waddr  = instruction[25:21];
                raddr1 = instruction[20:16];
                address = rdata1;
            end
                
            14: begin //sw
                //Address Reg/RAM
                raddr1  = instruction[25:21];
                address = instruction[20:5];              
            end

            15: begin //swr
                //Address Reg/RAM
                raddr1  = instruction[25:21];
                raddr2  = instruction[20:16]; 
                address = rdata2;           
            end

            16: begin //move
                //Address Reg
                waddr  = instruction[25:21];
                raddr1 = instruction[20:16];
                //Alu
                aluOp = 0;
                operandoA = rdata1;                  
            end

            17: begin //beq
                //Address Reg
                raddr1 = instruction[25:21];
                raddr2 = instruction[20:16];
                PCAddress = instruction[15:0];
                aluOp = 2;
                operandoA = rdata1;
            end

            18: begin //bnq
                //Address Reg
                raddr1 = instruction[25:21];
                raddr2 = instruction[20:16];
                PCAddress = instruction[15:0];
                aluOp = 2;
                operandoA = rdata1;
            end

            19: begin //blt
                //Address Reg
                raddr1 = instruction[25:21];
                raddr2 = instruction[20:16];
                PCAddress = instruction[15:0];                   
                aluOp = 10;
                operandoA = rdata1;
            end

            20: begin //bgt
                //Address Reg
                raddr1 = instruction[25:21];
                raddr2 = instruction[20:16];
                PCAddress = instruction[15:0];
                aluOp = 11;
                operandoA = rdata1;
            end

            21: begin //jump
                //Address Reg
                PCAddress = instruction[25:10];
            end
        
            22: begin //jr
                //Address Reg
                raddr1 = instruction[25:21];
                //PC
                PCAddress = rdata1;
            end

            23: begin //nop
                //não utiliza reg
            end

            24: begin //hlt
                //não utiliza reg
            end

            25: begin //in
                waddr = instruction[25:21];
            end

            26: begin //out
                //address Reg
                raddr1  = instruction[25:21];
                outLine = rdata1;
            end								
						
					
            30: begin //RegToHD
                raddr1 = instruction[25:21]; //endereco no banco de Reg rdata1 = reg[raddr1] = [dado transferir para HD]
					 raddr2 = instruction[20:16]; // reg[raddr2] = endereco para escrever no HD				 
                wtrilha  = rdata1; //trilha
                wsetor = rdata2; //setor					 
            end				
					
            31: begin //HDtoReg			
                raddr1 = instruction[25:21]; //endereco no banco de Reg rdata1 = reg[raddr1] = [dado transferir para HD]
					 raddr2 = instruction[20:16]; // reg[raddr2] = endereco para escrever no HD				 
                rtrilha  = rdata1; //trilha
                rsetor = rdata2; //setor	
            end
            	
					
            32: begin //HDMI				
                //Address Reg
                //waddr  = instruction[25:21];
                raddr1 = instruction[20:16];
                raddr2 = instruction[15:11];					 
                rtrilha  = rdata1; //trilha
                rsetor = rdata2; //setor
            end
            
            default: waddr = 0;
                
        endcase
    end


endmodule 
