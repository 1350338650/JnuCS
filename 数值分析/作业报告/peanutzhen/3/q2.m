clear;clc
run init.m

% QR�ֽ� ���ں�˹��������·���
[Q_a, R_a, H_a] = HouseHolder(A1);
[Q_b, R_b, H_b] = HouseHolder(A2);

% QR�ֽ����
disp(['��һ�·�����(a)(A-Q*R)�����:', num2str(norm(A1-Q_a*R_a))])
disp(['��һ�·�����(b)(A-Q*R)�����:', num2str(norm(A2-Q_b*R_b))])
