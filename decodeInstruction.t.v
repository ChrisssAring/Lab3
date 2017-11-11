`include "decodeInstruction.v"
module testDecodeInstruction();

	reg[31:0] instruction;
	wire [5:0] Opp, Func;
	wire [4:0] Rs, Rt, Rd, Shamt;
	wire [15:0] Imm;
	wire [25:0] Jaddress;

	decodeInstruction decode0 (instruction, Opp, Rs, Rt, Rd, Shamt, Func, Imm, Jaddress);

	initial begin
		instruction = 32'b00000011101010101010100101100011; #1000;
		$display("Instruction: %b", instruction);
		$display("Opp   |Rs   |Rt   |Rd   |Shamt|Funct |Imm             |Jadd");
		$display("%b|%b|%b|%b|%b|%b|%b|%b", Opp, Rs, Rt, Rd, Shamt, Func, Imm, Jaddress);
	end

endmodule
