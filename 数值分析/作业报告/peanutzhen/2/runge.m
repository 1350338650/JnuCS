%% ��ֵ�����ڶ���ʵ�� ��ֵ
% ���ߣ��������������
% ��Ϯ������!!

%% ���������ز����ɽű�
clear,clc;
sam_x1 = linspace(-1,1,11);
sam_y1 = 1 ./ (1 + 25 * sam_x1.^2);

sam_x2 = linspace(-1,1,21);
sam_y2 = 1 ./ (1 + 25 * sam_x2.^2);

poly_f11 = ndd(sam_x1,sam_y1);
poly_f22 = ndd(sam_x2,sam_y2);

x = [-1:0.01:1];
y1 = 1 ./ (1 + 25 * x.^2);
y2 = poly_f11(x);
y3 = poly_f22(x);

% ��ʼ��ͼ origin with n = 11
figure(1)
plot(x, y1, 'k-', 'linewidth', 1.1)
hold on
grid on
plot(x, y2, 'r--', 'linewidth', 1.1)
plot(sam_x1, sam_y1, 'o', 'markerfacecolor', [36, 169, 225]/255)

% ������߿��߿�1.1, �������������СΪTimes New Roman��16
set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times')
xlabel('X')
ylabel('Y')
% legend������ʹ��Location��������ͼ��λ��
legend('origin', 'n = 11')
title('n = 11 compared with origin')
hold off

% ��ʼ��ͼ origin with n = 22
figure(2)
plot(x, y1, 'k-', 'linewidth', 1.1)
hold on
grid on
plot(x, y3, 'b-', 'linewidth', 1.1)
plot(sam_x2, sam_y2, 'o', 'markerfacecolor', [29, 191, 151]/255)

% ������߿��߿�1.1, �������������СΪTimes New Roman��16
set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times')
xlabel('X')
ylabel('Y')
% legend������ʹ��Location��������ͼ��λ��
legend('origin', 'n = 22')
title('n = 22 compared with origin')
hold off
