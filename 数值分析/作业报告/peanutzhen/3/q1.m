clear;clc
% ��������
run init.m

% QR�ֽ�
[Q_a, R_a] = ClassicalGS(A1);
[Q_b, R_b] = ClassicalGS(A2);

% QR�ֽ����
disp(['��һ�·�����(a)(A-Q*R)�����:', num2str(norm(A1-Q_a*R_a))])
disp(['��һ�·�����(b)(A-Q*R)�����:', num2str(norm(A2-Q_b*R_b))])

% ���������� ��Ϯ��m
