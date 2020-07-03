module VGA_Controller(
input clk,
input [7:0] pixel_color,
output reg hsync,
output reg vsync,
output reg [3:0] R,
output reg [3:0] G,
output reg [3:0] B);

reg [9:0] hcount,vcount;
reg hsync1,vsync1;
reg visible;
wire clk_25MHz;


ClkDivider c0 (clk,clk_25MHz);

initial 
begin 
hcount<=0;
vcount<=0;
hsync<=0;
vsync<=0;
hsync1<=0;
vsync1<=0;
visible<=0;
R<=0;
G<=0;
B<=0;
end 

always @(hcount) //to check for visible region 
begin 
if(hcount >=0 && hcount <= 639)
begin 
	if(vcount >=0 && vcount<=479)
		visible<=1;
	else
	visible<=0;
end
else 
	visible<=0;
end

always @(posedge clk_25MHz) //output RGB values 
begin 
if(visible)
begin 
	case(pixel_color)
		8'b00000001: begin
				R<=0;
				G<=0;
				B<=0;
			end
		8'b00000010: begin 
				R<=0;
				G<=0;
				B<=4'b1111;
			end
		8'b00000100: begin
				R<=4'b1010;
				G<=4'b0010;
				B<=4'b0010;
			end
		8'b00001000: begin 
				R<=4'b1101;
				G<=4'b1111;
				B<=4'b1111;
			end
		8'b00010000: begin
				R<=4'b1111;
				G<=0;
				B<=0;
			end
		8'b00100000: begin 
				R<=4'b1000;
				G<=0;
				B<=4'b1000;
			end
		8'b01000000: begin
				R<=4'b1111;
				G<=4'b1111;
				B<=0;
			end
		8'b10000000: begin 
				R<=4'b1111;
				G<=4'b1111;
				B<=4'b1111;
			end
		default: begin 
				R<=0;
				G<=0;
				B<=0;
			end
		
	endcase
end 
else 
begin 
	R<=0;
	G<=0;
	B<=0;
end
end 

always @(posedge clk_25MHz) //generate hcount
begin
if(hcount == 799)
hcount<=0;
else
hcount<=hcount+1;  
end

always @(posedge clk_25MHz)  //generate vcount 
begin 
	if(hcount == 640)
	begin
		if(vcount == 524)
		vcount <= 0; 	
		else 
		vcount <= vcount+1;	 
	end 
	else 
	vcount<=vcount;
end

always @(hcount) //generate hsync 
begin 
if(hcount >=659 && hcount<= 755)
hsync1 <= 0;
else 
hsync1 <= 1;
end 



always @(vcount) //generate vsync 
begin 
if(vcount >=493 && vcount<= 494)
vsync1 <= 0;
else 
vsync1 <= 1;
end 

always @(posedge clk_25MHz)
begin
hsync<=hsync1;
vsync<=vsync1; 
end 

endmodule 

