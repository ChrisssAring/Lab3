module register
#(parameter width = 32)
(
	input                  WrEn,   // Write Enable
	input      [4:0]       Rs,     // First register to read from
	input      [4:0]       Rt,     // Second register to read from
	input      [4:0]       Aw,     // Write to this register
	input      [width-1:0] Dw,     // Write Data to register when WrEn is high
	output reg [width-1:0] Da,     // Read Data 1
	output reg [width-1:0] Db,     // Read Data 2
)

    always @(posedge clk) begin
        Da <= 
        Db <= 
    end

endmodule