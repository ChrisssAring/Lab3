//------------------------------------------------------------------------
// Data Memory
//   Positive edge triggered
//   dataOut always has the value mem[address]
//   If writeEnable is true, writes dataIn to mem[address]
//------------------------------------------------------------------------

module datamemory
#(
    parameter width = 32
)
(
    input 		                clk,
    output reg [width-1:0]      dataOut,
    input      [width-1:0]      address,
    input                       writeEnable,
    input      [width-1:0]      dataIn
);


    reg [width-1:0] memory [1023:0];

    always @(posedge clk) begin
        if(writeEnable)
            memory[address] <= dataIn;
        dataOut <= memory[address];
    end

endmodule
