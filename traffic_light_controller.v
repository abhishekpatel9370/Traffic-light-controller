`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2025 08:22:26 PM
// Design Name: 
// Module Name: traffic_light_controller
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


module traffic_controller (
    input wire clk,              // 100 MHz clock
    input wire rst,              // Active-high reset
    output reg [2:0] NS,         // NS lights: [2]=Red, [1]=Yellow, [0]=Green
    output reg [2:0] EW          // EW lights: same
);

    // State encoding
    parameter S_NS_GREEN   = 2'b00;
    parameter S_NS_YELLOW  = 2'b01;
    parameter S_EW_GREEN   = 2'b10;
    parameter S_EW_YELLOW  = 2'b11;

    reg [1:0] state;
    reg [3:0] count;

    // Clock divider (100 MHz -> 1 Hz)
    reg [26:0] clk_div;
    reg one_sec_tick;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_div <= 0;
            one_sec_tick <= 0;
        end else begin
            if (clk_div == 100_000_000 - 1) begin
                clk_div <= 0;
                one_sec_tick <= 1;
            end else begin
                clk_div <= clk_div + 1;
                one_sec_tick <= 0;
            end
        end
    end

    // State transition on 1 Hz tick
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S_NS_GREEN;
            count <= 0;
        end else if (one_sec_tick) begin
            case (state)
                S_NS_GREEN: begin
                    if (count == 4) begin  // 5 seconds
                        state <= S_NS_YELLOW;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                end
                S_NS_YELLOW: begin
                    if (count == 1) begin  // 2 seconds
                        state <= S_EW_GREEN;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                end
                S_EW_GREEN: begin
                    if (count == 4) begin  // 5 seconds
                        state <= S_EW_YELLOW;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                end
                S_EW_YELLOW: begin
                    if (count == 1) begin  // 2 seconds
                        state <= S_NS_GREEN;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                end
                default: begin
                    state <= S_NS_GREEN;
                    count <= 0;
                end
            endcase
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            S_NS_GREEN: begin
                NS = 3'b001;  // Green
                EW = 3'b100;  // Red
            end
            S_NS_YELLOW: begin
                NS = 3'b010;  // Yellow
                EW = 3'b100;  // Red
            end
            S_EW_GREEN: begin
                NS = 3'b100;  // Red
                EW = 3'b001;  // Green
            end
            S_EW_YELLOW: begin
                NS = 3'b100;  // Red
                EW = 3'b010;  // Yellow
            end
            default: begin
                NS = 3'b100;
                EW = 3'b100;
            end
        endcase
    end

endmodule