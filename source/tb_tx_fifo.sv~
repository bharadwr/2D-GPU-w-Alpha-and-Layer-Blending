`timescale 1ns / 100ps
module tb_tx_fifo ();
localparam CLK_PERIOD = 10;
localparam CHECK_DELAY = 3;
localparam NUM_CNT_BITS = 4;
reg [7:0] tb_write, tb_read;
reg Clk, N_rst, r_enable, w_enable, fifo_emp, fifo_ful;
tx_fifo DUT
( 
	.fifo_empty(fifo_emp),
	.clk(Clk),
	.n_rst(N_rst),
	.read_enable(r_enable),
	.write_enable(w_enable),
	.write_data(tb_write),
	.read_data(tb_read),
	.fifo_full(fifo_ful)
);
	always begin
		Clk = 1'b0;
		#(CLK_PERIOD/2.0);
		Clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end 
	integer i = 0;
    	initial begin
		//CASE1
		#CHECK_DELAY
		N_rst = 0;
		#CHECK_DELAY
		N_rst = 1;
		#CHECK_DELAY
		tb_write = 8'b00001111;
		#CHECK_DELAY
		w_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		w_enable = 1'b0; 
		#CHECK_DELAY 
		assert (8'b00001111 == tb_read) 
			$info(" PASS: CASE 1"); 
		else 
			$error(" FAIL: CASE 1");  

		//CASE2 
		#CHECK_DELAY
		N_rst = 0;
		N_rst = 1;
		N_rst = 0;
		#CHECK_DELAY
		N_rst = 1;
		N_rst = 0;
		N_rst = 1;
		#CHECK_DELAY 
		tb_write = 8'b00001111;
		tb_write = 8'b00001110;
		tb_write = 8'b00001111;
		#CHECK_DELAY
		w_enable = 1'b1;
		w_enable = 1'b0;
		w_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		w_enable = 1'b0;
		w_enable = 1'b1;
		w_enable = 1'b0;
		#CHECK_DELAY 
		tb_write = 8'b11110000;
		tb_write = 8'b11110001;
		tb_write = 8'b11110000;
		#CHECK_DELAY
		w_enable = 1'b1;
		w_enable = 1'b0;
		w_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		w_enable = 1'b0;
		w_enable = 1'b1;
		w_enable = 1'b0;
		#CHECK_DELAY 
		r_enable = 1'b1;
		r_enable = 1'b0;
		r_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		r_enable = 1'b0;
		r_enable = 1'b1;
		r_enable = 1'b0;
		#CHECK_DELAY
		r_enable = 1'b1;
		r_enable = 1'b0;
		r_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		r_enable = 1'b0;
		r_enable = 1'b1;
		r_enable = 1'b0;
		#CHECK_DELAY  
		for(i = 0; i < 3; i++) begin 
			@(posedge Clk); 
		end
		assert (8'b11110000 == tb_read) 
		    	$info(" PASS: CASE 2"); 
		else 
		    	$error(" FAIL: CASE 2"); 


		//CASE3
		#CHECK_DELAY
		N_rst = 0;
		#CHECK_DELAY
		N_rst = 1;
		#CHECK_DELAY 
		tb_write = 8'b00001111;
		#CHECK_DELAY
		w_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		w_enable = 1'b0;
		#CHECK_DELAY 
		tb_write = 8'b11110000;
		#CHECK_DELAY
		w_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		w_enable = 1'b0;
		#CHECK_DELAY 
		tb_write = 8'b00001111;
		#CHECK_DELAY
		w_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		w_enable = 1'b0;
		#CHECK_DELAY 
		tb_write = 8'b11110000;
		#CHECK_DELAY
		w_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		w_enable = 1'b0;
		#CHECK_DELAY 
		tb_write = 8'b00001111;
		#CHECK_DELAY
		w_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		w_enable = 1'b0;
		#CHECK_DELAY 
		tb_write = 8'b11110000;
		#CHECK_DELAY
		w_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		w_enable = 1'b0;
		#CHECK_DELAY
		tb_write = 8'b00001111;
		#CHECK_DELAY
		w_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		w_enable = 1'b0;
		#CHECK_DELAY 
		tb_write = 8'b11110000;
		#CHECK_DELAY
		w_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		w_enable = 1'b0;
		#CHECK_DELAY
		assert (fifo_ful) 
		    	$info(" PASS: CASE 3"); 
		else 
		    	$error(" FAIL: CASE 3"); 

		//CASE4
		r_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		r_enable = 1'b0;
		#CHECK_DELAY 
		for(i = 0; i < 3; i++) begin 
			@(posedge Clk); 
		end
		r_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		r_enable = 1'b0;
		#CHECK_DELAY 
		for(i = 0; i < 3; i++) begin 
			@(posedge Clk); 
		end
		r_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		r_enable = 1'b0;
		#CHECK_DELAY 
		for(i = 0; i < 3; i++) begin 
			@(posedge Clk); 
		end
		r_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		r_enable = 1'b0;
		#CHECK_DELAY 
		for(i = 0; i < 3; i++) begin 
			@(posedge Clk); 
		end 
		r_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		r_enable = 1'b0;
		#CHECK_DELAY 
		for(i = 0; i < 3; i++) begin 
			@(posedge Clk); 
		end
		r_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		r_enable = 1'b0;
		#CHECK_DELAY 
		for(i = 0; i < 3; i++) begin 
			@(posedge Clk); 
		end
		r_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		r_enable = 1'b0;
		#CHECK_DELAY 
		for(i = 0; i < 3; i++) begin 
			@(posedge Clk); 
		end
		r_enable = 1'b1;
		#CHECK_DELAY
		@(posedge Clk);
		#CHECK_DELAY
		r_enable = 1'b0;
		#CHECK_DELAY 
		for(i = 0; i < 6; i++) begin 
			@(posedge Clk); 
		end
		assert (!fifo_ful && fifo_emp) 
		 	$info(" PASS: CASE 4"); 
		else 
		    	$error(" FAIL: CASE 4"); 

	end
endmodule
