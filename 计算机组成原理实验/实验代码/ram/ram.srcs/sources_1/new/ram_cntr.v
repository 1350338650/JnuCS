`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/11 11:28:32
// Design Name: 
// Module Name: ram_cntr
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


module ram_cntr(
    input clk,
    input [3:0] code,
    input [31:0] wdata,
    output reg [31:0] rdata
    );
    // ��ַ(����Ӧָ���ź�ȷ��)
    wire [5:0] addr;
    // �����ݵ��м���̬(δ����)
    wire [31:0] im_rdata;   // intermedian read_data
    // ������д����
    wire [31:0] fn_wdata;   // final write_data
    // ָ���ź� �ߵ�ƽ��Ч
    wire lb0, lh0, lw0, lbu0, lhu0, sb4, sh8, sw0, lw4, lw8;
    
    // ����code,����ָ���ź�
    assign lb0 = ~(|code);                                  // 0000
    assign lh0 = ~(|code[3:1]) & code[0];                   // 0001
    assign lw0 = ~(|code[3:2]) & code[1] & ~code[0];        // 0010
    assign lbu0 = ~(|code[3:2]) & (&code[1:0]);             // 0011
    assign lhu0 = ~code[3] & code[2] & ~(|code[1:0]);       // 0100
    assign sb4 = ~code[3] & code[2] & ~code[1] & code[0];   // 0101
    assign sh8 = ~code[3] & (&code[2:1]) & ~code[0];        // 0110
    assign sw0 = ~code[3] & (&code[2:0]);                   // 0111
    assign lw4 = code[3] & ~(|code[2:0]);                   // 1000
    assign lw8 = code[3] & ~(|code[2:1]) & code[0];         // 1001
    
    // ����ָ�����ɵ�ַ�ֶ�
    assign addr = (sh8 | lw8) ?
                    6'b10 : ((sb4 | lw4) ? 
                            6'b01 : 6'b0);

    // ����ָ���źżӹ�д����
    assign fn_wdata = ( 
                        {24'b0, {8{sb4}}}  |
                        {16'b0, {16{sh8}}} |
                        {32{sw0}}
                      ) & 
                      wdata;

    // ����ָ���������� we�ź�
    wire we;
    assign we = (sb4 | sh8 | sw0) ? 1'b1 : 1'b0;
    
    // RAM ʵ��
    ram ins_ram(
        .clk(clk),
        .we(we),
        .addr(addr),
        .rdata(im_rdata),
        .wdata(fn_wdata)
    );
    initial
        $monitor("code = %x\taddr = %x\twdata = %x", code, addr, wdata);
    // ����ָ���źżӹ���������
    always @(*) begin
        if(lb0)
            rdata <= {{24{im_rdata[7]}}, im_rdata[7:0]};
        else if(lh0)
            rdata <= {{16{im_rdata[15]}}, im_rdata[15:0]};
        else if(lw0 | lw4 | lw8)
            rdata <= im_rdata;
        else if(lbu0)
            rdata <= {24'b0, im_rdata[7:0]};
        else if(lhu0)
            rdata <= {16'b0, im_rdata[15:0]};
        else
            rdata <= 32'b0;
    end
endmodule
