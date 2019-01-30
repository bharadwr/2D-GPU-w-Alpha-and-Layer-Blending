// $Id: $
// File name:   flex_counter.sv
// Created:     9/7/2017
// Author:      Rtvik Sriram Bharadwaj
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: flex counter file.

module flex_counter
#(
		NUM_CNT_BITS = 4
)
(
 input wire clk,
 input wire n_rst,
 output wire rollover_flag,
 input wire clear,
 input wire count_enable,
 input wire [NUM_CNT_BITS-1:0] rollover_val,
 output wire [NUM_CNT_BITS-1:0] count_out
);
reg [NUM_CNT_BITS-1:0] current;
reg [NUM_CNT_BITS-1:0] next;
reg current_flag;
reg next_flag;

always_ff @ (posedge clk, negedge n_rst) begin
	if( n_rst == 0) begin
		current <= '0;
		current_flag <= '0;     
	end
	else begin
		current <= next;
		current_flag <= next_flag;
	end
end

always_comb  begin    
	if(clear == 1) begin
		next = '0;
		next_flag = '0;
	end
	else begin 
		if(count_enable == 1) begin      
			next = current + 1;
			next_flag = 1'b0;
			if(next== (rollover_val + 1)) begin
				next= 1;
			end
			if(next == rollover_val)
				next_flag = 1'b1;
			end
		else begin
			next_flag = 1'b0;
			next = current;
		end     
	end
end

assign count_out = current;
assign rollover_flag = current_flag;

endmodule
