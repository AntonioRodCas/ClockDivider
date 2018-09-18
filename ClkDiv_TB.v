 /*********************************************************
 * Description:
 * This module is test bench file for testing the binary to BCD converter
 *
 *
 *	Author:  Antonio Rodríguez    md193781   ITESO 
 *	Date:    13/09/18
 *
 **********************************************************/ 
 
 
 
module ClkDiv_TB;

parameter NBITS = 32;
parameter FREQUENCY = 1;
parameter REFERENCE_CLOCK = 20;


reg clk_in_tb = 0;
reg reset_tb;

wire clk_out_tb;



ClkDiv
#(
	.FREQUENCY(FREQUENCY),
	.REFERENCE_CLOCK(REFERENCE_CLOCK),
	.NBITS(NBITS)
)
DUV
(
	.clk_in(clk_in_tb),
	.reset(reset_tb),

	.clk_out(clk_out_tb)

);

/*********************************************************/
initial // Clock generator
  begin
    forever #2 clk_in_tb = !clk_in_tb;
  end
/*********************************************************/
initial begin // reset generator
   #0 reset_tb = 0;
   #5 reset_tb = 1;
end



endmodule