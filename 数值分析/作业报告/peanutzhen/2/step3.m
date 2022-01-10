function [equ_f, chebf] = step3(equ_x, chebx, f)
    % ��ֵʵ������������Ʋ�ֵ����ʽ��ͼ
    % equ_x = �ȼ��������
    % chebx = �б�ѩ��������
    % f = ԭ���� ʹ�÷��ű��ʽ

    % ͳ�����������
    n = length(equ_x);
    % �����Ӧ�������yֵ
    equ_y = f(equ_x);
    cheby = f(chebx);
    % ���ɲ�ֵ����
    equ_f = ndd(equ_x, equ_y);
    chebf = ndd(chebx, cheby);

    x = [-1:0.01:1];
    y1 = f(x);
    y2 = equ_f(x);
    y3 = chebf(x);

    % ԭ������ȼ���ֵ�Ƚ�
    figure()
    plot(x, y1, 'k-', 'linewidth', 1.1)
    hold on
    grid on
    plot(x, y2, 'r--', 'linewidth', 1.1)
    plot(equ_x, equ_y, 'o', 'markerfacecolor', [36, 169, 225]/255)

    % ������߿��߿�1.1, �������������СΪTimes New Roman��16
    set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times')
    xlabel('X')
    ylabel('Y')
    % legend������ʹ��Location��������ͼ��λ��
    legend('Origin', 'Evenly spaced')
    title(['�ȼ��������Ա�','n = ', num2str(n)])
    hold off

    % ԭ�������б�ѩ���ֵ����ʽ�Ƚ�
    figure()
    plot(x, y1, 'k-', 'linewidth', 1.1)
    hold on
    grid on
    plot(x, y3, 'g--', 'linewidth', 1.1)
    plot(chebx, cheby, 'o', 'markerfacecolor', [29, 191, 151]/255)

    % ������߿��߿�1.1, �������������СΪTimes New Roman��16
    set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times')
    xlabel('X')
    ylabel('Y')
    % legend������ʹ��Location��������ͼ��λ��
    legend('Origin', 'Chebf')
    title(['�б�ѩ��������Ա�','n = ', num2str(n)])
    hold off

end