`timescale 1ns / 1ps

// ֧�������ĳ���������������ش�������λ�ߵ�ƽ��Ч
module PC(
    input clk,
    input rst,
    input [31:0] next,
    output reg [31:0] addr
);
    always @(posedge clk)
    begin
        if(rst)
            addr <= 32'b0;
        else
            addr <= next;
    end

    initial
        $monitor($time, , "PC->next => 0x%8h", next);
endmodule
