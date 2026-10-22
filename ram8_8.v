`timescale 1ns / 1ps
//==============================================================
// ram8_8 : 8 x 8 synchronous-write / registered-read RAM
//   - 8 locations, each 8 bits wide
//   - Asynchronous active-high reset clears the memory array
//   - wr_enb = 1 -> write data_in to mem[wr_addr] on posedge clk
//   - wr_enb = 0 -> data_out <= mem[rd_addr] on posedge clk
//==============================================================
module ram8_8 (
    input            clk,
    input            rst,
    input            wr_enb,
    input      [3:0] wr_addr,
    input      [3:0] rd_addr,
    input      [7:0] data_in,
    output reg [7:0] data_out
);

    // Internal memory: 8 locations x 8 bits
    reg [7:0] mem [7:0];
    integer i;

    always @(posedge clk or posedge rst) begin   // asynchronous reset
        if (rst) begin
            for (i = 0; i < 8; i = i + 1)        // FIX: was i<7, left mem[7] uncleared
                mem[i] <= 8'b0;
        end
        else if (wr_enb)
            mem[wr_addr] <= data_in;             // write
        else
            data_out <= mem[rd_addr];            // read
    end

endmodule
