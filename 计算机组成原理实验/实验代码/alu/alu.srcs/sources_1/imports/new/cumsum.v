`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/13 20:15:12
// Design Name: 
// Module Name: cumsum
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


module cumsum(
    input clk,
    input rst,
    input [4:0] n,
    output [31:0] result
    );
    // ����ALUʵ���ۼ���ͣ���cumsum��ALu�Ŀ�����

    // ��������
    reg[31:0] regA, regB;   // ����˼Ĵ���
    wire[31:0] ans;         // ����Alu���н��

    // ʵ����ALUģ��
    alu myalu(
        .a(regA),
        .b(regB),
        .op(4'b0001),
        .f(ans),
        .c()
    );
    // ÿ��clk�����ظı�Ĵ���A/B
    // ����ans���������ı�
    always @(posedge clk)
    begin
        // �� 1 + 2 ��ʼ����
        if(rst == 1'b1)
        begin
            regA <= 32'b1;
            regB <= 32'b10;
        end
        // ���ڲ��ϵ���regB��ֱ��regB == n
        else
        begin
            if(regB < n)
            begin
                regA <= ans;
                regB <= regB + 1'b1;
            end
        end
    end
        
    // ÿ��ans�仯��result������
    assign result = ans;
endmodule
