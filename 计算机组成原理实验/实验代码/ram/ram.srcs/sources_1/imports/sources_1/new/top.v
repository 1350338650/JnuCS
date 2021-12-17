`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/09 20:11:50
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
    input chip_clk,     // P17 ʱ������100MHz
    input clk,          // S2 �ֶ�����
    input rst,          // PC ��λ��
    input [3:0] code,   // RAM_cntr �����
    input Q,            // ����ѡ����ʾ ROM(=0)��RAM(=1)������
    //output [31:0] test, // �����������˿�(�ۺ�ǰ��ע��)
    output [6:0] a2g,   // �����a2g��
    output [3:0] an     // ѡ������ܶ�
    );
    // rom ʹ�� IP core(Distributed LUT)
    // pc Ӧʹ�� clk
    // �߶������/RAMоƬ ʹ�� chip_clk
    
    wire [31:0] pc_addr;
    // ʵ���� PC
    pc my_pc(
        .rst(rst),
        .clk(clk),
        .addr(pc_addr)
    );
    
    wire [31:0] rom_data;
    // ʵ���� ROM
    rom my_rom(
        .a(pc_addr[5:0]),
        .spo(rom_data)
    );
    
    wire [31:0] rdata;  // �����������
    // ʵ���� RAM controller
    ram_cntr ins_ram_cntr(
        .clk(chip_clk),
        .code(code),
        .wdata(32'h123487ab),   // ֱ��д0x123487ab(ʵ��Ҫ��)
        .rdata(rdata)
    );

    // ʵ������Ƶ��
    wire clk_3hz;
    divclk my_divclk(
        .clk(chip_clk),
        .new_clk(clk_3hz)
    );
    
    wire [15:0] disp_data;
    // Q = 0 ��ʾ ROM ���
    // Q = 1 ��ʾ RAM ���
    assign disp_data = Q ? 
                        {
                            rdata[31:28], 
                            rdata[23:20], 
                            rdata[15:12], 
                            rdata[7:4]
                        } : 
                        rom_data[15:0];
    // ʵ���������
    digit my_digit(
        .data(disp_data),
        .clk(clk_3hz),
        .a2g(a2g),
        .an(an)
    );

    // �����ڷ���鿴ROM��RAM������
    // �ۺ�ǰ����ע�͵�test�˿ں���������
    //assign test = {{rdata[31:28], rdata[23:20], rdata[15:12], rdata[7:4]}, rom_data[15:0]};
endmodule
