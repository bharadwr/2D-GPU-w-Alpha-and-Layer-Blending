module i2c_slave 
(
 input wire clk, input wire n_rst, input wire scl, input wire sda_in, input wire write_enable, input wire [7:0] write_data, output reg sda_out, output reg fifo_empty, output reg fifo_full
);
reg rising_edge_found, falling_edge_found, rw_mode, tx_out, load_data, tx_enable, rx_enable, address_match, ack_prep, check_ack, ack_done, read_enable, byte_received, start_found, stop_found;
reg [7:0]rx_data, read_data;
reg [1:0]sda_mode;
scl_edge SCL_EDGE_DUT
(
 .clk (clk), .n_rst (n_rst), .scl (scl), .rising_edge_found (rising_edge_found), .falling_edge_found(falling_edge_found)
);
decode DECODEDUT
(
 .clk (clk), .n_rst (n_rst), .scl (scl), .sda_in (sda_in), .starting_byte(rx_data), .rw_mode (rw_mode), .address_match(address_match), .stop_found (stop_found), .start_found (start_found)
);
tx_sr TX_SR_DUT
(
 .clk (clk), .n_rst (n_rst), .falling_edge_found(falling_edge_found), .tx_enable (tx_enable), .tx_data (read_data), .load_data (load_data), .tx_out (tx_out)
);
timer TIMER_DUT
(
 .clk (clk), .n_rst (n_rst), .rising_edge_found (rising_edge_found), .falling_edge_found(falling_edge_found), .stop_found (stop_found), .start_found (start_found), .byte_received (byte_received), .ack_prep (ack_prep), .check_ack (check_ack), .ack_done (ack_done)
);
controller CONTROLLER_DUT 
(
 .clk (clk), .n_rst (n_rst), .stop_found (stop_found), .start_found (start_found), .byte_received(byte_received), .ack_prep (ack_prep), .check_ack (check_ack), .ack_done (ack_done), .rw_mode (rw_mode), .address_match(address_match), .sda_in (sda_in), .rx_enable (rx_enable), .tx_enable (tx_enable), .read_enable (read_enable), .sda_mode (sda_mode), .load_data (load_data)
);
tx_fifo TX_FIFO_DUT
(
 .clk (clk), .n_rst (n_rst), .read_enable (read_enable), .write_enable(write_enable), .write_data (write_data), .read_data (read_data), .fifo_empty (fifo_empty), .fifo_full (fifo_full)
);
rx_sr RX_SR_DUT
(
 .clk (clk), .n_rst (n_rst), .sda_in (sda_in), .rising_edge_found(rising_edge_found), .rx_enable (rx_enable), .rx_data (rx_data)
);
sda_sel SDA_SEL_DUT
(
 .tx_out (tx_out), .sda_mode(sda_mode), .sda_out (sda_out)
);
endmodule
