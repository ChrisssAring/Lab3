module signExtend(imm, signExtend);
	input[15:0] imm;
	output[31:0] signExtend;

	wire [15:0] imm;
	wire [31:0] signExtend;

	assign signExtend[15:0] = imm[15:0];
	assign signExtend[31:16] = {16 {imm[15]}};

endmodule
