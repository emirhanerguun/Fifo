`timescale 1ns / 1ps

module sync_fifo(
input clk,
input rst,

input wr_en_i,
input [7:0] data_i,
output full_o,

input rd_en_i,
output reg [7:0] data_o,
output empty_o
);

parameter DEPTH = 8;
reg [7:0] mem [0:DEPTH-1]; //Defined fifo

reg [2:0] wr_ptr;
reg [2:0] rd_ptr;
reg [3:0] count;
reg full,empty;
//assign full_o = (count==DEPTH)? 1 : 0;
//assign empty_o = (count==0)? 1 : 0;

//Clock_divider div (clk,clk_out);
always @(*) begin
    full = (count==DEPTH)? 1 : 0;
    empty = (count==0)? 1 : 0;
end

assign full_o=full;
assign empty_o=empty;
always @(posedge clk) begin //Writing
    if (rst) begin
    wr_ptr<=2'd0;
    rd_ptr<=3'd0;
    count<=4'd0;
    end
    else begin
    if(wr_en_i==1 && ~full_o) begin
            mem[wr_ptr]<=data_i;
            wr_ptr<= wr_ptr + 1;
            count<= count + 1;
        end
    else if(rd_en_i==1 && ~empty_o) begin
            data_o<=mem[rd_ptr];
            rd_ptr<= rd_ptr + 1;
            count<= count - 1;
        end
    end
end
endmodule