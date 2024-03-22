`timescale 1ns / 1ps
`define clk_period 10


module sync_fifo_tb();
reg clk;
reg rst;

reg wr_en_i;
reg rd_en_i;
reg [7:0] data_i;

wire [7:0] data_o;
wire full_o;
wire empty_o;

sync_fifo SYNC_FIFO(
.clk(clk),
.rst(rst),

.wr_en_i(wr_en_i),
.data_i(data_i),

.rd_en_i(rd_en_i),
.data_o(data_o),

.full_o(full_o),
.empty_o(empty_o)
);
integer i;
initial clk=1;
always #(`clk_period/2) clk=~clk;

initial begin
    rst=1'b0;

    wr_en_i=1'b0;
    rd_en_i=1'b0;

    data_i=8'b0;

    #(`clk_period);
    rst=1'b1;
    #(`clk_period);
    rst=1'b0;
    //Write
    wr_en_i=1'b1;
    rd_en_i=1'b0;

    for(i=0; i<8; i=i+1) begin
        data_i=i;
        #(`clk_period);
    end

    //Read
    wr_en_i=1'b0;
    rd_en_i=1'b1;

    for(i=0; i<8; i=i+1) begin
        data_i=i;
        #(`clk_period);
    end

    //Write
    wr_en_i=1'b1;
    rd_en_i=1'b0;

    for(i=0; i<8; i=i+1) begin
        data_i=i;
        #(`clk_period);
    end

#(`clk_period);
#(`clk_period);
#(`clk_period);
$finish();
    end
endmodule
