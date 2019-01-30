module decode
(
	output wire stop_found,
	input wire clk,
	input wire n_rst,
	output wire rw_mode,
	output wire address_match,
	input wire scl,
	output wire start_found,
	input wire sda_in,
	input wire [7:0] starting_byte
);
reg sda1, sda2, scl1, scl2;
always_ff @ (posedge clk, negedge n_rst) begin
 	if(!n_rst) begin
		scl1 <= scl;
	  	scl2 <= scl;
	    	sda1 <= 1'b1;
	    	sda2 <= 1'b1;
    	end
    	else begin
	   	sda1 <= sda_in;
	    	sda2 <= sda1;
	    	scl1 <= scl;
	    	scl2 <= scl1;
    	end
end
assign rw_mode = starting_byte[0];
assign address_match = (starting_byte[7:1] == 7'b1111000);
assign start_found = ((sda2) && (scl2) && (!sda1) && (scl1));
assign stop_found = ((!sda2) && (scl2) && (sda1) && (scl1));
endmodule
