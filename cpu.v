module cpu();

wire clk;


// Program Counter


// Instruction Memory 


//Instruction Decoder


// Register


// ALU
wire aluCout;
wire aluFlag;
wire [2:0] aluCommand;
wire [31:0] aluA;
wire [31:0] aluB;

ALU ALUcontrolLUT(.cout(aluCout), .flag(aluFlag), .finalsignal(aluResult), .ALUCommand(aluCommand), .a(aluA), .b(aluB));


// Data Memory
wire [31:0] dataMemoryOut;
wire [31:0] dataMemoryIn;
wire [31:0] dataMemoryAddress;

dataMemory dataMemory(.clk(clk), .dataOut(dataMemoryOut), .writeEnable(), .dataIn(dataMemoryIn), .address(dataMemoryAddress));


endmodule