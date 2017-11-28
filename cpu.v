`include "instructionMemory.v"
`include "decodeInstruction.v"
`include "alu.v"
`include "Registers/regfile.v"
`include "operand_lut.v"
`include "dataMemory.v"
//------------------------------------------------------------------
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
//------------------------------------------------------------------
// Five-input MUX with parameterized bit width
module mux5 #( parameter W = 5 )
(
    input[W-1:0]    in0,
    input[W-1:0]    in1,
    input           sel,
    output[W-1:0]   out
);
    // Conditional operator - http://www.verilog.renerta.com/source/vrg00010.htm
    assign out = (sel) ? in1 : in0;
endmodule
//------------------------------------------------------------------
// 32-input MUX with parameterized bit width 
module mux32 #( parameter W = 32 )
(
    input[W-1:0]    in0,
    input[W-1:0]    in1,
    input           sel,
    output[W-1:0]   out
);
    // Conditional operator - http://www.verilog.renerta.com/source/vrg00010.htm
    assign out = (sel) ? in1 : in0;
endmodule
//------------------------------------------------------------------

//
module signExtendo(imm);
	input[15:0] imm;
	output[31:0] signExt;

	wire [15:0] imm;
	wire [31:0] signExt;

	assign signExt [15:0] = imm[15:0];
	assign signExt [31:16] = {16 {imm[15]}};

endmodule

module cpu(
input clk
);

wire clk;

//Instruction Decoder
wire [5:0] opCode;
wire [4:0] rs, rt, rd, shamt;
wire [5:0] func;
wire [15:0] imm;
wire [25:0] jumpAddress;
//wire [31:0] branchAddress;

//Program Counter Wires
wire [31:0] programCounter4;
wire [31:0] programCounterIn;
wire [31:0] adder_4;
wire [31:0] adder_extend;
reg [31:0] programCounter;

reg [31:0] pc = 0;
wire [31:0] pcPlus4;
wire [31:0] pcNext;

//Instruction Memory
wire [31:0] Instructions;

//Operand Wires
wire RegDst;
wire RegWr;
wire [2:0] ALUcntrl;
wire MemWr;
wire MemToReg;
wire ALUsrc;
wire PCsrc;
wire Branch;

//Register Wires
wire RegWrite;
wire [31:0] WriteReg;
wire [4:0]  WriteDataReg;
wire [31:0] readData0;
wire [31:0] readData1;

//ALU Wires
wire zero;
wire [31:0] imm_ext;
wire [31:0] aluResult;
wire [31:0] alu_mux_out;

//Data Memory Wires
wire [31:0] dataMemoryOut;
wire [31:0] dataMemoryIn;
wire [31:0] dataMemoryAddress;
wire [31:0] WriteData;


// Program Counter
//assign pcPlus4 = programCounterIn;
assign pcPlus4 = pc + 4;


ALU PC_Add4(.result(adder_4), .command(3'b000), .operandA(pcNext), .operandB(32'b00000000000000000000000000000100)); //Add 4

ALU PC_Current(.result(adder_extend), .command(3'b000), .operandA(imm_ext<<2), .operandB(adder_4));

mux32 PC_mux(.in0(adder_extend),.in1(adder_4),.sel(PCSrc),.out(programCounterIn));

//Instruction Memory
instructionMemory instructionMem(.address(pcNext),.dataOut(Instructions));

//Controls
decodeInstruction decode(.Opp(opCode), .Func(func), .Rs(rs), .Rt(rt), .Rd(rd), .Shamt(shamt), .Imm(imm), .Jaddress(jumpAddress), .instruction(Instructions));

operand_lut operand_controls(.opCode(opCode),.RegDst(RegDst),.RegWr(RegWr),.ALUcntrl(ALUcntrl),.MemWr(MemWr),.MemToReg(MemToReg),.ALUsrc(ALUsrc),.Branch(Branch),.rs(rs),.rt(rt));

assign PCsrc = Branch&&zero;

// Register
regfile Registry(.RegWrite(RegWr),.ReadRegister1(rs),.ReadRegister2(rt),.WriteData(WriteReg),.WriteRegister(WriteDataReg),.ReadData1(readData0),.ReadData2(readData1));

mux5 register_mux(.in0(rd),.in1(rt),.sel(RegDst),.out(WriteDataReg));

mux32 alu_mux(.in0(imm_ext),.in1(readData1),.sel(ALUsrc),.out(alu_mux_out));

signExtend signExtendo(.imm(imm), .signExt(imm_ext));


// ALU
ALU ALU_instance(.result(aluResult), .command(ALUcntrl), .operandA(readData0), .operandB(alu_mux_out), .zero(zero));

// Data Memory
dataMemory dataMemory1(.clk(clk), .dataIn(aluResult), .address(aluResult), .dataOut(dataMemoryOut), .writeEnable(MemWr));

mux32 data_mem_mux(.in0(dataMemoryOut),.in1(aluResult),.sel(MemToReg),.out(WriteData));
// Program Counter Cont.
always @(posedge clk) begin
	if (pcNext) begin
		pc <= pcNext;
end

endmodule
