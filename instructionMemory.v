module instructionMemory
(
  input[31:0] address,
  output [31:0] dataOut
);

  reg [31:0] mem[0:1023];
  initial $readmemh("memory.dat", mem);

  assign dataOut = mem[address];
endmodule
