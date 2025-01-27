`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2025 10:17:24 PM
// Design Name: 
// Module Name: tbtrafficlightcontroller
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


module tbtrafficlightcontroller;
reg clk,reset;
reg highway_road,country_road;
wire Redhigh,Greenhigh,Yellowhigh,Redcountry,Greencountry,Yellowcountry;
 traffic_controller utt(clk,reset,highway_road,country_road,Redhigh,Greenhigh,Yellowhigh,Redcountry,Greencountry,Yellowcountry);
wire [1:0] light_A,light_B;


// to make the output of the simulator simplier 
// we define to variable wire to store the result to 6 light
// it store 3 highway light in light A and 3 country light in light B

parameter R=0,
          Y=1,
          G=2;
          
          
assign light_A = 
              (Redhigh ? R : Yellowhigh ? Y : Greenhigh ? G : 0);
 assign light_B =  (Redcountry ? R : Yellowcountry ? Y : Greencountry ? G : 0);

initial
clk=0;
always #5 clk=~clk; // clk generation of 10 ns
initial
begin 
# 3 reset =1;
# 10 reset=0;
# 20 highway_road=1;
# 50 country_road=1;

 end
 
 initial 
 begin
 $display(" light_A = %d , light_B = %d,time =%d",$time,light_A,light_B);
 end
 
 
 
endmodule
