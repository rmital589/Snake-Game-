module Game_Engine(
input sec_counter,
input start,
input pause,
input esc,
input Keypressed, 
input [1:0] direction,
output pixel_out,
output [9:0] headX,
output [9:0] headY,
output [9:0] tailX,
output [9:0] tailY,
output [9:0] X,
output [9:0] Y,
output orientation1
);

wire clk_25MHz;
reg [9:0] headX1,headY1,tailX1,tailY1;
//ClkDivider c1 (clk,clk_25MHz);
reg orientation;
//reg sec_counter;
reg [24:0] counter;



initial 
begin
counter<=0; 
//sec_counter<=0;
headX1 <= 40;
headY1 <= 5;
tailX1 <= 0;
tailY1 <= 5;
orientation <=0;
end 

/*always @(posedge clk_25MHz) // seconds counter 
begin 
	   counter<=counter+1;
	   if(counter == 12500000)
	   begin
	       sec_counter <= ~sec_counter;
	       counter<=0;
	   end		
end */

always @(posedge sec_counter) //X and Y for each direction 
begin 
	if(start && ~pause && headX1>0 && headX1<640 && headY1>0 && headY1<480)
	begin
	if(Keypressed)
	begin
		case(direction)
			2'b00: begin //up
					if(headY1 == tailY1)
					begin
						if(headX1 > tailX1)
						begin
							headX1 <= headX1 - 10;		
							headY1 <= headY1 - 30;
							tailX1 <= tailX1 + 30;
							tailY1 <= tailY1 + 10;
							orientation <= 1;
						end
						else
						begin
							headX1 <= headX1;		
							headY1 <= headY1 - 30;
							tailX1 <= tailX1 - 40;
							tailY1 <= tailY1 + 10;
							orientation <= 1;
						end
			         end
			         else if(headX1 == tailX1)
			         begin
			             if(headY1 > tailY1)
                                 begin
                                 headX1<=headX1;
                                 headY1<=headY1+5;
                                 tailX1<=tailX1;
                                 tailY1<=tailY1+5;
                                 end
                                 else
                                 begin
                                 headX1<=headX1;
                                 headY1<=headY1-5;
                                 tailX1<=tailX1;
                                 tailY1<=tailY1-5;
                                 end
			         end
				        
				end
			2'b10: begin //down
					if(headY1 == tailY1)
					begin
						if(headX1>tailX1)
						begin
							headX1 <= headX1 - 10;		
							headY1 <= headY1 + 40;
							tailX1 <= tailX1 + 30;
							tailY1 <= tailY1;
							orientation <= 1;
						end
						else
						begin
							headX1 <= headX1;		
							headY1 <= headY1 + 40;
							tailX1 <= tailX1 - 40;
							tailY1 <= tailY1;
							orientation <= 1;
						end
			            end
			            else if(headX1 == tailX1)
                        begin
                        if(headY1 > tailY1)
                        begin
                        headX1<=headX1;
                        headY1<=headY1+5;
                        tailX1<=tailX1;
                        tailY1<=tailY1+5;
                        end
                        else
                        begin
                        headX1<=headX1;
                        headY1<=headY1-5;
                        tailX1<=tailX1;
                        tailY1<=tailY1-5;
                        end
                        end
					
			       end
			2'b11: begin //left
					if(headX1 == tailX1)
					begin
						if(headY1<tailY1)
						begin
							headX1 <= headX1 - 30;		
							headY1 <= headY1;
							tailX1 <= tailX1 + 10;
							tailY1 <= tailY1 - 40;
							orientation <= 0;
						end
						else
						begin
							headX1 <= headX1 - 30;		
							headY1 <= headY1 - 10;
							tailX1 <= tailX1 + 10;
							tailY1 <= tailY1 + 30;
							orientation <= 0;
						end
			                end
			                else if(headY1 == tailY1)
			                begin
			                if(headX1 > tailX1)
                            begin
                            headX1<=headX1+5;
                            headY1<=headY1;
                            tailX1<=tailX1+5;
                            tailY1<=tailY1;
                            end
                            else
                            begin
                            headX1<=headX1-5;
                            headY1<=headY1;
                            tailX1<=tailX1-5;
                            tailY1<=tailY1;
                            end
			                end
			       end
			2'b01: begin //right
					if(headX1 == tailX1)
					begin
						if(headY1<tailY1)
						begin
							headX1 <= headX1 + 40;		
							headY1 <= headY1;
							tailX1 <= tailX1;
							tailY1 <= tailY1 - 40;
							orientation <= 0;
						end
						else
						begin
							headX1 <= headX1 + 40;		
							headY1 <= headY1 - 10;
							tailX1 <= tailX1;
							tailY1 <= tailY1 + 30;
							orientation <= 0;
						end
			                end
			             else if(headY1 == tailY1)
                         begin
                         if(headX1 > tailX1)
                         begin
                         headX1<=headX1+5;
                         headY1<=headY1;
                         tailX1<=tailX1+5;
                         tailY1<=tailY1;
                         end
                         else
                         begin
                         headX1<=headX1-5;
                         headY1<=headY1;
                         tailX1<=tailX1-5;
                         tailY1<=tailY1;
                         end
                         end
				end	
				
		endcase
		end
		else
		begin
		  if(headY1 == tailY1)
          begin
          if(headX1 > tailX1)
          begin
          headX1<=headX1+5;
          headY1<=headY1;
          tailX1<=tailX1+5;
          tailY1<=tailY1;
          end
          else
          begin
          headX1<=headX1-5;
          headY1<=headY1;
          tailX1<=tailX1-5;
          tailY1<=tailY1;
          end
          end
          if(headX1 == tailX1)
          begin
          if(headY1 > tailY1)
          begin
          headX1<=headX1;
          headY1<=headY1+5;
          tailX1<=tailX1;
          tailY1<=tailY1+5;
          end
          else
          begin
          headX1<=headX1;
          headY1<=headY1-5;
          tailX1<=tailX1;
          tailY1<=tailY1-5;
          end
          end
		
		end 
	end
	else
	begin
	headX1<=headX1;
    headY1<=headY1;
    tailX1<=tailX1;
    tailY1<=tailY1;
	end
end

assign pixel_out =  start & ~esc; 
assign headX = headX1;
assign headY = headY1;
assign tailX = tailX1;
assign tailY = tailY1;
assign X = headX1+10;
assign Y = headY1+10;
assign orientation1 = orientation;
endmodule

