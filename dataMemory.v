//------------------------------------------------------------------------
// Data Memory
//   Positive edge triggered
//   dataOut always has the value mem[address]
//   If writeEnable is true, writes dataIn to mem[address]
//------------------------------------------------------------------------

module dataMemory
#(
    parameter width = 32
)
(
    input                       clk,
    output reg [width-1:0]      dataOut,
    input      [31:0]            address,
    input                       writeEnable,
    input      [width-1:0]      dataIn
);


    reg [width-1:0] mem [1023:0];

    always @(posedge clk) begin
        if(writeEnable)
            mem[address] <= dataIn;
        dataOut <= mem[address];
    end

endmodule
