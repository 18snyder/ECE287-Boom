module top(
//variables//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    input wire CLK,             // board clock: 100 MHz on Arty/Basys3/Nexys
    input wire RST_BTN,         // reset button
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,       // vertical sync output
    output reg [3:0] VGA_R,    // 4-bit VGA red output
    output reg [3:0] VGA_G,    // 4-bit VGA green output
    output reg [3:0] VGA_B,     // 4-bit VGA blue output
	 input check,
	 input [3:0] in,
	 output reg out0, 
	 output reg out1,
	 output reg out2, 
	 output reg out3, 
	 output reg out4, 
	 output reg out5, 
	 output reg out6, 
	 output reg out7,
	 output reg [0:0]ledR,  
	 input en,
	 output reg [8:0] count, 
	 output reg led1, 
	 output reg led2, 
	 output reg led3,
	 output reg led4, 
	 output reg led5,
	 output reg led6,
	 output reg led7,
	 output reg led8,
	 output reg led9,
	 output reg [3:0] Aout,
	 output reg [3:0] Bout,
	 output reg [3:0] Cout,
	 output reg [3:0] Dout = 0,
	 output o1, o2, o3, o4, o5, o6, o7
    );
	 
//wire\reg\parameter states///////////////////////////////////////
	wire [6:0] segment, segment1, segment2, segment3;
 reg [3:0] s;
	 reg [3:0] ns;
	 reg [25:0] altcount;
	 
	 parameter
START = 3'd0,
   s2 = 3'd1,
	s3 = 3'd2,
	s4 = 3'd3,
  END = 3'd4;
  
//reset switch//////////////////////////////////////////////////////////////////////////////////////////////////
    wire rst = ~RST_BTN;    // reset is active low on Arty & Nexys Video

    // generate a 25 MHz pixel strobe
    reg [15:0] cnt;
    reg pix_stb;
	 
	 
    always @(posedge CLK)
        {pix_stb, cnt} <= cnt + 16'h8000;  // divide by 4: (2^16)/4 = 0x4000

    wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
    wire [8:0] y;  // current pixel y position:  9-bit value: 0-511
	 
//VGA Screen///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    vga640x480 display (
        .i_clk(CLK),
        .i_pix_stb(pix_stb),
        .i_rst(rst),
        .o_hs(VGA_HS_O), 
        .o_vs(VGA_VS_O), 
        .o_x(x), 
        .o_y(y)
    );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //FIRST CLUE
	 //---DISPLAY clock edge gragh
    assign sq_a = ((x > 101) & (y >  90) & (x < 150) & (y < 100)) ? 1 : 0;
    assign sq_b = ((x > 145) & (y > 30) & (x < 155) & (y < 100)) ? 1 : 0;
    assign sq_c = ((x > 150) & (y > 30) & (x < 210) & (y < 40)) ? 1 : 0;
    assign sq_d = ((x > 50) & (y > 90) & (x < 101) & (y < 100)) ? 1 : 0;
	 assign sq_e = ((x > 200) & (y > 30) & (x < 210) & (y < 100)) ? 1 : 0;
	 assign sq_f = ((x > 200) & (y > 90) & (x < 260) & (y < 100)) ? 1 : 0;
	 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	 //SECOND CLUE
	 
	 //---top
	 //--- DISPLAY 0
	 assign st2a = ((x > 101) & (y >  90) & (x < 150) & (y < 100)) ? 1 : 0;
	 assign st2b = ((x > 101) & (y >  90) & (x < 111) & (y < 140)) ? 1 : 0;
	 assign st2c = ((x > 101) & (y >  130) & (x < 150) & (y < 140)) ? 1 : 0;
	 assign st2d = ((x > 140) & (y >  90) & (x < 150) & (y < 140)) ? 1 : 0;
	 //---DISPLAY 0
	 assign st2e = ((x > 151) & (y >  90) & (x < 200) & (y < 100)) ? 1 : 0;
	 assign st2f = ((x > 151) & (y >  90) & (x < 161) & (y < 140)) ? 1 : 0;
	 assign st2g = ((x > 151) & (y >  130) &(x < 200) & (y < 140)) ? 1 : 0;
	 assign st2h = ((x > 190) & (y >  90) & (x < 200) & (y < 140)) ? 1 : 0;
	 //---DISPLAY 1
	 assign st2i = ((x > 231) & (y >  90) & (x < 241) & (y < 140)) ? 1 : 0;
	 //---DISPLAY 1
	 assign st2j = ((x > 211) & (y >  90) & (x < 221) & (y < 140)) ? 1 : 0;
//--------------------------------------------------------------------------------------------------------------------------------------- 
	 //---bottom
	 //---DISPLAY 0
	 assign st2k = ((x > 101) & (y >  160) & (x < 150) & (y < 170)) ? 1 : 0;
	 assign st2l = ((x > 101) & (y >  160) & (x < 111) & (y < 210)) ? 1 : 0;
	 assign st2m = ((x > 101) & (y >  200) &(x < 150) & (y < 210)) ? 1 : 0;
	 assign st2n = ((x > 140) & (y >  160) & (x < 150) & (y < 210)) ? 1 : 0;
	 //---DISPLAY 0
	 assign st2o = ((x > 151) & (y >  160) & (x < 200) & (y < 170)) ? 1 : 0;
	 assign st2p = ((x > 151) & (y >  160) & (x < 161) & (y < 210)) ? 1 : 0;
	 assign st2q = ((x > 151) & (y >  200) &(x < 200) & (y < 210)) ? 1 : 0;
	 assign st2r = ((x > 190) & (y >  160) & (x < 200) & (y < 210)) ? 1 : 0;
	 //---DISPLAY 1
	 assign st2s = ((x > 231) & (y >  160) & (x < 241) & (y < 210)) ? 1 : 0;
	 //---DISPLAY 1
	 assign st2t = ((x > 211) & (y >  160) & (x < 221) & (y < 210)) ? 1 : 0;
	 //---DISPLAY bar
	 assign st2u = ((x > 61) & (y >   220) & (x < 270) & (y < 230)) ? 1 : 0;
	 //---DISPLAY plus symbol
	 //DISPLAY horizontal line
	 assign st2v = ((x > 49) & (y >   193) & (x < 85) & (y < 196)) ? 1 : 0;
	 //DISPLAY vertical line
	 assign st2w = ((x > 65) & (y >   170) & (x < 68) & (y < 220)) ? 1 : 0;
	 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	 
	 //---THIRD CLUE
	 
	 //---DISPLAY first problem	 
	 //---DISPLAY 0
	 assign st3a = ((x > 101) & (y >  80) & (x < 150) & (y < 90)) ? 1 : 0;
	 assign st3b = ((x > 101) & (y >  80) & (x < 111) & (y < 130)) ? 1 : 0;
	 assign st3c = ((x > 101) & (y >  120) & (x < 150) & (y < 130)) ? 1 : 0;
	 assign st3d = ((x > 140) & (y >  80) & (x < 150) & (y < 130)) ? 1 : 0;
	 //---DISPLAY 1
	 assign st3e = ((x > 155) & (y >  80) & (x < 165) & (y < 130)) ? 1 : 0;
	 //---DISPLAY 0
	 assign st3f = ((x > 175) & (y >  80) & (x < 225) & (y < 90)) ? 1 : 0;
	 assign st3g = ((x > 175) & (y >  80) & (x < 185) & (y < 130)) ? 1 : 0;
	 assign st3h = ((x > 175) & (y >  120) & (x < 225) & (y < 130)) ? 1 : 0;
	 assign st3i = ((x > 215) & (y >  80) & (x < 225) & (y < 130)) ? 1 : 0;
	 //---DISPLAY 1
	 assign st3j = ((x > 230) & (y >  80) & (x < 240) & (y < 130)) ? 1 : 0;
	 //---DISPLAY plus symbol
	 //---DISPLAY vertical line
	 assign st3k = ((x > 270) & (y >  80) & (x < 280) & (y < 130)) ? 1 : 0;
	 //---DISPLAY horizontal line
	 assign st3l = ((x > 250) & (y >  100) & (x < 300) & (y < 110)) ? 1 : 0;
	 //---DISPLAY 0
	 assign st3m = ((x > 310) & (y >  80) & (x < 360) & (y < 90)) ? 1 : 0;
	 assign st3n = ((x > 310) & (y >  80) & (x < 320) & (y < 130)) ? 1 : 0;
	 assign st3o = ((x > 310) & (y >  120) & (x < 360) & (y < 130)) ? 1 : 0;
	 assign st3p = ((x > 350) & (y >  80) & (x < 360) & (y < 130)) ? 1 : 0;
	 //---DISPLAY 1
	 assign st3q = ((x > 365) & (y >  80) & (x < 375) & (y < 130)) ? 1 : 0;
	 //---DISPLAY 0
	 assign st3r = ((x > 385) & (y >  80) & (x < 435) & (y < 90)) ? 1 : 0;
	 assign st3s = ((x > 385) & (y >  80) & (x < 395) & (y < 130)) ? 1 : 0;
	 assign st3t = ((x > 385) & (y >  120) & (x < 435) & (y < 130)) ? 1 : 0;
	 assign st3u = ((x > 425) & (y >  80) & (x < 435) & (y < 130)) ? 1 : 0;
	 //---DISPLAY 1
	 assign st3v = ((x > 440) & (y >  80) & (x < 450) & (y < 130)) ? 1 : 0;
	 //---DISPLAY equal symbol
	 assign st3w = ((x > 470) & (y >  120) & (x < 520) & (y < 130)) ? 1 : 0;
	 assign st3x = ((x > 470) & (y >  90) & (x < 520) & (y < 100)) ? 1 : 0;
	 //---DISPLAY ~answer
	 assign st3y = ((x > 540) & (y >  80) & (x < 550) & (y < 130)) ? 1 : 0;
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	 
	 //---DISPLAY second half of screen
	 //---DISPLAY T (true)
	 assign st3A = ((x > 340) & (y >  150) & (x < 350) & (y < 200)) ? 1 : 0;	 
	 assign st3B = ((x > 320) & (y >  150) & (x < 370) & (y < 160)) ? 1 : 0;
	 //---DISPLAY 0 (zero/"or")
	  assign st3C = ((x > 315) & (y >  230) & (x < 365) & (y < 240)) ? 1 : 0;
	 assign st3D = ((x > 315) & (y >  230) & (x < 325) & (y < 280)) ? 1 : 0;
	 assign st3E = ((x > 315) & (y >  270) & (x < 365) & (y < 280)) ? 1 : 0;
	 assign st3F = ((x > 355) & (y >  230) & (x < 365) & (y < 280)) ? 1 : 0;
	 //---DISPLAY F (false)
	 assign st3G = ((x > 340) & (y >  310) & (x < 350) & (y < 360)) ? 1 : 0;	 
	 assign st3H = ((x > 345) & (y >  310) & (x < 370) & (y < 320)) ? 1 : 0;
	 assign st3I = ((x > 345) & (y >  325) & (x < 360) & (y < 335)) ? 1 : 0;
	 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	 //---FOURTH CLUE
	 
	 //---DISPLAY line 1
	 assign st4a = ((x > 50) & (y >  90) & (x < 100) & (y < 100)) ? 1 : 0;
	 assign st4b = ((x > 130) & (y >  90) & (x < 140) & (y < 100)) ? 1 : 0;
	 assign st4c = ((x > 150) & (y >  90) & (x < 200) & (y < 100)) ? 1 : 0;
	 assign st4d = ((x > 210) & (y >  90) & (x < 220) & (y < 100)) ? 1 : 0;
	 assign st4e = ((x > 250) & (y >  90) & (x < 260) & (y < 100)) ? 1 : 0;
	 assign st4f = ((x > 270) & (y >  90) & (x < 280) & (y < 100)) ? 1 : 0;
	 assign st4g = ((x > 290) & (y >  90) & (x < 340) & (y < 100)) ? 1 : 0;
	 assign st4h = ((x > 370) & (y >  90) & (x < 380) & (y < 100)) ? 1 : 0;
	 //---DISPLAY line2
	 assign st4aa = ((x > 50) & (y >  130) & (x < 100) & (y < 140)) ? 1 : 0;
	 assign st4ba = ((x > 130) & (y >  130) & (x < 140) & (y < 140)) ? 1 : 0;
	 assign st4ca = ((x > 150) & (y >  130) & (x < 200) & (y < 140)) ? 1 : 0;
	 assign st4da = ((x > 210) & (y >  130) & (x < 220) & (y < 140)) ? 1 : 0;
	 assign st4ea = ((x > 250) & (y >  130) & (x < 260) & (y < 140)) ? 1 : 0;
	 assign st4fa = ((x > 270) & (y >  130) & (x < 280) & (y < 140)) ? 1 : 0;
	 assign st4ga = ((x > 290) & (y >  130) & (x < 340) & (y < 140)) ? 1 : 0;
	 assign st4ha = ((x > 370) & (y >  130) & (x < 380) & (y < 140)) ? 1 : 0;
	 //---DISPLAY line3
	 assign st4ab = ((x > 50) & (y >  170) & (x < 100) & (y < 180)) ? 1 : 0;
	 assign st4bb = ((x > 130) & (y >  170) & (x < 140) & (y < 180)) ? 1 : 0;
	 assign st4cb = ((x > 150) & (y >  170) & (x < 200) & (y < 180)) ? 1 : 0;
	 assign st4db = ((x > 210) & (y >  170) & (x < 220) & (y < 180)) ? 1 : 0;
	 assign st4eb = ((x > 250) & (y >  170) & (x < 260) & (y < 180)) ? 1 : 0;
	 assign st4fb = ((x > 270) & (y >  170) & (x < 280) & (y < 180)) ? 1 : 0;
	 assign st4gb = ((x > 290) & (y >  170) & (x < 340) & (y < 180)) ? 1 : 0;
	 assign st4hb = ((x > 370) & (y >  170) & (x < 380) & (y < 180)) ? 1 : 0;
	 //---DISPLAY line4
	 assign st4ac = ((x > 50) & (y >  210) & (x < 60) & (y < 220)) ? 1 : 0;
	 assign st4bc = ((x > 70) & (y >  210) & (x < 80) & (y < 220)) ? 1 : 0;
	 assign st4cc = ((x > 90) & (y >  210) & (x < 140) & (y < 220)) ? 1 : 0;
	 assign st4dc = ((x > 150) & (y > 210) & (x < 160) & (y < 220)) ? 1 : 0;
	 assign st4ec = ((x > 190) & (y > 210) & (x < 200) & (y < 220)) ? 1 : 0;
	 assign st4fc = ((x > 210) & (y > 210) & (x < 260) & (y < 220)) ? 1 : 0;
	 assign st4gc = ((x > 290) & (y > 210) & (x < 300) & (y < 220)) ? 1 : 0;
	 assign st4hc = ((x > 310) & (y > 210) & (x < 360) & (y < 220)) ? 1 : 0;
	 assign st4ic = ((x > 370) & (y > 210) & (x < 380) & (y < 220)) ? 1 : 0;
	 assign st4jc = ((x > 410) & (y > 210) & (x < 420) & (y < 220)) ? 1 : 0;
	 assign st4kc = ((x > 430) & (y > 210) & (x < 440) & (y < 220)) ? 1 : 0;
	 assign st4lc = ((x > 450) & (y > 210) & (x < 460) & (y < 220)) ? 1 : 0;
	 assign st4mc = ((x > 490) & (y > 210) & (x < 500) & (y < 220)) ? 1 : 0;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	 
	 //---END IMAGE
	 
	 //---DISPLAY W
	 assign Send =   ((x > 100) & (y > 100) & (x < 120) & (y < 250)) ? 1 : 0;
	 assign Send1 =  ((x > 100) & (y > 230) & (x < 165) & (y < 250)) ? 1 : 0;
	 assign Send2 =  ((x > 160) & (y > 100) & (x < 180) & (y < 250)) ? 1 : 0;
	 assign Send3 =  ((x > 175) & (y > 230) & (x < 240) & (y < 250)) ? 1 : 0;
	 assign Send4 =  ((x > 225) & (y > 100) & (x < 245) & (y < 250)) ? 1 : 0;
	 //---DISPLAY I
	 assign Send5 = ((x > 270) & (y > 130) & (x < 290) & (y < 250)) ? 1 : 0;
	 assign Send6 = ((x > 270) & (y > 100) & (x < 290) & (y < 120)) ? 1 : 0;
	 //---DISPLAY N
	 assign Send7 = ((x > 320) & (y > 100) & (x < 340) & (y < 250)) ? 1 : 0;
	 assign Send8 = ((x > 320) & (y > 110) & (x < 390) & (y < 130)) ? 1 : 0;
	 assign Send9 = ((x > 380) & (y > 120) & (x < 390) & (y < 250)) ? 1 : 0;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	 
	
	//calling images to different states of the machine
	 //all images are VGA_G[3]
	 
	 always@(*)
	 begin
	 case(s)
	 //the first one is all of the images that are called while still in the start state
	 START: begin
					VGA_G[3] = sq_a | sq_b | sq_c | sq_d | sq_e | sq_f;  
			  end
//cont.
	 s2: begin
					VGA_G[3] = st2a | st2b | st2c | st2d | st2e | st2f | st2g | st2h | st2i | st2j  | st2k | st2l | st2m | st2n | st2o | st2p | st2q | st2r | st2s | st2t | st2u | st2v |st2w; 
        end
//cont.
	s3: begin
					VGA_G[3] = st3a | st3b | st3c | st3d | st3e | st3f | st3g | st3h | st3i | st3j | st3k | st3l | st3m | st3n | st3o | st3p | st3q | st3r | st3s | st3t | st3u  | st3v |st3w |st3x |st3y | st3A |st3B |st3C |st3D | st3E |st3F | st3G | st3H | st3I;
			end
//cont.
	s4: begin
					VGA_G[3] = st4a | st4b |st4c | st4d | st4e | st4f | st4g | st4h | st4aa | st4ba |st4ca | st4da | st4ea | st4fa | st4ga | st4ha | st4ab | st4bb |st4cb | st4db | st4eb | st4fb | st4gb | st4hb | st4ac | st4bc |st4cc | st4dc | st4ec | st4fc | st4gc | st4hc | st4ic | st4jc | st4kc | st4lc | st4mc ;
			end
//the final image is displayed stating you have disarmed the bomb
	END: begin
					VGA_G[3] = Send | Send1 | Send2 | Send3 | Send4 | Send5 | Send6 | Send7 | Send8 | Send9;
		  end	
	 endcase
	 end
	 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*beginning of the counter
in this the counter will count upwards but will act as a count 
down. once the counter reaches a certain limit(three minutes),
the counter will stop adding to itself. This prevents a infinite
loop causing the counter reset. Once the time limit is reached,
all of the red LED's will appear on the board, this is meaning the game is over. 
If this occurs before all of the green LED's illuminate, 
this shows that you have lost and the bomb has detonated.*/
 
always@(posedge CLK or negedge RST_BTN)
//reset switch and state
	begin
		if (RST_BTN == 1'b0)
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
				led6 <= 1'b0;
				led7 <= 1'b0;
				led8 <= 1'b0;
				led9 <= 1'b0;
			end
			
//-------------------------------------------------------------------
// This is the alternate counter running in the background as seconds
		else if(count <= 9'd180)
			begin
				altcount <= altcount + 26'd1;
				if (altcount == 26'd50_000_000)
					begin
						count = count + 9'd1;

//-----------------------------------------------------------------------
// This is the first red LED
							if(count >= 9'd36)
								begin
									led1 <= 1'b0;
								end
							else
								begin
									led1 <= 1'b1;
								end
								
//------------------------------------------------------------------------
// This is the second red LED
							if(count >= 9'd72)
								begin
									led2 <= 1'b0;
								end
							else
								begin
									led2 <= 1'b1;
								end
								
//------------------------------------------------------------------------
// THis is the third red LED
							if(count >= 9'd108)
								begin
									led3 <= 1'b0;
								end
							else
								begin
									led3 <= 1'b1;
								end
								
//-------------------------------------------------------------------------
// This is the fourth red LED
							if(count >= 9'd144)
								begin
									led4 <= 1'b0;
								end
							else
								begin
									led4 <= 1'b1;
								end
								
//------------------------------------------------------------------------
// This is the final check, all red LED's illuminate
							if(count >= 9'd180)
								begin
									led1 <= 1'b1;
									led2 <= 1'b1;
									led3 <= 1'b1;
									led4 <= 1'b1;
									led5 <= 1'b1;
									led6 <= 1'b1;
									led7 <= 1'b1;
									led8 <= 1'b1;
									led9 <= 1'b1;
								end
							else
//This is keeping the unused LED's off until counter reaches limit
								begin
									led5 <= 1'b1;
									led6 <= 1'b0;
									led7 <= 1'b0;
									led8 <= 1'b0;
									led9 <= 1'b0;
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

				end//end of seconds counter
				
//-------------------------------------------------------------------------- 

/* This is the bomb logic. here you can see the finite state machine. With it's requirments,
parameter state's, and the check button that is used to determine if your input is correct. */

//reset button and state
	 	always@ (posedge check or negedge RST_BTN)
	if (RST_BTN == 1'b0)
		begin
			s <= START;
			//used to help see you are in reset
			ledR <= 1'b1;
		end
	else 
		//no longer in reset, counter begins, first clue apprears (ledR turns off after you press the check key the first time)
		begin
			s <= ns;
		   ledR <= 1'b0;
		end
		
//-----------------------------------------------------------------------------
//these are the states and the inputs that must be held in order to move to the next state.
always@ (*)
	case(s)
START: if(in == 4'b0010)
		 begin
			ns = s2;
		end
		else begin 
			ns = START;
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
	
//--------------------------------------------------------------------------------------------------------------------------
/* This shows the output. these are represented by the green LED's.
Once you move to the next state from correct inputs, more LED's turn on.*/

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
//All Green LED's are on. if this is done before 0-8 red LED's illuminate, player wins
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
	
endmodule //end of module top