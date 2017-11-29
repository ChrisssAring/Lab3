//final 32-bit ALU

`include "ALU/adder_subtracter.v"
`include "ALU/slt.v" 
`include "ALU/and_32bit.v"
`include "ALU/nand_32bit.v"
`include "ALU/xor_32bit.v"
`include "ALU/nor_32bit.v"
`include "ALU/or_32bit.v"

module ALU
(
	output reg cout, //addsub only
	output reg flag, //addsub only
	output reg[31:0] result,
	input [2:0] command,
	input [31:0] operandA,
	input [31:0] operandB,
  output reg zero
);
//everything going through the different parts
wire [31:0]addsub;
wire [31:0]xorin;
wire [31:0]slt;
wire [31:0]andin;
wire [31:0]nandin;
wire [31:0]norin;
wire [31:0]orin;
wire adder_cout;
wire adder_flag;

adder_subtracter addsub0(addsub[31:0],adder_cout,adder_flag,operandA[31:0],operandB[31:0],command[2:0]);
xor_32bit xor0(xorin[31:0],operandA[31:0],operandB[31:0]);
full_slt_32bit slt0(slt[31:0],operandA[31:0],operandB[31:0]);
and_32bit and0(andin[31:0],operandA[31:0],operandB[31:0]);
nand_32bit nand0(nandin[31:0],operandA[31:0],operandB[31:0]);
nor_32bit nor0(norin[31:0],operandA[31:0],operandB[31:0]);
or_32bit or0(orin[31:0],operandA[31:0],operandB[31:0]);


  // update on changes to ALUcommand, a, or b
  always @(command or operandA or operandB) 
  	begin
    #5000
    case (command)
      3'b000:  begin result[31:0] = addsub[31:0]; cout = adder_cout; flag = adder_flag; 
                if (result[31:0] == 32'b0) begin
                  zero = 1;
                end
                else begin
                  zero = 0;
                end
              end
      3'b001:  begin result[31:0] = addsub[31:0]; cout = adder_cout; flag = adder_flag; 
               if (result[31:0] == 32'b0) begin
                  zero = 1;
                end
                else begin
                  zero = 0;
                end
              end
      3'b010:  begin result[31:0] = xorin[31:0]; cout = 0; flag = 0; 
               if (result[31:0] == 32'b0) begin
                  zero = 1;
                end
                else begin
                  zero = 0;
                end
              end              
      3'b011:  begin result[31:0] = slt[31:0]; cout = 0; flag = 0; 
               if (result[31:0] == 32'b0) begin
                  zero = 1;
                end
                else begin
                  zero = 0;
                end
               end
      3'b100:  begin result[31:0] = andin[31:0]; cout = 0; flag = 0; zero = 0; 
               if (result[31:0] == 32'b0) begin
                  zero = 1;
                end
                else begin
                  zero = 0;
                end
                 end
      3'b101:  begin result[31:0] = nandin[31:0]; cout = 0; flag = 0; 
               if (result[31:0] == 32'b0) begin
                  zero = 1;
                end
                else begin
                  zero = 0;
                end
                end
      3'b110:  begin result[31:0] = norin[31:0]; cout = 0; flag = 0; zero = 0;
               if (result[31:0] == 32'b0) begin
                  zero = 1;
                end
                else begin
                  zero = 0;
                end
                end
      3'b111:  begin result[31:0] = orin[31:0]; cout = 0; flag = 0; zero = 0; 
               if (result[31:0] == 32'b0) begin
                  zero = 1;
                end
                else begin
                  zero = 0;
                end
      end
    endcase
    end
endmodule
