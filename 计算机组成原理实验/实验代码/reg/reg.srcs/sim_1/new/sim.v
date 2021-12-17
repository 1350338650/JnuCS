`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/27 16:22:33
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
    reg clk = 1'b0;
    reg rst = 1'b1;
    // ����ʱ�����壬����Ϊ20ns
    always
        #10 clk = ~clk;
    // ��ʼ��reset
    initial
        #15 rst = 1'b0;
    
    reg[4:0] n = 5'b01010;      // �����������n
    reg Q = 1'b0;               // FiboΪ0��CumSumΪ1
    wire[15:0] result;          // ������
    
    // ע�⣺�˴�Ҫ��top�е�test�˿�ȥ��ע�ͣ�
    // ԭ����ʵ��д�������ϲ���Ҫ��������������������
    // ���޷����ɱ�������
    top mytop(clk,rst,n,Q,result);
    
     
endmodule
