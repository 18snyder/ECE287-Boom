module logic(check, rst, in, out0, out1, out2, out3, out4, out5, out6, out7, ledR, clk, en, start_screen, count, segment, segment1, segment2, segment3, led1, led2, led3, led4, led5, Aout, Bout, Cout, Dout, x, y);
input check, rst;
input [3:0] in;
output reg [0:0] ledR;
output reg [0:0] out0, out1, out2, out3, out4, out5, out6, out7;
output reg start_screen;
input [9:0]x;
input [8:0]y;
output led1, led2, led3, led4, led5;
input clk;
input en;
output [8:0] count;
output [6:0] segment, segment1, segment2, segment3;
output reg [3:0] Aout, Bout, Cout, Dout;

reg [3:0] s;
reg [3:0] ns;
//reg ledcon;


parameter
START = 3'd0,
   s2 = 3'd1,
	s3 = 3'd2,
	s4 = 3'd3,
  END = 3'd4; 
  //FAIL = 3'd5;
  
always@ (posedge check or negedge rst)
	if (rst == 1'b0)
		begin
			s <= START;
			ledR <= 1'b1;
		end
	else 
		begin
			s <= ns;
		   ledR <= 1'b0;
		end
		
always@ (*)
	case(s)
START: if(in == 4'b0010)
		 begin
			ns = s2;
			//start_screen = 1'b1;
		end
		else begin 
			ns = START;
			//start_screen = 1'b1;
			end
	s2: if (in == 4'b0110)
			ns = s3;
		else 
			ns = s2;
	s3: if (in == 4'b0100)
			ns = s4;
		else
			ns = s3;
	s4: if (in == 4'b1110)
			ns = END;
		else
			ns = s4;
	END: begin 
			ns = END;
			end
	endcase
always@ (*)
	case(s)
		START: begin
			out0 = 1'b1;
			out1 = 1'b0;
			out2 = 1'b0;
			out3 = 1'b0;
			out4 = 1'b0;
			out5 = 1'b0;
			out6 = 1'b0;
			out7 = 1'b0;
			end
		s2: begin
			out0 = 1'b1;
			out1 = 1'b1;
			out2 = 1'b0;
			out3 = 1'b0;
			out4 = 1'b0;
			out5 = 1'b0;
			out6 = 1'b0;
			out7 = 1'b0;
			end
		s3: begin
			out0 = 1'b01;
			out1 = 1'b1;
			out2 = 1'b1;
			out3 = 1'b0;
			out4 = 1'b0;
			out5 = 1'b0;
			out6 = 1'b0;
			out7 = 1'b0;
			end
		s4: begin
			out0 = 1'b1;
			out1 = 1'b1;
			out2 = 1'b1;
			out3 = 1'b1;
			out4 = 1'b0;
			out5 = 1'b0;
			out6 = 1'b0;
			out7 = 1'b0;
			end
		END: begin 
			out0 = 1'b1;
			out1 = 1'b1;
			out2 = 1'b1;
			out3 = 1'b1;
			out4 = 1'b1;
			out5 = 1'b1;
			out6 = 1'b1;
			out7 = 1'b1;
			end
	endcase
endmodule
	
	