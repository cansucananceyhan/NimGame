`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Hamzeh Ahangari
// 
// Create Date: 
// Design Name: 
// Module Name: top
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

module top(
    input clk, //100Mhz on Basys3
	input rst,
	input dlp, drp, ilp, irp, changePlayer, newGame, resetST, row1, row2, row3, row4,
	//7-segment signals
	output a, b, c, d, e, f, g, dp, 
    output [3:0] an,	
	
	//step motor
	output [3:0] phases,
	
	// FPGA pins for 8x8 display
        output reset_out, //shift register's reset
        output OE,     //output enable, active low 
        output SH_CP,  //pulse to the shift register
        output ST_CP,  //pulse to store shift register
        output DS,     //shift register's serial input data
        output [7:0] col_select // active column, active high

    );
    
        logic direction;
        logic fsmClock;
        logic gameFinished;
        logic [1:0] speed = 2'b10;
        logic stop;
        logic [3:0] leftScore1 = 4'b0000; // Onlar
        logic [3:0] leftScore2 = 4'b0000; // Birler
        logic [3:0] rightScore1 = 4'b0000; // Onlar
        logic [3:0] rightScore2 = 4'b0000; // Birler
        logic noOfSticksR1 = 1;
                    logic [1:0]noOfSticksR2 = 2'b11;
                    logic [2:0]noOfSticksR3 = 3'b101;  
                    logic [2:0]noOfSticksR4 = 3'b111;
        logic [2:0] col_num;
        
        logic debounced_r1;
        logic debounced_r2;
        logic debounced_r3;
        logic debounced_r4;
        logic debounced_ilp;
        logic debounced_irp;
        logic debounced_dlp;
        logic debounced_drp;
        // initial value for RGB images:
        //    image_???[0]     : left column  .... image_???[7]     : right column
        //    image_???[?]'MSB : top line     .... image_???[?]'LSB : bottom line
         
        logic [7:0]red_vect_in;
        logic [7:0]green_vect_in;
        logic [7:0]blue_vect_in; 
        
                
        button_debounce d1r1(clk, , row1, debounced_r1);
        button_debounce d2r2(clk, , row2, debounced_r2);
        button_debounce d3r3(clk, , row3, debounced_r3);
        button_debounce d4r4(clk, , row4, debounced_r4);
        button_debounce ilpD(clk, , row1, debounced_ilp);
        button_debounce irpD(clk, , row1, debounced_irp);
        button_debounce dlpD(clk, , row1, debounced_dlp);
        button_debounce drpD(clk, , row1, debounced_drp);
        
        assign fsmClock = debounced_r1 | debounced_r2 | debounced_r3 | debounced_r4;
        score_table st_l( {leftScore1,leftScore2}, debounced_ilp, debounced_dlp, {leftScore1,leftScore2});
        score_table st_r( {rightScore1,rightScore2}, debounced_irp, debounced_drp, {rightScore1,rightScore2});
        
        game_fsm fsm (fsmClock, newGame, changePlayer, row1, row2, row3, row4, noOfSticksR1, noOfSticksR2, noOfSticksR3, noOfSticksR4, direction, gameFinished, noOfSticksR1, noOfSticksR2, noOfSticksR3, noOfSticksR4);
        get_vectors vectors (noOfSticksR1, noOfSticksR2, noOfSticksR3, noOfSticksR4, gameFinished, red_vect_in, green_vect_in, blue_vect_in);
        stepmotor stepmotor (clk, direction, speed, phases, stop );
        SevSeg_4digit sevSeg (clk, leftScore1, leftScore2, rightScore1,  rightScore2, a, b , c , d, e , f , g , dp, an );
        display_8x8 display_8x8 (clk, red_vect_in, green_vect_in, blue_vect_in, , col_num, reset_out, OE, SH_CP, ST_CP, DS, col_select);
        
endmodule

//----------------------------FSM----------------------------
module game_fsm (
    input clk, //100Mhz on Basys3
	input reset,
	input logic changePlayer, row1, row2, row3, row4,
	input logic noOfSticksR1, 
	input logic [1:0]noOfSticksR2,  
	input logic [2:0]noOfSticksR3,  
	input logic [2:0]noOfSticksR4,
	//7-segment signals
	output logic direction, gameFinished, 
	output logic newNoOfSticksR1, 
	output logic [1:0]newNoOfSticksR2, 
	output logic [2:0]newNoOfSticksR3,  
	output logic [2:0]newNoOfSticksR4
);
    typedef enum logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10} statetype;
    statetype [3:0] state, nextState;
    
    //State register
    always_ff @ (posedge clk, posedge reset)
        if(reset) state <= S0;
        else   begin   
            state <= nextState;
            newNoOfSticksR1 <= noOfSticksR1;
            newNoOfSticksR2 <= noOfSticksR2;
            newNoOfSticksR3 <= noOfSticksR3;
            newNoOfSticksR4 <= noOfSticksR4;
        end
        
    //Next state logic
    always_comb
        case(state)
   S0: 
       if(row1 == 1) 
            begin
                  newNoOfSticksR1--;
            nextState <= S1;
            end
       else if(row2 == 1) 
       begin
                      newNoOfSticksR2--;
            nextState <= S2;
            end
       else if(row3 == 1) 
       begin
                      newNoOfSticksR3--;
            nextState <= S3;
            end
       else if(row4 == 1) 
       begin
                      newNoOfSticksR4--;
            nextState <= S4;
            end
   S1: if(row1 == 1 && noOfSticksR1 == 1 && noOfSticksR2 == 0 && noOfSticksR3 == 0 && noOfSticksR4 == 0) 
                        begin
                           newNoOfSticksR1--;
                           nextState <= S10;
                      end
                   else if(  row1==1 && newNoOfSticksR1 == 1)
                   begin
                        newNoOfSticksR1--;
                        nextState <= S5;
                   end
   S2: if(row2 == 1 && noOfSticksR1 == 0 && noOfSticksR2 == 1 && noOfSticksR3 == 0 && noOfSticksR4 == 0) 
            begin
               newNoOfSticksR2--;
               nextState <= S10;
          end
       else if( row2 == 1 && newNoOfSticksR2 > 1 )
       begin
            newNoOfSticksR2--;
            nextState <= S2;
       end
       else if(  row2==1 && newNoOfSticksR2 == 1)
       begin
            newNoOfSticksR2--;
            nextState <= S5;
       end
       else if(changePlayer == 1)
            nextState <= S5;
   S3: if(row3 == 1 && noOfSticksR1 == 0 && noOfSticksR2 == 0 && noOfSticksR3 == 1 && noOfSticksR4 == 0) 
                        begin
                           newNoOfSticksR3--;
                           nextState <= S10;
                      end
                   else if( row3 == 1 && newNoOfSticksR3 > 1 )
                   begin
                        newNoOfSticksR3--;
                        nextState <= S3;
                   end
                   else if(  row3==1 && newNoOfSticksR3 == 1)
                   begin
                        newNoOfSticksR3--;
                        nextState <= S5;
                   end
                   else if(changePlayer == 1)
                        nextState <= S5;
   S4:  if(row4 == 1 && noOfSticksR1 == 0 && noOfSticksR2 == 0 && noOfSticksR3 == 0 && noOfSticksR4 == 1) 
                                   begin
                                      newNoOfSticksR4--;
                                      nextState <= S10;
                                 end
                              else if( row4 == 1 && newNoOfSticksR4 > 1 )
                              begin
                                   newNoOfSticksR4--;
                                   nextState <= S4;
                              end
                              else if(  row4==1 && newNoOfSticksR4 == 1)
                              begin
                                   newNoOfSticksR4--;
                                   nextState <= S5;
                              end
                              else if(changePlayer == 1)
                                   nextState <= S5;
   
   S5: if(row1 == 1) 
                                               begin
                                                     newNoOfSticksR1--;
                                               nextState <= S6;
                                               end
                                          else if(row2 == 1) 
                                          begin
                                                         newNoOfSticksR2--;
                                               nextState <= S7;
                                               end
                                          else if(row3 == 1) 
                                          begin
                                                         newNoOfSticksR3--;
                                               nextState <= S8;
                                               end
                                          else if(row4 == 1) 
                                          begin
                                                         newNoOfSticksR4--;
                                               nextState <= S9;
                                               end
                                      S6: if(row1 == 1 && noOfSticksR1 == 1 && noOfSticksR2 == 0 && noOfSticksR3 == 0 && noOfSticksR4 == 0) 
                                                           begin
                                                              newNoOfSticksR1--;
                                                              nextState <= S10;
                                                         end
                                                      else if(  row1==1 && newNoOfSticksR1 == 1)
                                                      begin
                                                           newNoOfSticksR1--;
                                                           nextState <= S0;
                                                      end
                                      S7: if(row2 == 1 && noOfSticksR1 == 0 && noOfSticksR2 == 1 && noOfSticksR3 == 0 && noOfSticksR4 == 0) 
                                               begin
                                                  newNoOfSticksR2--;
                                                  nextState <= S10;
                                             end
                                          else if( row2 == 1 && newNoOfSticksR2 > 1 )
                                          begin
                                               newNoOfSticksR2--;
                                               nextState <= S7;
                                          end
                                          else if(  row2==1 && newNoOfSticksR2 == 1)
                                          begin
                                               newNoOfSticksR2--;
                                               nextState <= S0;
                                          end
                                          else if(changePlayer == 1)
                                               nextState <= S0;
                                      S8: if(row3 == 1 && noOfSticksR1 == 0 && noOfSticksR2 == 0 && noOfSticksR3 == 1 && noOfSticksR4 == 0) 
                                                           begin
                                                              newNoOfSticksR3--;
                                                              nextState <= S10;
                                                         end
                                                      else if( row3 == 1 && newNoOfSticksR3 > 1 )
                                                      begin
                                                           newNoOfSticksR3--;
                                                           nextState <= S8;
                                                      end
                                                      else if(  row3==1 && newNoOfSticksR3 == 1)
                                                      begin
                                                           newNoOfSticksR3--;
                                                           nextState <= S0;
                                                      end
                                                      else if(changePlayer == 1)
                                                           nextState <= S0;
                                      S9:  if(row4 == 1 && noOfSticksR1 == 0 && noOfSticksR2 == 0 && noOfSticksR3 == 0 && noOfSticksR4 == 1) 
                                                                      begin
                                                                         newNoOfSticksR4--;
                                                                         nextState <= S10;
                                                                    end
                                                                 else if( row4 == 1 && newNoOfSticksR4 > 1 )
                                                                 begin
                                                                      newNoOfSticksR4--;
                                                                      nextState <= S9;
                                                                 end
                                                                 else if(  row4==1 && newNoOfSticksR4 == 1)
                                                                 begin
                                                                      newNoOfSticksR4--;
                                                                      nextState <= S0;
                                                                 end
                                                                 else if(changePlayer == 1)
                                                                      nextState <= S0;
                                      
                                      
   S10: if(reset) 
   begin
            nextState <= S0;
            gameFinished = 0;
            noOfSticksR1 = 1;
            noOfSticksR2 = 2'b11;
            noOfSticksR3 = 3'b101;  
            noOfSticksR4 = 3'b111;
            end
        else
            gameFinished = 1;
   
   endcase
            
            //Output logic
            always_comb
                case(state) // DIRECTION ?????
                S0 :  direction = 0;
                S1 :  direction = 0;
                S2 :  direction = 0;
                S3 :  direction = 0;// else q = 16'b0000000000000000;
                S4 :  direction = 0; //else q = 16'b0011100111000110;
                S5 :  direction = 1; //else q = 16'b0011100111000110;
                S6 :  direction = 1; //else q = 16'b0011100111000110;
                S7 :  direction = 1; //else q = 16'b0011100111000110;
                S8 :  direction = 1; //else q = 16'b0011100111000110;
                S9 :  direction = 1; //else q = 16'b0011100111000110;
                S10:  direction = 0; //else q = 16'b0011100111000110;
                
                endcase
    
endmodule

//--------------------DEBOUNCER---------------------------
module button_debounce
  (
   input      clk,     // clock
   input      reset_n, // asynchronous reset 
   input      button,  // bouncy button
   output reg debounce // debounced 1-cycle signal
   );
  
  parameter
    CLK_FREQUENCY  = 66000000,
    DEBOUNCE_HZ    = 2;
  // These parameters are specified such that you can choose any power
  // of 2 frequency for a debouncer between 1 Hz and
  // CLK_FREQUENCY. Note, that this will throw errors if you choose a
  // non power of 2 frequency (i.e. count_value evaluates to some
  // number / 3 which isn't interpreted as a logical right shift). I'm
  // assuming this will not work for DEBOUNCE_HZ values less than 1,
  // however, I'm uncertain of the value of a debouncer for fractional
  // hertz button presses.
  localparam
    COUNT_VALUE  = CLK_FREQUENCY / DEBOUNCE_HZ,
    WAIT         = 0,
    FIRE         = 1,
    COUNT        = 2;

  reg [1:0]   state, next_state;
  reg [25:0]  count;
  
  always @ (posedge clk or negedge reset_n)
    state <= (!reset_n) ? WAIT : next_state;

  always @ (posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      debounce <= 0;
      count    <= 0;
    end
    else begin
      debounce <= 0;
      count    <= 0;
      case (state)
        WAIT: begin
        end
        FIRE: begin
          debounce <= 1;
        end
        COUNT: begin
          count <= count + 1;
        end
      endcase 
    end
  end

  always @ * begin
    case (state)
      WAIT:    next_state = (button)                  ? FIRE : state;
      FIRE:    next_state = COUNT;
      COUNT:   next_state = (count > COUNT_VALUE - 1) ? WAIT : state;
      default: next_state = WAIT;
    endcase
  end

endmodule

//--------------------VECTORS-------------------------
module get_vectors(input logic noOfSticksR1, 
	input logic [1:0]noOfSticksR2,  
	input logic [2:0]noOfSticksR3,  
	input logic [2:0]noOfSticksR4,
	input logic gameFinished,

output logic [7:0]red_vect_in, 
output logic [7:0]green_vect_in, 
output logic [7:0]blue_vect_in 
);

    assign red_vect_in = {8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
    assign green_vect_in = {8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
    assign blue_vect_in = {8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
    
    //blue_row4
    assign blue_vect_in[0] = noOfSticksR4 >= 1 ? (blue_vect_in[0] | 8'b00000011) : blue_vect_in[0]; 
    assign blue_vect_in[1] = noOfSticksR4 >= 2 ? (blue_vect_in[1] | 8'b00000011) : blue_vect_in[1];
    assign blue_vect_in[2] = noOfSticksR4 >= 3 ? (blue_vect_in[2] | 8'b00000011) : blue_vect_in[2];
    assign blue_vect_in[3] = noOfSticksR4 >= 4 ? (blue_vect_in[3] | 8'b00000011) : blue_vect_in[3];
    assign blue_vect_in[4] = noOfSticksR4 >= 5 ? (blue_vect_in[4] | 8'b00000011) : blue_vect_in[4];
    assign blue_vect_in[5] = noOfSticksR4 >= 6 ? (blue_vect_in[5] | 8'b00000011) : blue_vect_in[5];
    assign blue_vect_in[6] = noOfSticksR4 >= 7 ? (blue_vect_in[6] | 8'b00000011) : blue_vect_in[6];
               
    //red_row3
    assign red_vect_in[0] = noOfSticksR3 >= 1 ? (red_vect_in[0] | 8'b00001100) : red_vect_in[0];
    assign red_vect_in[1] = noOfSticksR3 >= 2 ? (red_vect_in[1] | 8'b00001100) : red_vect_in[1];
    assign red_vect_in[2] = noOfSticksR3 >= 3 ? (red_vect_in[2] | 8'b00001100) : red_vect_in[2];
    assign red_vect_in[3] = noOfSticksR3 >= 4 ? (red_vect_in[3] | 8'b00001100) : red_vect_in[3];
    assign red_vect_in[4] = noOfSticksR3 >= 5 ? (red_vect_in[4] | 8'b00001100) : red_vect_in[4];
                     
    //blue_row2       
    assign blue_vect_in[0] = noOfSticksR2 >= 1 ? (blue_vect_in[0] | 8'b00110000) : blue_vect_in[0]; 
    assign blue_vect_in[1] = noOfSticksR2 >= 2 ? (blue_vect_in[1] | 8'b00110000) : blue_vect_in[1];
    assign blue_vect_in[2] = noOfSticksR2 >= 3 ? (blue_vect_in[2] | 8'b00110000) : blue_vect_in[2];          
    
    //red_row1
    assign red_vect_in[0] = noOfSticksR1 >= 1 ? (red_vect_in[0] | 8'b11000000) : red_vect_in[0];
        
endmodule

//-----------------SCORE_TABLE---------------------------
module score_table(
                   input logic clk,
                   input logic [7:0]score, 
                   input logic inc, dec,
                   output logic [7:0]newScore
                   );
    always_ff @(posedge clk)
    begin
        if(inc == 1)
            newScore[3:0] = score[3:0] + 1;
        if(dec == 1)
            newScore[3:0] = score[3:0] - 1;
        if(newScore[3:0] == 4'b1111)
            begin
                newScore[3:0] = 4'b1001;
                newScore[7:4] = newScore[7:4] - 1;
            end
        else if(newScore[3:0] == 4'b1010)
            begin
                newScore[3:0] = 4'b0000;
                newScore[7:4] = newScore[7:4] + 1;
            end

       if(newScore[7:4] == 4'b1111)
            newScore[7:4] = 4'b0000;
       else if(newScore[7:4] == 4'b1010)
            newScore[7:4] = 4'b0000;
    end            
       
       
endmodule