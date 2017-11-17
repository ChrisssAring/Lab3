module signExtend(imm, signExt);
	input[15:0] imm;
	output[31:0] signExt;

	wire [15:0] imm;
	wire [31:0] signExt;

	assign signExt[15:0] = imm[15:0];
	assign signExt:[31:16] = {16 {imm[15]}};

endmodule
