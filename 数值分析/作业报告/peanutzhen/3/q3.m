clear;clc

run q2.m

% �⣨a��
d1 = Q_a' * b1;
x1 = inv(R_a(1:n1,1:end)) * d1(1:n1);
e1 = norm(d1(n1+1:end));

% �⣨b��
d2 = Q_b' * b2;
x2 = inv(R_b(1:n2,1:end)) * d2(1:n2);
e2 = norm(d2(n2+1:end));

disp(['(a)����С�������: ', num2str(e1)])
disp(['(b)����С�������: ', num2str(e2)])
