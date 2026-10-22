`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.10.2026 22:23:27
// Design Name: 
// Module Name: ram8_8
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ram8_8(
    input clk,
    input rst,
    input wr_enb,
    input[3:0] wr_addr,
    input[3:0] rd_addr,
    input [7:0]data_in,
    
    output reg [7:0] data_out
    );
    //creating an internal memory of length 8bit and width of 8bits
    reg [7:0]mem[7:0];
    integer i;
    //reset and write logic
    always@(posedge clk or rst)begin  //asynchrounous
       if(rst)begin
          for(i=0;i<7;i=i+1)
          mem[i] <=0;
          end
       else
         if(wr_enb)
         mem[wr_addr] <=data_in;
    // read logic
       else if(wr_enb ==0)
         data_out <= mem[rd_addr];
    end
    
    
         
    
    
endmodule
