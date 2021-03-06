module VGA_Controller_Game(
input clk,
input pixel_in,
input orientation,
input [9:0] headX,
input [9:0] headY,
input [9:0] tailX,
input [9:0] tailY,
output reg hsync,
output reg vsync,
output reg [3:0] R,
output reg [3:0] G,
output reg [3:0] B);

reg [9:0] X,Y;
reg [9:0] hcount,vcount;
reg hsync1,vsync1;
reg visible;
wire clk_25MHz;
reg flag;

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
flag<=0;
X<=0;
Y<=0;
end 
always @(posedge clk_25MHz)
begin
	if(~orientation)
		Y<=headY + 10;
	else
	 	X<=headX + 10;
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

always @(posedge clk_25MHz) //snake 
begin
if(pixel_in)
begin 
	if(visible)
	begin
		if(~orientation)
		begin
			if(headX>tailX)
			begin 
				if(hcount >=tailX && hcount <= headX)
				begin
				
					if(vcount >=headY && vcount<=Y)
					begin
						
						R<=0;
						G<=0;
						B<=4'b1111;
					end	
					else
					begin 
						
						R<=4'b1111;
						G<=4'b1111;
						B<=4'b1111;
					end 
				end  
				else
				begin 
					
					R<=4'b1111;
					G<=4'b1111;
					B<=4'b1111;
				end
			end
			else
			begin
				if(hcount >=headX && hcount <= tailX)
				begin
				
					if(vcount >=headY && vcount<=Y)
					begin
						
						R<=0;
						G<=0;
						B<=4'b1111;
					end	
					else
					begin 
						
						R<=4'b1111;
						G<=4'b1111;
						B<=4'b1111;
					end 
				end  
				else
				begin 
					
					R<=4'b1111;
					G<=4'b1111;
					B<=4'b1111;
				end
			end
		end
		else
		begin
			if(headY>tailY)
			begin
				if(hcount >=headX && hcount <= X)
				begin
				
					if(vcount >=tailY && vcount<=headY)
					begin
						flag<=1;
						R<=0;
						G<=0;
						B<=4'b1111;
					end	
					else
					begin 
						flag<=0;
						R<=4'b1111;
						G<=4'b1111;
						B<=4'b1111;
					end 
				end  
				else
				begin 
					
					R<=4'b1111;
					G<=4'b1111;
					B<=4'b1111;
				end
			end
			else
			begin
				if(hcount >=headX && hcount <= X)
				begin
				
					if(vcount >=headY && vcount<=tailY)
					begin
						flag<=1;
						R<=0;
						G<=0;
						B<=4'b1111;
					end	
					else
					begin 
						flag<=0;
						R<=4'b1111;
						G<=4'b1111;
						B<=4'b1111;
					end 
				end  
				else
				begin 
					
					R<=4'b1111;
					G<=4'b1111;
					B<=4'b1111;
				end
			end
		end	
	end	 
	else 
	begin 
		R<=0;
		G<=0;
		B<=0;
	end
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

