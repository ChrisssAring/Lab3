`include "instructionMemory.v"
module cpu();

wire clk;

//Program Counter Wires
wire programCounter4
wire programCounterIn
wire adder_4
wire adder_extend
reg [31:0] programCounter;

//Operand Wires
wire RegDst;
wire RegWr;
wire ALUcntrl;
wire MemWr;
wire MemToReg;
wire ALUsrc;
wire PCsrc;

//Instruction Memory
wire ReadAdd;
wire [31:0] Instructions;

//Register Wires
wire RegWrite
wire WriteReg
wire WriteData
wire [31:0] readData0
wire [31:0] readData1

//ALU Wires
wire [31:0] imm_ex
wire [31:0] aluResult;
wire [2:0]  aluCommand;
wire [31:0] aluA;
wire [31:0] aluB;

//Data Memory Wires
wire [31:0] dataMemoryOut;
wire [31:0] dataMemoryIn;
wire [31:0] dataMemoryAddress;

// Two-input MUX with parameterized bit width (default: 1-bit)
module mux2 #( parameter W = 1 )
(
    input[W-1:0]    in0,
    input[W-1:0]    in1,
    input           sel,
    output[W-1:0]   out
);
    // Conditional operator - http://www.verilog.renerta.com/source/vrg00010.htm
    assign out = (sel) ? in1 : in0;
endmodule

signExtend(.imm(Instructions[15:0]),.signExtend(imm_ex))

// Program Counter
initial programCounter = 0;
wire [31:0] programCounterPlus4;
assign programCounterPlus4 = programCounter + 4;

PC_Add4 ALUcontrolLUT(.finalsignal(adder_4), .ALUCommand(4'b0000), .a(programCounter4), .b(3'b100)); //Add 4

PC_Current ALUcontrolLUT(.finalsignal(programCounterIn), .ALUCommand(4'b0000), .a(imm_ext<<2), .b(adder_4));

PC_mux mux2(.in0(adder_ext),.in1(adder_4),.sel(PCSrc),.out(programCounterIn))

// Instruction Memory 
instructionMemory instructionMemory(clk, 1'b0, {2'b0, programCounter [31:2]}, 32'b0, Instructions);


register_mux mux2(.in0(Instructions[15:11]),.in1(Instructions[20:16]),.sel(RegDst),.out(WriteReg))

// Register
Registry register(.WrEn(RegWr),.Rs(Instructions[25:21]),.Rt(Instructions[20:16]),.Aw(WriteReg),.Dw(WriteData),.Da(readData0),.Db(readData1));


ALU ALUcontrolLUT(.cout(aluCout), .flag(aluFlag), .finalsignal(aluResult), .ALUCommand(aluCommand), .a(aluA), .b(aluB));
>>>>>>> d7a269fa5ff48ccb853168e72b37346a3fc294d4

alu_mux mux2(.in0(imm_ex),.in1(readData1),.sel(RegDst),.out(WriteReg))

// ALU
ALU ALUcontrolLUT(.finalsignal(aluResult), .ALUCommand(ALUcntrl), .a(aluA), .b(aluB));

// Data Memory
dataMemory dataMemory(.clk(clk), .dataIn(aluResult), .address(aluResult), .dataOut(dataMemoryOut), .writeEnable(MemWr));

data_mem_mux mux2(.in0(dataMemoryOut),.in1(aluResult),.sel(MemToReg),.out(WriteData))
=======
// Program Counter Cont.
// need to assign once we have more info.


endmodule
