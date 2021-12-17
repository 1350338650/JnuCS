`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/13 19:16:28
// Design Name: 
// Module Name: fibo
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


module fibo(
    input clk,
    input rst,
    input [4:0] n,
    output [31:0] result
    );
    // ����ALUʵ��Fibonacci����Fibo��ALu�Ŀ�����
    
    // ��������
    reg[31:0] regA, regB;
    wire[31:0] ans;
    reg[4:0] count;
    // ʵ����ALUģ��
    alu myalu(.a(regA),.b(regB),.op(4'b0001),.f(ans),.c());
    // ÿ��clk�����ظı�Ĵ���A/B
    // ����ans���������ı�
    always @(posedge clk)
    begin
        // ��fibonacci(3)��ʼ����
        if(rst == 1'b1)
        begin
            regA <= 32'b1;
            regB <= 32'b1;
            count <= 5'b00011;
        end
        // ��ʼ��������
        else
        begin
            if(count < n)
            begin
                regA <= regB;
                regB <= ans;
                count <= count + 1'b1;
            end
        end
    end
    
    // ÿ��ans�仯��result������
    assign result = ans;
endmodule
