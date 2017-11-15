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
    input OP,
    output reg RegDst,RegWr,ALUcntrl,MemWr,MemToReg,ALUsrc
);

always @(OP) begin
	case (OP)
		default:begin
			RegDst   = X;
			RegWr    = X;
			ALUcntrl = X;
			MemWr    = X;
			MemToReg = X;
			ALUsrc   = X;
		end
		opLW: begin
			RegDst   = 0;
			RegWr    = 1;
			ALUcntrl = 000;
			MemWr    = 0; 
			MemToReg = 1;
			ALUsrc   = 1;
		end
		opSW: begin
			RegDst   = X;
			RegWr    = 0;
			ALUcntrl = 000;
			MemWr    = 1;
			MemToReg = 0;
			ALUsrc   = 1;
		end
		opJ: begin
			RegDst   = ;
			RegWr    = ;
			ALUcntrl = 000;
			MemWr    = ;
			MemToReg = ;
			ALUsrc   = ;
		end
		opJR: begin
			RegDst   = ;
			RegWr    = ;
			ALUcntrl = 000;
			MemWr    = X;
			MemToReg = 1;
			ALUsrc   = ;
		end 
		opJAL: begin
			RegDst   = ;
			RegWr    = ;
			ALUcntrl = 000;
			MemWr    = X;
			MemToReg = 1;
			ALUsrc   = ;
		end
		opBNE: begin
			RegDst   = X;
			RegWr    = 0;
			ALUcntrl = 001;
			MemWr    = 0;
			MemToReg = X;
			ALUsrc   = 0;
		end 
		opXORI: begin
			RegDst   = 0;
			RegWr    = 1;
			ALUcntrl = 010;
			MemWr    = 0;
			MemToReg = 0;
			ALUsrc   = 0;
		end 
		opADDI: begin
			RegDst   = 0;
			RegWr    = 1;
			ALUcntrl = 000;
			MemWr    = 0;
			MemToReg = 0;
			ALUsrc   = 0;
		end
		opADD: begin
			RegDst   = 1;
			RegWr    = 1;
			ALUcntrl = 000;
			MemWr    = 0;
			MemToReg = 0;
			ALUsrc   = 0;
		end
		opSUB: begin
			RegDst   = 1;
			RegWr    = 1;
			ALUcntrl = 001;
			MemWr    = 0;
			MemToReg = 0;
			ALUsrc   = 0;
		end
		opSLT: begin
			RegDst   = 1;
			RegWr    = 1;
			ALUcntrl = 011;
			MemWr    = 0;
			MemToReg = 0;
			ALUsrc   = 0;
		end 
	endcase

endmodule