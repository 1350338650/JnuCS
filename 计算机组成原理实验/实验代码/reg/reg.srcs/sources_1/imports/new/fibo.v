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
    // ���üĴ����Ѻ�ALUʵ��Fibonacci
    // ��Fibo��RegFiles/ALu�Ŀ�����
    // ��������������״̬��(4 status)ʵ��
    
    // ��������
    reg [4:0] read_addr[1:2];       // ���˿�2����ַ�Ĵ���
    wire [31:0] data[1:2], ans;     // ALU������
    reg we;                         // дʹ�ܶ�
    reg [4:0] write_addr;           // д�˿ڵ�ַ�Ĵ���
    reg [31:0] write_data;          // д�˿����ݼĴ���
    reg [1:0] status;               // ״̬��ʾ
    
    reg [4:0] count;                // ���ں�ʱֹͣ����
    // ʵ����RegFilesģ��
    RegFiles reg_inst1(
        .clk(clk),
        .we(we),
        .raddr1(read_addr[1]),
        .rdata1(data[1]),
        .raddr2(read_addr[2]),
        .rdata2(data[2]),
        .waddr(write_addr),
        .wdata(write_data)
    );
    // ʵ����ALUģ��
    ALU alu_inst1(
        .a(data[1]),
        .b(data[2]),
        .f(ans),
        .op(4'b0001)    // 0x1 ʹALU���м�����
    );
    // �� �� ״ ̬ ��
    // S0 �� S1 ���ڳ�ʼ��
    // S2 �� S3 ���ڼ��㲢�Ҹ��¼Ĵ�������Ӧ����
    // �������л�״̬��ע�⣬��������Ҫ�ͼĴ�����д����ͬʱʹ��
    // �����أ�������־�����ʹ��״̬�л��󣬲���û�����ü���ֵ
    // ��ɣ����Ĵ����Ѿ���ʼд���ͻ�õ���������
    always @(posedge clk)
    begin
        // ��ʼ��״̬���������¼���/ˢ��
        if(rst == 1'b1)
        begin
            count <= 5'b00010;
            status <= 2'b00;
        end
        // ��������״̬��
        else
        begin
            case(status)
                // ״̬0��regs[1] <= 1
                2'b00:
                    begin
                        we <= 1'b1;
                        write_addr <= 5'b00001;
                        write_data <= 32'b1;
                        status <= 2'b01;
                    end
                // ״̬1��regs[2] <= 1 �� ��ʼ��read_addr
                2'b01:
                    begin
                        we <= 1'b1;
                        write_addr <= 5'b00010;
                        write_data <= 32'b1;
                        read_addr[1] <= 5'b00001;
                        read_addr[2] <= 5'b00010;
                        status <= 2'b10;
                    end
                // ״̬2��ALU���� �� д������һ���Ĵ���
                2'b10:
                    begin
                        we <= 1'b1;
                        write_addr <= read_addr[2] + 1;
                        write_data <= ans;
                        count <= count + 1;
                        status <= 2'b11;
                    end
                // ״̬3��ƽ��ѡ��ļĴ���������״̬2
                // �������ɺ�ɶҲ�����ˡ�
                2'b11:
                    begin
                        if(count < n)
                        begin
                            read_addr[1] <= read_addr[1] + 1;
                            read_addr[2] <= read_addr[2] + 1;
                            we = 1'b0;
                            status <= 2'b10;
                        end
                    end
                default: status <= 2'b00;
            endcase
        end
    end
    // ������֪��ALU����ans��Ϊ��
    assign result = ans;
    //initial
        //$monitor($time,,"status=%d reg1=%x reg2=%x",status,data[1],data[2]);
endmodule
