module scl_edge
(
	input wire clk,
	output reg falling_edge_found,
	input wire n_rst,
	input wire scl,
	output reg rising_edge_found
);
	reg reg1, reg2, reg3;
	always_ff @ (posedge clk, negedge n_rst) begin
	    	if(!n_rst) begin
			reg1 <= 1'b1;
	    		reg2 <= 1'b1;
	    		reg3 <= 1'b1;
	    	end
	    	else begin
		  	reg1 <= scl;
	    		reg2 <= reg1;
	    		reg3 <= reg2;
	    	end
	end
	assign rising_edge_found = (reg2 && (!reg3));
	assign falling_edge_found = ((!reg2) && reg3);
endmodule
