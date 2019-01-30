// $Id: $
// File name:   flex_stp_sr.sv
// Created:     9/7/2017
// Author:      Rtvik Sriram Bharadwaj
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Flex Serial-to-Parallel file.

module flex_stp_sr
#(
	parameter NUM_BITS = 4,
	parameter SHIFT_MSB = 1
 )

(
 input wire clk, 
 input wire n_rst, 
 input wire  shift_enable, 
 input wire serial_in,
 output reg [NUM_BITS - 1:0] parallel_out

 );

reg [(NUM_BITS - 1):0] next_state;


always_comb begin

	if(shift_enable == 1'b1) begin

		if (SHIFT_MSB == 1) begin
			next_state = {parallel_out[NUM_BITS-2:0], serial_in};
		end
		else if (SHIFT_MSB == 0) begin
			next_state = {serial_in, parallel_out[NUM_BITS-1:1]};
		end	
	end

	else if (shift_enable == 1'b0) begin
		next_state = parallel_out;
	end
end

always_ff @ (posedge clk, negedge n_rst) begin
	
	if (n_rst == 0) begin
		parallel_out <= {NUM_BITS{1'b1}};
	end
	else if (n_rst == 1) begin
		parallel_out <= next_state;
	end
end



endmodule
