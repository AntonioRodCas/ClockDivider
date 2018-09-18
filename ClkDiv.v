 /*********************************************************
 * Description:
 * This module is a Synchronized parameterizable frequency divider
 * 	Parameters:
 *			FREQUENCY:			Target frequency
 *			REFERENCE_CLOCK:	Reference clock signal frequency
 *			NBITS:				Number of bits of the main counter
 *			COUNT:				Counter value calculate at compilation time with input parameters
 * 	Inputs:
 *			clk_in:  Reference clock
 *			reset: 	Reset input signal
 *		Outputs:
 *			clk_out:	Output clock
 *
 *	Author:  Antonio Rodríguez    md193781   ITESO 
 *	Date:    15/09/18
 *
 **********************************************************/
module ClkDiv
#(
	// Parameter Declarations
	parameter FREQUENCY = 150_000,
	parameter REFERENCE_CLOCK = 50_000_000,
	parameter NBITS = 32,
	parameter COUNT = Counter_cal(FREQUENCY,REFERENCE_CLOCK)
)

(
	// Input Ports
	input clk_in,
	input reset,
	
	//Output Ports
	output reg clk_out

);


reg [NBITS-1 : 0] counter_reg;

	always@(posedge clk_in or negedge reset) begin
		if (reset == 1'b0) begin
			counter_reg <= {NBITS{1'b0}};
			clk_out <= 0;
		end
		else begin
			if (counter_reg < (COUNT-1))
				counter_reg <= counter_reg + 1;
			else begin
				counter_reg <= 0;
				clk_out <= ~clk_out;
			end
		end
			
	end


//----------------------------------------------------------
   
 /*Counter calculation Function*/
     function integer Counter_cal;
       input integer FREQUENCY, REFERENCE_CLOCK;
		 Counter_cal = REFERENCE_CLOCK / (2 * FREQUENCY);
    endfunction

//-----------------------------------------------------------

endmodule