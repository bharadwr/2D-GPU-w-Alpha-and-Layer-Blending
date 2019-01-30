//APB slave implementation for  '2D-GPU' ECE 337 project
//12/6/16 - Nithin V

module APB_SlaveInterface(
	input logic [31:0] PWDATA,
	input logic PSEL,
	input logic PWRITE,
	output logic [31:0] PRDATA,
	input logic pclk,
	input logic n_rst,
	input logic [31:0] status_value,
	output logic [31:0] command_bus,
	output logic penable
);

//check syntax
typedef enum bit [1:0]{
	IDLE,WRITE,READ
}stateType;

stateType state, next_state;

//next state logic 
always_comb
begin
	// Set the default value(s)
	next_state = state;

	// Define the state transitions
	case(state)
		IDLE:
		begin
			if(1'b1 == PSEL)
			begin
				if(1'b1 == PWRITE)
				begin
					next_state = WRITE;
				end
				else
				begin
					next_state = READ;
				end
				
			end
		end
		
		WRITE:
		begin
			if(1'b0 == PSEL)
			begin
				next_state = IDLE;
			end
				
		end

		READ:
		begin
			if(1'b0 == PSEL)
			begin
				next_state = IDLE;
			end
		end
	endcase
end

//state reg 
always@(negedge n_rst, posedge pclk)
begin
	if(n_rst == 1'b0)
	begin
		state <= IDLE;
	end
	else
	begin
		state <= next_state;
	end
end

//output logic
always_comb
begin
	//default
	penable = 1'b0;
	command_bus = PWDATA;
	PRDATA = 32'b0;
	
	case(state)
		READ:
		begin
			PRDATA = status_value;
		end
		WRITE:
		begin
			command_bus = PWDATA;
			penable = 1'b1; // high for 2 cycles, but decode handles it
			
		end
	endcase
end

endmodule

