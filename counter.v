module counter(clk, rst, en, count, segment, segment1, segment2, segment3, led1, led2, led3, led4, led5, Aout, Bout, Cout, Dout);
input clk, rst;
input en;
output reg [8:0] count;
reg [25:0] altcount;
output wire [6:0] segment;
output wire [6:0] segment1;
output wire [6:0] segment2;
output wire [6:0] segment3;
output reg led1;
output reg led2;
output reg led3;
output reg led4;
output reg led5;
output reg [3:0] Aout;
output reg [3:0] Bout;
output reg [3:0] Cout;
output reg [3:0] Dout = 0;



Display A(Aout[3],Aout[2],Aout[1],Aout[0],segment[0],segment[1],segment[2],segment[3],segment[4],segment[5],segment[6]);
Display B(Bout[3],Bout[2],Bout[1],Bout[0],segment1[0],segment1[1],segment1[2],segment1[3],segment1[4],segment1[5],segment1[6]);
Display C(Cout[3],Cout[2],Cout[1],Cout[0],segment2[0],segment2[1],segment2[2],segment2[3],segment2[4],segment2[5],segment2[6]);
Display D(Dout[3],Dout[2],Dout[1],Dout[0],segment3[0],segment3[1],segment3[2],segment3[3],segment3[4],segment3[5],segment3[6]);


always@(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
			begin
				Aout <= count;
				Bout <= 1'b0;
				Cout <= 1'b0;
				count <= 9'd0;
				altcount <= 4'd0;
				led1 <= 1'b0;
				led2 <= 1'b0;
				led3 <= 1'b0;
				led4 <= 1'b0;
				led5 <= 1'b0;
			end
		else if (en == 1'b1)
			begin
				Aout <= Aout;
				count <= count;
				altcount <= 4'd0;
			end

		else if(count <= 9'd60)
			begin
				altcount <= altcount + 26'd1;
				if (altcount == 26'd50_000_000)
					begin
						count = count + 9'd1;
						
						
						if( count%10 == 0)
							begin
								Aout <= 4'd0;
								Bout <= Bout + 1;
							end
						else 
							begin
								Aout <= Aout + 4'd1;
								Bout <= Bout;
							end
							
						if (count%60 == 0)
							begin 
								Aout <= 4'd0;
								Bout <= 4'd0;
								Cout <= Cout + 1;
							end
						else 
							begin
							 Cout <= Cout;
							end
						
							if(count >= 9'd12)
								begin
									led1 <= 1'b0;
								end
							else
								begin
									led1 <= 1'b1;
								end
//------------------------------------------------------------------------
							if(count >= 9'd24)
								begin
									led2 <= 1'b0;
								end
							else
								begin
									led2 <= 1'b1;
								end
//------------------------------------------------------------------------
							if(count >= 9'd36)
								begin
									led3 <= 1'b0;
								end
							else
								begin
									led3 <= 1'b1;
								end
//-------------------------------------------------------------------------
							if(count >= 9'd48)
								begin
									led4 <= 1'b0;
								end
							else
								begin
									led4 <= 1'b1;
								end
//------------------------------------------------------------------------
							if(count >= 9'd60)
								begin
									led5 <= 1'b0;
								end
							else
								begin
									led5 <= 1'b1;
								end
//------------------------------------------------------------------------
							end
					end
				else
		begin
			Aout <= 0;
			Bout <= 0;
			Cout <= Cout;
		end

	end
endmodule 