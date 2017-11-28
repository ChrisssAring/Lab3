`include "cpu.v"

module cpu_test ();

    reg clk;
    reg [31:0] pc;

    initial clk=1;
    always #300 clk = !clk;

    cpu cpu(.clk(clk));

    reg [1023:0] mem_fn;
    reg [1023:0] dump_fn;

    initial begin
    $dumpfile("cpu.vcd");
    $dumpvars();


    $readmemh(mem_fn, memory.dat); #200;
    
    


    $display("Time |         pc | instruction   | Read 1       |   Rs       | Rt     | Rd     | exec result ");
    repeat(10) begin

        $display("%4t | %d | %d    |  %d  |   %b    | %b  | %b  | %d ", $time, cpu.pc_out, cpu.instruction, cpu.read1, cpu.rs, cpu.rt, cpu.rd, cpu.exec_result); #400;
        end

    #8000 $finish();
    end

endmodule


