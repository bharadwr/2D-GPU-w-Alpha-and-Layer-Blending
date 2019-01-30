`timescale 1ns / 100ps

module tb_sda_sel ();
	localparam	CLK_PERIOD	= 2.5;
	localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay
    	localparam  NUM_CNT_BITS = 4;
	reg tb_tx_out, tb_sda_out, tb_clk;
	reg [1:0]tb_sda_mode;

    	sda_sel DUT
    	( 
    		.tx_out  (tb_tx_out), .sda_out (tb_sda_out), .sda_mode(tb_sda_mode)
    	);
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end 
    	initial begin

	    	//CASE1
	    	@(posedge tb_clk);
	    	tb_sda_mode = 2'b00;
	    	@(posedge tb_clk);
		#CHECK_DELAY
		assert (tb_sda_out) 
			$info("PASS: CASE 1"); 
		else 
			$error("FAIL: CASE 1"); 

		//CASE2 
	    	tb_sda_mode = 2'b01;
		#CHECK_DELAY
		@(posedge tb_clk);
		assert (!tb_sda_out)
			$info("PASS: CASE 2");
		else 
			$error("FAIL: CASE 2"); 
		@(posedge tb_clk);

		//CASE3 
	    	tb_sda_mode = 2'b10;
		#CHECK_DELAY
		@(posedge tb_clk);
		assert (tb_sda_out) 
			$info("PASS: CASE 3"); 
		else 
			$error("FAIL: CASE 3"); 
		@(posedge tb_clk);

		//CASE4 
	    	tb_sda_mode = 2'b11;
	    	tb_tx_out = 1'b0;
		#CHECK_DELAY
		@(posedge tb_clk);
		assert (!tb_sda_out)  
			$info("PASS: CASE 4"); 
		else 
			$error("FAIL: CASE 4"); 
		@(posedge tb_clk);

		//CASE5 
	    	tb_sda_mode = 2'b11;
	    	tb_tx_out = 1'b1;
		#CHECK_DELAY
		@(posedge tb_clk);
		assert (tb_sda_out) 
			$info("PASS: CASE 5"); 
		else 
			$error("FAIL: CASE 5"); 

		//CASE6
	    	tb_sda_mode = 2'b11;
	    	tb_tx_out = 1'b0;
		#CHECK_DELAY
		@(posedge tb_clk);
		assert (!tb_sda_out) 
			$info("PASS: CASE 6"); 
		else 
			$error("FAIL: CASE 6"); 
	end
endmodule
