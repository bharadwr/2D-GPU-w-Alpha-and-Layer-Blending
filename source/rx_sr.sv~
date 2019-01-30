module rx_sr
(
	input wire clk, input wire n_rst, input wire sda_in, input wire rising_edge_found, input wire rx_enable,
	output wire [7:0] rx_data
);
logic shift_enable;
assign shift_enable = (rx_enable & rising_edge_found);
flex_stp_sr # (8,1) DUT
(
	.clk (clk), .n_rst (n_rst), .shift_enable(shift_enable), .serial_in (sda_in), .parallel_out(rx_data)
);
endmodule
