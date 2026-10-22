`timescale 1ns / 1ps
module ram8_8_tb();
    reg        clk, rst, wr_enb;
    reg  [3:0] wr_addr, rd_addr;
    reg  [7:0] data_in;
    wire [7:0] data_out;

    // Design instantiation
    ram8_8 dut (clk, rst, wr_enb, wr_addr, rd_addr, data_in, data_out);

    // Clock generation (10 ns period)
    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/ram8_8.vcd");
        $dumpvars(0, ram8_8_tb);
    end

    initial begin
        {clk, rst, wr_enb, wr_addr, rd_addr, data_in} = 0;
        rst = 1;

        #10;
        rst = 0;
        wr_enb = 1; wr_addr = 4'd4; data_in = 8'd5;    // write 5  -> mem[4]

        #10;
        wr_enb = 1; wr_addr = 4'd5; data_in = 8'd10;   // write 10 -> mem[5]

        #10;
        wr_enb = 0; rd_addr = 4'd4;                    // read mem[4]

        #10;
        rd_addr = 4'd5;                                // read mem[5]

        #20 $finish;
    end
endmodule
