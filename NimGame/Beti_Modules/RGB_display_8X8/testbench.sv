`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 
// Design Name: 
// Module Name: testbench
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
module testbench();

logic clk;
logic reset_out;
logic OE;
logic SH_CP;
logic ST_CP;
logic DS;
logic [7:0] col_select;

top DUT(
	.clk(clk), //100Mhz on Basys3
	
	.reset_out(reset_out),
	.OE(OE),
	.SH_CP(SH_CP),
	.ST_CP(ST_CP),
	.DS(DS),
	.col_select(col_select)  
);

initial begin
	clk = 1'b0;
	
	
end
  
always 
	#5  clk =  !clk;  

endmodule
