`include "dataMemory.v"

module testDataMemory();
	reg         clk;
	reg  [31:0] dataIn;
	reg         writeEnable;
	reg  [6:0]  address;
	wire [31:0] dataOut;


	dataMemory dataMemory(.clk(clk), .dataIn(dataIn), .address(address), .writeEnable(writeEnable), .dataOut(dataOut));

	initial begin
	    $display("|WrEn|             dataIn             |           dataOut              |");

		clk = 0;
		writeEnable = 1; dataIn = 32'd11; address = 7'd22;
		#10 clk=1; #10 clk=0; #10; clk=1; #10 clk=0; #10;	// Generate two clock pulses
		$display("| %b  |%b|%b|", writeEnable, dataIn[31:0], dataOut[31:0]);

		writeEnable = 0; dataIn = 32'd20; address = 7'd22;
		#10 clk=1; #10 clk=0; #10 clk=1; #10 clk=0;	// Generate two clock pulses
		$display("| %b  |%b|%b|", writeEnable, dataIn[31:0], dataOut[31:0]);
	
	end 
endmodule
