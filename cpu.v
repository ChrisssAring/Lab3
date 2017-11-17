`include "instructionMemory.v"
module cpu();

wire clk;

// Program Counter
reg [31:0] programCounter;
initial programCounter = 0;
wire [31:0] programCounterPlus4;
assign programCounterPlus4 = programCounter + 4;

// Instruction Memory 


//Instruction Decoder


// Register


// ALU
wire aluCout;
wire aluFlag;
wire [2:0] aluCommand;
wire [31:0] aluA;
wire [31:0] aluB;

//Instruction Memory
wire [31:0] instructionData;
instructionMemory instructionMemory(clk, 1'b0, {2'b0, programCounter [31:2]}, 32'b0, instructionData);

ALU ALUcontrolLUT(.cout(aluCout), .flag(aluFlag), .finalsignal(aluResult), .ALUCommand(aluCommand), .a(aluA), .b(aluB));


// Data Memory
wire [31:0] dataMemoryOut;
wire [31:0] dataMemoryIn;
wire [31:0] dataMemoryAddress;

dataMemory dataMemory(.clk(clk), .dataOut(dataMemoryOut), .writeEnable(), .dataIn(dataMemoryIn), .address(dataMemoryAddress));

// Program Counter Cont.
// need to assign once we have more info.

endmodule
