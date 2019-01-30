`timescale 1ns / 100ps

module tb_scl_edge ();
	localparam	CLK_PERIOD	= 10;
	localparam	CHECK_DELAY = 3; // Check 1ns after the rising edge to allow for propagation delay
    	localparam  NUM_CNT_BITS = 4; 
	reg Clk,N_rst,Scl,rise_edge_found,fall_edge_found;
    	scl_edge DUT
    	( 
		.scl(Scl), .falling_edge_found(fall_edge_found), .rising_edge_found(rise_edge_found), .clk(Clk), .n_rst(N_rst)
    	);
	always begin
		Clk = 1'b0;
		#(CLK_PERIOD/2.0);
		Clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end 
	integer i = 0;
    	initial begin
		N_rst = 0;
		Scl = 0;
		N_rst = 1;
		Scl = 1;
		N_rst = 0;
		Scl = 0;
		#CHECK_DELAY
		N_rst = 1;
		Scl = 1;
		N_rst = 0;
		Scl = 0;
		N_rst = 1;
		Scl = 1;
		#CHECK_DELAY
		N_rst = 0;
		Scl = 1;
		#CHECK_DELAY
		N_rst = 1;
		Scl = 0;
		#CHECK_DELAY
		#CHECK_DELAY
		N_rst = 1;
		Scl = 1;
		#CHECK_DELAY
		N_rst = 0;
		Scl = 1;
		#CHECK_DELAY
		N_rst = 0;
		Scl = 1;
		#CHECK_DELAY
		#CHECK_DELAY
		N_rst = 0;
		Scl = 0;
		#CHECK_DELAY

	    	// CASE1 
		Scl = 0;
	    	N_rst = 1;
		for(i = 0; i < 3; i++) begin 
			@(posedge Clk); 
		end
		assert (fall_edge_found && !rise_edge_found) 
			$info("PASS: CASE 1"); 
		else 
			$error("FAIL: CASE 1"); 

	    	// CASE2 
		Scl = 0;
	    	N_rst = 1;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 1;
		@(posedge Clk);
		#CHECK_DELAY
		assert (!fall_edge_found && !rise_edge_found) 
			$info("PASS: CASE 2"); 
		else 
			$error("FAIL: CASE 2"); 

		// CASE3 
	    	N_rst = 1;
		N_rst = 0;
		N_rst = 1;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 1;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 1;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 1;
		@(posedge Clk);
		#CHECK_DELAY
		assert (!fall_edge_found && !rise_edge_found) 
			$info("PASS: CASE 3"); 
		else 
			$error("FAIL: CASE 3"); 

		// CASE4
		N_rst = 1;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 1;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 1;
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		Scl = 1;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 1;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		assert ( rise_edge_found && !fall_edge_found ) 
		    	$info("PASS: CASE 4"); 
		else 
		    	$error("FAIL: CASE 4"); 

		// CASE5
	    	N_rst = 1;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		assert (!fall_edge_found && !rise_edge_found) 
			$info("PASS: CASE 5"); 
		else 
			$error("FAIL: CASE 5"); 

		// CASE6
	    	N_rst = 1;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 1;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 1;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 1;
		@(posedge Clk);
		#CHECK_DELAY
		N_rst = 0;
		#CHECK_DELAY
		assert (!fall_edge_found && !rise_edge_found) 
			$info("PASS: CASE 6"); 
		else 
			$error("FAIL: CASE 6"); 

		// CASE7 
		N_rst = 1;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);
		#CHECK_DELAY
		Scl = 0;
		@(posedge Clk);     
		#CHECK_DELAY
		assert ( !rise_edge_found && !fall_edge_found ) 
		    	$info("PASS: CASE 7"); 
		else 
		    	$error("FAIL: CASE 7"); 
    	end
endmodule
