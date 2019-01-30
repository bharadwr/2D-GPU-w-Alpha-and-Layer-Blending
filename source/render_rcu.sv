module render_rcu
(
	input clk,
	input n_rst,
	input render_enable,
	input clear_done,
	input done,
	input [2:0] op,
	output logic draw_enable,
	output logic enable,
	output logic render_done,
	output logic line_draw_out,
	output logic set_new,
	output logic clear_enable
);

	typedef enum bit [3:0] { WAIT, NEXT_INIT, NEXT, SEND, SWAIT1, 
				 SWAIT2, CLRNEXT, CLRSEND, CWAIT1, 
			         CWAIT2, HOLD, END} state_type;

	// DEBUG
	localparam OP_CLEAR = '0;

	state_type state;
	state_type next_state;

	always_ff @ (posedge clk, negedge n_rst)
	begin
		if (n_rst == '0)
		begin
			state = WAIT;
		end else
		begin
			state = next_state;
		end
	end

	// Next state logic
	always_comb
	begin
		next_state = WAIT;
		case (state)
		WAIT:
		begin
			if (render_enable == 1'b0)
			begin
				next_state = WAIT;
			end else if (op != OP_CLEAR)
			begin
				next_state = NEXT_INIT;
			end else
			begin
				next_state = CLRSEND;
			end
		end
		NEXT_INIT:
		begin
			next_state = SEND;
		end
		NEXT:
		begin
			next_state = SEND;
		end
		SEND:
		begin
			next_state = SWAIT1;
		end
		SWAIT1:
		begin
			next_state = SWAIT2;
		end
		SWAIT2:
		begin
			if (done == 1'b1)
			begin
				next_state = END;
			end else 
			begin
				next_state = NEXT;
			end
		end
		END:
		begin
			next_state = HOLD;
		end
		HOLD:
		begin
			next_state = WAIT;
		end
		CLRSEND:
		begin
			next_state = CLRNEXT;
		end
		CLRNEXT:
		begin
			next_state = CWAIT1;
		end
		CWAIT1:
		begin
			if (clear_done == '1)
			begin
				next_state = END;
			end else
			begin
				next_state = CWAIT2;
			end
		end
		CWAIT2:
		begin
			next_state = CLRSEND;
		end
		endcase
	end

	// output logic
	logic next_render_done;
	always_comb
	begin
		draw_enable = 1'b0;
		enable = 1'b0;
		next_render_done = 1'b0;
		line_draw_out = 1'b0;
		clear_enable = 1'b0;
		set_new = 1'b0;
		case (state)
		NEXT_INIT:
		begin
			draw_enable = 1'b1;
			line_draw_out = 1'b1;
			set_new = 1'b1;
		end
		NEXT:
		begin
			draw_enable = 1'b1;
			line_draw_out = 1'b1;
		end
		SEND:
		begin
			enable = 1'b1;
			line_draw_out = 1'b1;
		end
		SWAIT1:
		begin
			line_draw_out = 1'b1;
		end
		SWAIT2:
		begin
			line_draw_out = 1'b1;
		end
		END:
		begin
			next_render_done = 1'b1;
		end
		CLRSEND:
		begin
			enable = 1'b1;
		end
		CLRNEXT:
		begin
			clear_enable = 1'b1;
		end
		endcase
	end

	always_ff @ (posedge clk, negedge n_rst)
	begin
		if (n_rst == 1'b0)
		begin
			render_done = '0;
		end else
		begin
			render_done = next_render_done;
		end
	end

endmodule
