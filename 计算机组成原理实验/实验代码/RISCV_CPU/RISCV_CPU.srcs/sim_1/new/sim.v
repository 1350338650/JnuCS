`timescale 1ns / 1ps

module sim(

);
    reg clk = 1'b0;
    always #5
        clk = ~clk;
    
    reg rst = 1'b1;
    initial #15
        rst = 1'b0;
    
    TOP sim_TOP(
        .clk(clk),
        .rst(rst),
        .n(6'hf)    // n�𳬹�15 ����ʱ�䲻������ ��������Ե������ʱ��
    );
endmodule
