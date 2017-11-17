`include "instructionMemory.v"


module cpu();

wire clk;

//Program Counter
wire [1:0] pcSelect;
reg [31:0] pc = 0;
wire [31:0] pcPlus4;
assign pcPlus4 = pc + 4;
wire [31:0] pcNext;
wire [31:0] instruction;

//Instruction Memory
instructionMemory instructionMem(instruction);

//Instruction Decoder
wire [5:0] opCode;
wire [4:0] rs, rt, rd, shamt;
wire [5:0] func;
wire [15:0] imm;
wire [25:0] jadress;
wire [31:0] jumpAddress;
wire [31:0] branchAddress;


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

// Program Counter Cont.
always @(posedge clk) begin
	pc <= pcNext;
end
endmodule
