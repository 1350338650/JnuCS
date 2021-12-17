`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/10 09:37:06
// Design Name: 
// Module Name: sim
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


module sim(

    );
    reg chip_clk = 1'b0;
    reg clk = 1'b0;
    reg rst = 1'b0;
    reg [3:0] code;
    // ģ��clk T = 160ns PC���Լ�6��1
    always
        #80 clk <= ~clk;
    // ��֤set PC addr 0
    initial
        #105 rst <= ~rst;

    // ģ��оƬʱ������
    always
        #5 chip_clk = ~chip_clk;

    // ģ�����ִ�У��� s �� l

    initial begin
        code = 4'b0101;     // sb4
        #10 code = 4'b0110; // sh8
        #10 code = 4'b0111; // sw0
        #10 code = 4'b0000; // lb0
        #10 code = 4'b0001; // lh0
        #10 code = 4'b0010; // lw0
        #10 code = 4'b0011; // lbu0
        #10 code = 4'b0100; // lhu0
        #10 code = 4'b1000; // lw4
        #10 code = 4'b1001; // lw8
    end

    wire [31:0] test;
    top my_top(
        .chip_clk(chip_clk),
        .clk(clk),
        .rst(rst),
        .code(code),
        .test(test)
    );
endmodule
