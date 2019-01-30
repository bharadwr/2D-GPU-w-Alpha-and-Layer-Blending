module controller 
(
		input wire clk, input wire n_rst, input wire stop_found, input wire start_found, input wire byte_received, input wire ack_prep, input wire check_ack, input wire ack_done, input wire rw_mode, input wire address_match, input wire sda_in,
		output reg rx_enable, output reg tx_enable, output reg read_enable, output reg [1:0] sda_mode, output reg load_data
);
typedef enum logic [3:0] 
{
	idle_state, start_received_state, check_rw_addr_state, ack_send, nack_send, load_data_state, send_byte_state, ack_check, incr_pntr_state, ack_received, nack_received, check_done_state
} StateType;
StateType CurrentState, NextState;
always_ff @ (posedge clk, negedge n_rst) begin
	if(!n_rst) begin
		CurrentState <= idle_state;
	end
	else begin
		CurrentState <= NextState;
	end
end
always_comb begin
	NextState = CurrentState;
	rx_enable = 1'b0;
	tx_enable = 1'b0;
	read_enable = 1'b0;
	sda_mode = 2'b00;
	load_data = 1'b0;
	case(CurrentState) 
		idle_state: begin
			if(start_found) begin
				NextState = start_received_state;
			end
			else begin
				NextState = idle_state;
			end
			rx_enable = 1'b0;
			tx_enable = 1'b0;
			read_enable = 1'b0;
			sda_mode = 2'b00;
			load_data = 1'b0;
		end
		start_received_state: begin
			if(byte_received) begin
				NextState = check_rw_addr_state;
			end
			else begin
				NextState = start_received_state;
			end
			rx_enable = 1'b1;
			tx_enable = 1'b0;
			read_enable = 1'b0;
			sda_mode = 2'b00;
			load_data = 1'b0;
		end
		load_data_state: begin
			NextState = send_byte_state;
			rx_enable = 1'b0;
			tx_enable = 1'b0;
			read_enable = 1'b0;
			sda_mode = 2'b00;
			load_data = 1'b1;
		end
		send_byte_state: begin
			if(ack_prep) begin
				NextState = ack_check;
			end
			else begin
				NextState = send_byte_state;
			end
			rx_enable = 1'b0;
			tx_enable = 1'b1;
			read_enable = 1'b0;
			sda_mode = 2'b11;
			load_data = 1'b0;
		end
		check_rw_addr_state: begin
			if(rw_mode & address_match) begin
				NextState = ack_send;
			end
			else begin 
				NextState = nack_send;
			end
			rx_enable = 1'b0;
			tx_enable = 1'b0;
			read_enable = 1'b0;
			sda_mode = 2'b00;
			load_data = 1'b0;
		end
		nack_send: begin
			if(ack_done) begin
				NextState = idle_state;
			end
			else begin
				NextState = nack_send;
			end
			rx_enable = 1'b0;
			tx_enable = 1'b0;
			read_enable = 1'b0;
			sda_mode = 2'b10;
			load_data = 1'b0;
		end
		ack_send: begin
			if(ack_done) begin
				NextState = load_data_state;
			end
			else begin
				NextState = ack_send;
			end
			rx_enable = 1'b0;
			tx_enable = 1'b0;
			read_enable = 1'b0;
			sda_mode = 2'b01;
			load_data = 1'b0;
		end
		incr_pntr_state: begin        
			NextState = ack_received;
			rx_enable = 1'b0;
			tx_enable = 1'b0;
			read_enable = 1'b1;
			sda_mode = 2'b00;
			load_data = 1'b0;
		end
		ack_received: begin
			if(ack_done) begin
				NextState = load_data_state;
			end			
			else begin
				NextState = ack_received;
			end
			rx_enable = 1'b0;
			tx_enable = 1'b0;
			read_enable = 1'b0;
			sda_mode = 2'b00;
			load_data = 1'b0;
		end
		nack_received: begin
			if(ack_done) begin
				NextState = check_done_state;
			end
			else begin
				NextState = nack_received;
			end
			rx_enable = 1'b0;
			tx_enable = 1'b0;
			read_enable = 1'b0;
			sda_mode = 2'b00;
			load_data = 1'b0;
		end
		ack_check: begin
			if(check_ack & sda_in) begin
				NextState = nack_received;
			end
			else if(!sda_in & check_ack) begin
				NextState = incr_pntr_state;
			end
			else begin
				NextState = ack_check;
			end
			rx_enable = 1'b0;
			tx_enable = 1'b0;
			read_enable = 1'b0;
			sda_mode = 2'b00;
			load_data = 1'b0;
		end
		check_done_state: begin
			if(stop_found) begin
				NextState = idle_state;
			end
			else if(start_found) begin
				NextState = start_received_state;
			end
			else begin
				NextState = check_done_state;
			end
			rx_enable = 1'b0;
			tx_enable = 1'b0;
			read_enable = 1'b0;
			sda_mode = 2'b00;
			load_data = 1'b0;	
		end
	endcase
end
endmodule
