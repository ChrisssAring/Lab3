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
    input opCode,
    output reg RegDst,RegWr,ALUcntrl,MemWr,MemToReg,ALUsrc,PCsrc
);

always @(opCode) begin
	case (opCode)
		default:begin
			RegDst   = X;
			RegWr    = X;
			ALUcntrl = X;
			MemWr    = X;
			MemToReg = X;
			ALUsrc   = X;
			PCsrc 	 = X;
		end
		opLW: begin
			RegDst   = 0;
			RegWr    = 1;
			ALUcntrl = 000;
			MemWr    = 0; 
			MemToReg = 1;
			ALUsrc   = 1;
			PCsrc 	 = X;

		end
		opSW: begin
			RegDst   = X;
			RegWr    = 0;
			ALUcntrl = 000;
			MemWr    = 1;
			MemToReg = 0;
			ALUsrc   = 1;
			PCsrc 	 = X;

		end
		opJ: begin
			RegDst   = ;
			RegWr    = ;
			ALUcntrl = 000;
			MemWr    = ;
			MemToReg = ;
			ALUsrc   = ;
			PCsrc 	 = X;

		end
		opJR: begin
			RegDst   = ;
			RegWr    = ;
			ALUcntrl = 000;
			MemWr    = X;
			MemToReg = 1;
			ALUsrc   = ;
			PCsrc 	 = X;

		end 
		opJAL: begin
			RegDst   = ;
			RegWr    = ;
			ALUcntrl = 000;
			MemWr    = X;
			MemToReg = 1;
			ALUsrc   = ;
			PCsrc 	 = X;

		end
		opBNE: begin
			RegDst   = X;
			RegWr    = 0;
			ALUcntrl = 001;
			MemWr    = 0;
			MemToReg = X;
			ALUsrc   = 0;
			PCsrc 	 = X;

		end 
		opXORI: begin
			RegDst   = 0;
			RegWr    = 1;
			ALUcntrl = 010;
			MemWr    = 0;
			MemToReg = 0;
			ALUsrc   = 0;
			PCsrc 	 = X;

		end 
		opADDI: begin
			RegDst   = 0;
			RegWr    = 1;
			ALUcntrl = 000;
			MemWr    = 0;
			MemToReg = 0;
			ALUsrc   = 0;
			PCsrc 	 = X;

		end
		opADD: begin
			RegDst   = 1;
			RegWr    = 1;
			ALUcntrl = 000;
			MemWr    = 0;
			MemToReg = 0;
			ALUsrc   = 0;
			PCsrc 	 = X;

		end
		opSUB: begin
			RegDst   = 1;
			RegWr    = 1;
			ALUcntrl = 001;
			MemWr    = 0;
			MemToReg = 0;
			ALUsrc   = 0;
			PCsrc 	 = X;

		end
		opSLT: begin
			RegDst   = 1;
			RegWr    = 1;
			ALUcntrl = 011;
			MemWr    = 0;
			MemToReg = 0;
			ALUsrc   = 0;
			PCsrc 	 = X;

		end 
	endcase

endmodule
