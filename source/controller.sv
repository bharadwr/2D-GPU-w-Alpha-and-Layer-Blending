// $Id: $
// File name:   controller.sv
// Created:     11/29/2016
// Author:      Pranav Gupta
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Controlller for Project

module controller
(
	input wire clk,
	input wire n_rst,
	input wire received_op,
	input wire render_done,
	output reg [31:0] status,
	output reg render_enable
);

	typedef enum logic [2:0] {IDLE, RENDER} state_name;

	state_name c_state, n_state;

	//state reg
	always_ff @ (posedge clk, negedge n_rst)
    	begin
    		if(!n_rst) 
        	begin 
           		c_state <= IDLE;
      		end
        	else
       		begin
            	c_state <= n_state;
        	end
    	end
	
	//next state logic and output logic
	always_comb
	begin
  	n_state = c_state; 
		render_enable = 1'b0;
		status = 32'h00000000;
		
 		case (c_state)
		IDLE:
		begin
			if(received_op == 1'b1)
				n_state = RENDER;
		end

		RENDER:
		begin
			render_enable = 1'b1;
			status = 32'h00000001;
			if(render_done == 1'b1)
			begin				
				n_state = IDLE;
			end		
		end
		endcase
	end

endmodule
