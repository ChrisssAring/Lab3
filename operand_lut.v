//-----------------------------------------------------------
// Operand Decoding LUT
//
// 
// LW      | Load Word into a register from the specified address
// SW      | Store contents of $t at a specified address
// J       | Jump to calculated address
// JR      | Jump to calculated address and stores the return address in $31
// JAL     | Jump to the calculated address and stores the return address in $31
// BNE     | Branch Not Equal
// XORI    | Bitwise exclusive ors a register and an immediate value and stores the result in a register
// ADDI    | Add a register and a sign-extended immediate value and stores result in a register
// ADD     | Add two registers and stores the result in a register
// SUB     | Subtract two registers and stores the result in a register
// SLT     | Compare two $s and $t, $d is set to one if $s<$t, otherwise zero
//
//-----------------------------------------------------------

module operand_lut
(
    input [5:0] opCode,
    input [4:0] rs,rt,
    output reg RegDst,RegWr,ALUcntrl,MemWr,MemToReg,ALUsrc,Branch
);

	// op_code
	localparam LW = 6'h23;
	localparam SW = 6'h2b;
	localparam J = 6'h2;
	localparam JAL = 6'h3;
	localparam BNE = 6'h5;
	localparam XORI = 6'he;
	localparam ADDI = 6'h8;

	localparam ADD = 6'h20;
	localparam SUB = 6'h22;
	localparam SLT = 6'h2a;
	localparam JR = 6'h08;

always @(opCode) begin
	case (opCode)
		default:begin
			RegDst   = 1'bX;
			RegWr    = 1'bX;
			ALUcntrl = 1'bX;
			MemWr    = 1'bX;
			MemToReg = 1'bX;
			ALUsrc   = 1'bX;
			Branch 	 = 1'bX;
		end
		LW: begin
			RegDst   = 0;
			RegWr    = 1;
			ALUcntrl = 3'b000;
			MemWr    = 0; 
			MemToReg = 1;
			ALUsrc   = 1;
			Branch 	 = 0;

		end
		SW: begin
			RegDst   = 1'bX;
			RegWr    = 0;
			ALUcntrl = 3'b000;
			MemWr    = 1;
			MemToReg = 0;
			ALUsrc   = 1;
			Branch 	 = 0;

		end
		J: begin
			RegDst   = 0;
			RegWr    = 0;
			ALUcntrl = 3'b000;
			MemWr    = 0;
			MemToReg = 0;
			ALUsrc   = 0;
			Branch 	 = 1;
		end

		JR: begin
			RegDst   = 0;
			RegWr    = 0;
			ALUcntrl = 3'b000;
			MemWr    = 1'bX;
			MemToReg = 1;
			ALUsrc   = 0;
			Branch 	 = 1;
		end 

		JAL: begin
			RegDst   = 0;
			RegWr    = 0;
			ALUcntrl = 3'b000;
			MemWr    = 1'bX;
			MemToReg = 0;
			ALUsrc   = 0;
			Branch 	 = 1;

		end
		BNE: begin
			RegDst   = 1'bX;
			RegWr    = 0;
			ALUcntrl = 3'b001;
			MemWr    = 0;
			MemToReg = 1'bX;
			ALUsrc   = 0;
			if (rs != rt) begin
				Branch = 1;
			end else begin 
				Branch = 0;
			end

		end 
		XORI: begin
			RegDst   = 0;
			RegWr    = 1;
			ALUcntrl = 3'b010;
			MemWr    = 0;
			MemToReg = 0;
			ALUsrc   = 0;
			Branch 	 = 0;

		end 
		ADDI: begin
			RegDst   = 0;
			RegWr    = 1;
			ALUcntrl = 3'b000;
			MemWr    = 0;
			MemToReg = 0;
			ALUsrc   = 0;
			Branch 	 = 0;

		end
		ADD: begin
			RegDst   = 1;
			RegWr    = 1;
			ALUcntrl = 3'b000;
			MemWr    = 0;
			MemToReg = 0;
			ALUsrc   = 0;
			Branch 	 = 0;

		end
		SUB: begin
			RegDst   = 1;
			RegWr    = 1;
			ALUcntrl = 3'b001;
			MemWr    = 0;
			MemToReg = 0;
			ALUsrc   = 0;
			Branch 	 = 0;

		end
		SLT: begin
			RegDst   = 1;
			RegWr    = 1;
			ALUcntrl = 3'b011;
			MemWr    = 0;
			MemToReg = 0;
			ALUsrc   = 0;
			Branch 	 = 0;
		end 
	endcase
end
endmodule
