`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/13 19:35:17
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk,
    input rst,
    input [4:0] n,          // 2 < n < 32
    input Q,                // Q = 0 Ϊ Fibo; Q = 1 Ϊ�ۼ����
    //output [15:0] test,   // ����������ã�ʵ�����������ʾ���
    output [6:0] a2g,       // ������ʾ��an������ܵ�a2gֵ
    output [3:0] an
    );
    // ����ģ�����н��
    // ע�⣺Q����ѡ����ʾ�ĸ�����Ľ��
    // ʵ����top�Ὣ�������ⶼ�������
    wire[31:0] fibo;
    wire[31:0] sum;
    wire[15:0] result;
    // ʵ����fibo������ģ��
    fibo my_fib(
        .clk(clk),
        .rst(rst),
        .n(n),
        .result(fibo)
    );
    // ʵ����cumsum������ģ��
    cumsum my_cumsum(
        .clk(clk),
        .rst(rst),
        .n(n),
        .result(sum)
    );
    
    // ����Q��������result
    assign result = Q ? sum[15:0] : fibo[15:0];
    // �����ã�д��������ע�͵��Լ������test�˿�
    //assign test = Q ? sum[15:0] : fibo[15:0];

    // ����ʱ��Ƶ�������ʣ������ջ������
    wire clk_digit;
    divclk my_divclk(
        .clk(clk),
        .new_clk(clk_digit)
    );
    // ʵ�����߶�����ܿ�����ģ�飬��ʾresult��16���ƣ�
    digit my_digit(
        .data(result),
        .clk(clk_digit),
        .a2g(a2g),
        .an(an)
    );
endmodule
