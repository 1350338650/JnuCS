function [] = step4(equ_f, chebf, f, name)
    % ��ֵʵ������������Ʋ�ֵ����ʽ��ͼ
    % equ_f = �ȼ���ֵ����ʽ
    % chebf = �б�ѩ���ֵ����ʽ
    % f = ԭ���� ʹ�÷��ű��ʽ

    % ��0.05�����[-1, 1]���������������
    x = -1:0.05:1;
    % �����Ӧ����ʽ��yֵ
    y = f(x);
    equ_y = equ_f(x);
    cheby = chebf(x);
    % �������
    error_equ = y - equ_y;
    error_cheb = y - cheby;
    % ��ͼ
    figure()
    plot(x, error_equ, 'k-', 'linewidth', 1.1)
    hold on
    grid on
    plot(x, error_cheb, 'r--', 'linewidth', 1.1)
    % ������߿��߿�1.1, �������������СΪTimes New Roman��16
    set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times')
    xlabel('X')
    ylabel('Error')
    % legend������ʹ��Location��������ͼ��λ��
    legend('Error-equ', 'Error-cheb')
    title(name)
    hold off
end