// Clear block within the Render Module for the 2D GPU ECE 337 project Fall 2016.
// Joe Mynhier
// 18 Nov. 2016

module clear
(
	input clk,
	input n_rst,	
	input clear_enable,
	output logic clear_done,
	output logic [8:0] cx,
	output logic [7:0] cy
);

	logic rollover1;
	logic y_rollover;

	flex_counter #(9) Counter1 (.clk(clk), .n_rst(n_rst), .clear(clear_done), 
			.count_enable(clear_enable), .rollover_val(9'd320), 
			.count_out(cx), .rollover_flag(rollover1));

	flex_counter #(8) Counter2 (.clk(clk), .n_rst(n_rst), 
			.count_enable(rollover1 & clear_enable),
			.clear(y_rollover), .rollover_val(8'd241), 
			.count_out(cy), .rollover_flag(clear_done));

	// don't go out of bound on final rollover.	
	assign y_rollover = cy == 8'd240;

endmodule
