`include "instructionMemory.v"
`include "decodeInstruction.v"
`include "ALU/alu.v"
`include "Registers/regfile.v"
`include "operand_LUT.v"
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
//
module signExtend(imm);
	input[15:0] imm;
	output[31:0] signExt;

	wire [15:0] imm;
	wire [31:0] signExt;

	assign signExt [15:0] = imm[15:0];
	assign signExt [31:16] = {16 {imm[15]}};

endmodule

module cpu();

wire clk;

//Instruction Decoder
wire [5:0] opCode;
wire [4:0] rs, rt, rd, shamt;
wire [5:0] func;
wire [15:0] imm;
wire [25:0] jadress;
wire [31:0] jumpAddress;
//wire [31:0] branchAddress;

//Program Counter Wires
wire programCounter4;
wire programCounterIn;
wire adder_4;
wire adder_extend;
reg [31:0] programCounter;

reg [31:0] pc = 0;
wire [31:0] pcPlus4;
wire [31:0] pcNext;

//Instruction Memory
wire [31:0] Instructions;

//Operand Wires
wire RegDst;
wire RegWr;
wire ALUcntrl;
wire MemWr;
wire MemToReg;
wire ALUsrc;
wire PCsrc;
wire Branch;

//Register Wires
wire RegWrite;
wire WriteReg;
wire WriteData;
wire [31:0] readData0;
wire [31:0] readData1;

//ALU Wires
wire zero;
wire [31:0] imm_ex;
wire [31:0] aluResult;
wire [31:0] alu_mux_out;

//Data Memory Wires
wire [31:0] dataMemoryOut;
wire [31:0] dataMemoryIn;
wire [31:0] dataMemoryAddress;




// Program Counter
assign pcPlus4 = programCounterIn;

PC_Add4 ALUcontrolLUT(.finalsignal(adder_4), .ALUCommand(4'b0000), .a(pcNext), .b(3'b100)); //Add 4

PC_Current ALUcontrolLUT(.finalsignal(adder_ext), .ALUCommand(4'b0000), .a(imm_ext<<2), .b(adder_4));

PC_mux mux2(.in0(adder_ext),.in1(adder_4),.sel(PCSrc),.out(programCounterIn));

//Instruction Memory
instructionMemory instructionMem(.address(pcNext),.dataOut(Instructions));

//Controls
decodeInstruction decode(.Opp(opCode), .Func(func), .Rs(rs), .Rt(rt), .Rd(rd), .Shamt(shamt), .Imm(imm), .Jaddress(jumpAddress), .instruction(Instructions));
operand_controls operand_lut(.opCode(opCode),.RegDst(RegDst),.RegWr(RegWr),.ALUcntrl(ALUcntrl),.MemWr(MemWr),.MemToReg(MemToReg),.ALUsrc(ALUsrc),.Branch(Branch),.rs(rs),.rt(rt));

assign PCsrc = Branch&&zero;

// Register
Registry regfile(.RegWrite(RegWr),.ReadRegister1(rs),.ReadRegister2(rt),.WriteData(WriteReg),.WriteRegister(WriteData),.ReadData1(readData0),.ReadData2(readData1));

register_mux mux2(.in0(rd),.in1(rt),.sel(RegDst),.out(WriteReg));

alu_mux mux2(.in0(imm_ex),.in1(readData1),.sel(ALUsrc),.out(alu_mux_out));

signExtend signExtendo(.imm(imm),.signExt(imm_ex));


// ALU
ALU ALUcontrolLUT(.finalsignal(aluResult), .ALUCommand(ALUcntrl), .a(readData0), .b(alu_mux_out), .zero(zero));

// Data Memory
dataMemory dataMemory(.clk(clk), .dataIn(aluResult), .address(aluResult), .dataOut(dataMemoryOut), .writeEnable(MemWr));

data_mem_mux mux2(.in0(dataMemoryOut),.in1(aluResult),.sel(MemToReg),.out(WriteData));
// Program Counter Cont.
always @(posedge clk) begin
	pc <= pcNext;
end
// need to assign once we have more info.
//
//
//

endmodule
