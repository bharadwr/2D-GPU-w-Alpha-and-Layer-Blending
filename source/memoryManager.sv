module memoryManager(
	output logic [31:0] addr,
	input logic n_rst,
	input logic clk, 
  input logic [8:0] x,
	input logic [7:0] y,
	input logic flip_buffer
);

//start addresses of buffers
localparam [31:0] startAddr1 = 32'd1;
localparam [31:0] startAddr2 = 32'd307201;

//internal signals
logic [31:0]start_addr;
logic addr_sel;

//start address select mux 
always_comb
begin
	if(addr_sel == 1'b0)
	begin
		start_addr <= startAddr1;
	end
	else
	begin
		start_addr <= startAddr2;
	end	
end

//address state reg 
always@(negedge n_rst, posedge clk)
begin
	if(n_rst == 1'b0)
	begin
		addr_sel <= 1'b0;
	end
	else
	begin
		//addr_sel flips when a pulse on the flip_buffer input occurs
		addr_sel <= addr_sel ^ flip_buffer;
	end
end  

assign addr = start_addr + (y*1280) + (x*4);

endmodule
