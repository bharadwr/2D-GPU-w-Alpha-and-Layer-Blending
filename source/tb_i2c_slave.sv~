`timescale 1ns / 10ps
module tb_i2c_slave();
    parameter CLK_PERIOD                = 10;
    parameter SCL_CLK_PERIOD            = 300;
   
    reg tb_clk;
    reg tb_n_rst;
    reg tb_slave_scl;
    reg tb_slave_sda_in;
    reg tb_slave_sda_out;
    reg tb_write_enable;
    reg [7:0] tb_write_data;
    reg tb_fifo_empty;
    reg tb_fifo_full;

    integer tb_test_case_num;
    integer tb_test_sample_num;
    integer i;
    reg tb_expected_fifo_empty;
    reg tb_expected_fifo_full;
    reg tb_expected_master_sda_in;
    reg tb_master_scl_in;
    reg tb_master_scl_out;
    reg tb_master_sda_in;
    reg tb_master_sda_out;

    reg tb_enable_scl_in;
   
    i2c_slave DUT
    (
        .clk(tb_clk),
        .n_rst(tb_n_rst),
        .scl(tb_slave_scl),
        .sda_in(tb_slave_sda_in),
        .sda_out(tb_slave_sda_out),
        .write_enable(tb_write_enable),
        .write_data(tb_write_data),
        .fifo_empty(tb_fifo_empty),
        .fifo_full(tb_fifo_full)
    );

endmodule
