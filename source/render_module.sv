// Render Module for the 2D GPU project in ECE 337 Fall 2016
// Joe Mynhier
// 18 November 2016

module render_module
(
	input clk,
	input n_rst,
	input [16:0] start_l,
	input [16:0] end_l,
	input [2:0] op,
	input render_enable,
	output logic [8:0] x,
	output logic [7:0] y,
	output logic enable,
	output logic render_done
);
	logic clear_done;  // Clear block pulses this when it finishes. RCU takes it as input.
	logic clear_enable; // This input to clear causes it to output new locations each cycle it's asserted. Output by RCU.
	logic line_draw_out;  // RCU outputs this signal to multiplex between the x, y outputs of clear and Bresenham.
	logic done;  // Bresenham block pulses this when it finishes. RCU takes it as input.
	logic set_new;  // Render initializes Bresenham.	
	logic draw_enable;  // This input to Bresenahm causes it to calculate a new location each cycle it's asserted.
			    // Output by RCU.
	logic [8:0] bx;  // location outputs of Bresenham block.
	logic [7:0] by;
	logic [8:0] cx;  // location outputs of Clear block.
	logic [7:0] cy;

	render_rcu R (.clk(clk), .n_rst(n_rst), .render_enable(render_enable), 
			.clear_done(clear_done), .done(done), .op(op), 
			.draw_enable(draw_enable), .enable(enable), .set_new(set_new),
			.render_done(render_done), .line_draw_out(line_draw_out), 
			.clear_enable(clear_enable));

	bresenham B (.clk(clk), .n_rst(n_rst), .start_x(start_l[16:8]), 
			.start_y(start_l[7:0]), .end_x(end_l[16:8]), 
			.end_y(end_l[7:0]), .draw_enable(draw_enable), 
			.set_new(set_new), .done(done), .bx(bx), .by(by));

	clear C (.clk(clk), .n_rst(n_rst), .clear_enable(clear_enable), 
			.clear_done(clear_done), .cx(cx), .cy(cy));

	// multiplex between the output of Clear and Bresenham.
	assign x = (line_draw_out == '1) ? bx : cx;
	assign y = (line_draw_out == '1) ? by : cy;

endmodule
