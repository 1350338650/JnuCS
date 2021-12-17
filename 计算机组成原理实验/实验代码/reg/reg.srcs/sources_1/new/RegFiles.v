`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/27 14:37:43
// Design Name: 
// Module Name: RegFiles
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


module RegFiles(
    input clk,
    input we,
    input [4:0] raddr1,
    output [31:0] rdata1,
    input [4:0] raddr2,
    output [31:0] rdata2,
    input [4:0] waddr,
    input [31:0] wdata
    );
    // �˼Ĵ����ѹ���32��32λ�Ĵ���
    // ��ͬʱ�������Ĵ�����ֵ
    // ֧��д������we���ƶ�/д
    
    // �˴�ֻ����31���Ĵ�����ԭ����0�żĴ�����Ϊ0
    // ��ֱ��Ӳ���룬�����ɱ���
    reg[31:0] regs[1:31];
    
    // �����������·
    assign rdata1 = (raddr1 == 5'b00000) ? 32'b0 : regs[raddr1];
    assign rdata2 = (raddr2 == 5'b00000) ? 32'b0 : regs[raddr2];
    
    // ����д������·���½��ؿ�ʼд
    always @(negedge clk)
        if(we)
            if(waddr != 5'b00000)
                regs[waddr] <= wdata;

endmodule
