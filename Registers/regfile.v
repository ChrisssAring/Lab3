//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------

`include "Registers/decoders.v"
`include "Registers/multiplexer.v"
`include "Registers/register.v"

module regfile
(
output[31:0]	ReadData1,	// Contents of first register read
output[31:0]	ReadData2,	// Contents of second register read
input[31:0]	WriteData,	// Contents to write to register
input[4:0]	ReadRegister1,	// Address of first register to read
input[4:0]	ReadRegister2,	// Address of second register to read
input[4:0]	WriteRegister,	// Address of register to write
input		RegWrite,	// Enable writing of register when High
input		Clk		// Clock (Positive Edge Triggered)
);

  // These two lines are clearly wrong.  They are included to showcase how the 
  // test harness works. Delete them after you understand the testing process, 
  // and replace them with your actual code.
  //assign ReadData1 = 42;
  //assign ReadData2 = 42;

  wire[31:0] writeFinal;
  wire[(32*32) - 1:0] registerFinal;

  decoder1to32 decoder(writeFinal, RegWrite, WriteRegister);
  register32zero register1(registerFinal[31:0], WriteData, writeFinal[0], Clk);

  genvar i;
  generate 
  for (i = 1; i < 32; i = i + 1) begin: allRegisters
        register32 register2(registerFinal[32 * (i + 1) - 1:32 * i], WriteData, writeFinal[i], Clk);
  end
  endgenerate
    
  mux32to1by32 mux1(ReadData1, ReadRegister1, registerFinal);
  mux32to1by32 mux2(ReadData2, ReadRegister2, registerFinal);

endmodule
