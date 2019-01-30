module bresenham
(
	input clk,
	input n_rst,
	input [8:0] start_x,
	input [7:0] start_y,
	input [8:0] end_x,
	input [7:0] end_y,
	input draw_enable,
	input set_new,
	output logic done,
	output logic [8:0] bx,
	output logic [7:0] by
);

	/***********************************************
	In order to handle |gradient| > 1, x and y 
	inputs and outputs must swap. 
	***********************************************/
	logic [8:0] start_x_local;
	logic [8:0] end_x_local;
	logic [8:0] start_y_local;
	logic [8:0] bx_local;
	logic [8:0] by_local;
	logic magnatude_gt_one;

	// Handle gradient < 0
	logic dx_lt_zero;
	logic dy_lt_zero;
	logic slope_lt_zero;

	// get slope
	logic [15:0] next_gradient;
	logic [15:0] gradient;
	logic [15:0] deltax;
	logic [15:0] deltay;

	/************************************************
	In order to handle the case 0 < |gradient| < 1
	detax and delta y are shifted such that if
	end_x - start_x_local = 9'b1, it is stored as
	16'h0080. This way, the gradient (and later err
	) are a sort of hacked fixed point value where
	[15:7] are [2^8:2^0] and [6:0] are [2^-1:2^-7].
	************************************************/
	assign dy_lt_zero = end_y < start_y ? '1 : '0;
	assign dx_lt_zero =  end_x < start_x ? '1 : '0;
	assign slope_lt_zero = dy_lt_zero ^ dx_lt_zero;
	assign deltax = dx_lt_zero == '0 ? end_x - start_x + 9'd1 : start_x - end_x + 9'd1;
	assign deltay = dy_lt_zero == '0 ? end_y - start_y + 8'd1 : start_y - end_y + 8'd1;
	assign magnatude_gt_one = deltay > deltax ? 1'b1 : 1'b0;
	assign next_gradient = magnatude_gt_one == 1'b0 ? (deltay << 7) / deltax : (deltax << 7) / deltay;

	// reroute inputs and outputs.
	always_comb
	begin

		if (magnatude_gt_one == 1'b0 && start_x <= end_x)
		begin   // |slope| < 1 and start to left of right
			start_x_local = start_x;
			end_x_local = end_x;
			start_y_local = {0, start_y};
		end else if (start_x <= end_x)
		begin   // |slope| > 1 and start to left of right
			// swap x and y.
			start_x_local = {0, start_y};
			end_x_local = {0, end_y};
			start_y_local = start_x;
		end else if (magnatude_gt_one == 1'b0)
		begin   // |slope| < 1 and start to right of end
			// swap start and end.
			start_x_local = end_x;
			end_x_local = start_x;
			start_y_local = {0, end_y};
		end else
		begin   // |slope| > 1 and start to right of end
			// swap x and y as well as start and end.
			start_x_local = {0, end_y};
			end_x_local = {0, start_y};
			start_y_local = end_x;
		end
	end
	always_comb
	begin
		if (magnatude_gt_one == 1'b0 && slope_lt_zero == 1'b0)
		begin
			bx = bx_local;
			by = by_local[7:0];
		end else if (magnatude_gt_one == 1'b1 && slope_lt_zero == 1'b0)
		begin
			bx = by_local;
			by = bx_local[7:0];
		end else if (magnatude_gt_one == 1'b0)
		begin
			bx = bx_local;
			by = start_y_local[7:0] - (by_local[7:0] - start_y_local[7:0]);
		end else
		begin
			bx = by_local;
			by = start_x_local[7:0] - (bx_local[7:0] - start_x_local[7:0]);
		end
	end

	// store gradient
	always_ff @ (posedge clk, negedge n_rst)
	begin
		if (n_rst == '0)
		begin
			gradient = 16'h00800;  // slope = 1
		end else
		begin
			gradient = next_gradient;
		end
	end

	logic [9:0] next_x;
	logic [9:0] next_y;
	logic enable_y;

	always_ff @ (posedge clk, negedge n_rst)
	begin
		if (n_rst == '0)
		begin
			bx_local = '0;
		end else
		begin
			bx_local = next_x[8:0];
		end
	end
	always_ff @ (posedge clk, negedge n_rst)
	begin
		if (n_rst == '0)
		begin
			by_local = '0;
		end else
		begin
			by_local = next_y[8:0];
		end
	end

	logic [9:0] inc_x;
	assign inc_x = bx_local + 1;

	// next x logic
	always_comb
	begin
		if (set_new == 1'b1)
		begin
			next_x = start_x_local;
		end else if (draw_enable == 1'b1)
		begin
			next_x = inc_x;
		end else
		begin
			next_x = {0,bx_local};
		end
	end

	logic [9:0] inc_y;
	assign inc_y = by_local + 1;

	// next y logic
	always_comb
	begin
		if (set_new == 1'b1)
		begin
			next_y = {0,start_y_local};
		end else if (enable_y == 1'b1 && draw_enable == 1'b1)
		begin
			next_y = inc_y;
		end else
		begin
			next_y = {0,by_local};
		end
	end

	logic [15:0] error;
	logic [15:0] next_error;
	always_ff @ (posedge clk, negedge n_rst)
	begin
		if (n_rst == '0)
		begin
			error = 16'h0000; 
		end else
		begin
			error = next_error;
		end
	end

	// next error logic
	always_comb
	begin
		if (set_new == 1'b1)
		begin
			next_error = gradient;  
 		end else if (error >= 16'h0080 && draw_enable == 1'b1)
		begin
			next_error = error - 16'h0080 + gradient;
		end else if (draw_enable == 1'b1)
		begin
			next_error = error + gradient;
		end else
		begin
			next_error = error;
		end
	end

	// y enable logic
	always_comb
	begin
		if (error >= 16'h0080)  // >= 1
		begin
			enable_y = 1'b1;
		end else
		begin
			enable_y = 1'b0;
		end
	end

	// done logic
	always_comb
	begin
		if ((bx_local == end_x_local) || (slope_lt_zero && magnatude_gt_one && (start_x_local - (bx_local - start_x_local) == end_x_local)))
		begin
			done = 1'b1;
		end else
		begin
			done = 1'b0;
		end
	end

endmodule
