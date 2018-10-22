`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2016 10:21:00 AM
// Design Name: 
// Module Name: testbench_2
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
logic direction;
logic [1:0] speed;
logic [3:0] phases;
logic stop;

stepmotor DUT(
	.clk(clk), //100Mhz on Basys3
    .direction(direction),
	.speed(speed),
    .phases(phases),
	.stop(stop)
);

initial begin
	clk = 1'b0;
	direction = 1'b0;
	speed = 2'b00;
	stop = 1'b0;
	#40_000_000;
	
	speed = 2'b11;
	#100_000_000;
	
	
end
  
always 
	#5  clk =  !clk;  

endmodule
