module top(
input clk,
output reg hsync,
output reg vsync,
output reg [3:0] R,
output reg [3:0] G,
output reg [3:0] B);
 
wire pixel;
reg [9:0] headX,headY,tailX,tailY;
reg orientation;
Game_Engine GO (clk,1'b1,1'b0,1'b0,2'b01,pixel, headX, headY,tailX,tailY,orientation);
VGA_Controller_Game VO(clk, pixel,orientation, headX, headY, tailX,tailY ,hsync, vsync,R,G,B);

endmodule
