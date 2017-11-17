//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------
`include "Registers/register.v"
`include "Registers/decoders.v"

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

  wire[31:0] wrenable; 
  decoder1to32 decode(wrenable, RegWrite, WriteRegister);
  wire[31:0] regOutputs[31:0];
  register32zero registerZero(regOutputs[0], WriteData, wrenable[0], Clk); // Set first register to all 0's

  generate
    genvar i;
    for (i = 1; i < 32; i = i + 1)
      begin : writeRegisterLoop
        register32 registerWriter(regOutputs[i], WriteData, wrenable[i], Clk);
    end
  endgenerate

  // Select the correct registers to read from
  mux32to1by32 muxRegister1(ReadData1,
  						   ReadRegister1, 
  						   regOutputs[0],
  						   regOutputs[1],
  						   regOutputs[2],
  						   regOutputs[3],
  						   regOutputs[4],
  						   regOutputs[5],
  						   regOutputs[6],
  						   regOutputs[7],
  						   regOutputs[8],
  						   regOutputs[9],
  						   regOutputs[10],
  						   regOutputs[11],
  						   regOutputs[12],
  						   regOutputs[13],
  						   regOutputs[14],
  						   regOutputs[15],
  						   regOutputs[16],
  						   regOutputs[17],
  						   regOutputs[18],
  						   regOutputs[19],
  						   regOutputs[20],
  						   regOutputs[21],
  						   regOutputs[22],
  						   regOutputs[23],
  						   regOutputs[24],
  						   regOutputs[25],
  						   regOutputs[26],
  						   regOutputs[27],
  						   regOutputs[28],
  						   regOutputs[29],
  						   regOutputs[30],
  						   regOutputs[31]
  						   );

  mux32to1by32 muxRegister2(ReadData1,
  						   ReadRegister1, 
  						   regOutputs[0],
  						   regOutputs[1],
  						   regOutputs[2],
  						   regOutputs[3],
  						   regOutputs[4],
  						   regOutputs[5],
  						   regOutputs[6],
  						   regOutputs[7],
  						   regOutputs[8],
  						   regOutputs[9],
  						   regOutputs[10],
  						   regOutputs[11],
  						   regOutputs[12],
  						   regOutputs[13],
  						   regOutputs[14],
  						   regOutputs[15],
  						   regOutputs[16],
  						   regOutputs[17],
  						   regOutputs[18],
  						   regOutputs[19],
  						   regOutputs[20],
  						   regOutputs[21],
  						   regOutputs[22],
  						   regOutputs[23],
  						   regOutputs[24],
  						   regOutputs[25],
  						   regOutputs[26],
  						   regOutputs[27],
  						   regOutputs[28],
  						   regOutputs[29],
  						   regOutputs[30],
  						   regOutputs[31]
  						   );
endmodule