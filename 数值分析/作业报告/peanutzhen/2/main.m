%% ��ֵ�����ڶ���ʵ�� ��ֵ
% ���ߣ��������������
% ��Ϯ������!!

%% ǰ����Ҫ��
% ԭ����fxΪe^(-2x)
% ������Ϊ[-1,1]
% ���������ֱ�Ϊ10 20 40
% ʹ�õȾ����������б�ѩ���������ţ�ٲ��̲�ֵ
clear;clc;
syms x
f(x) = exp(-2*x);
%% n = ?
n = input('Enter nums of sample points: ');
equ_x = linspace(-1,1,n);
chebx = cos((2*[1:n]-1)*pi/(2*n));
[equ_f, chebf] = step3(equ_x, chebx, f);
step4(equ_f,chebf,f,['n = ', num2str(n), ' �Ⱦ�����б�ѩ����ֵ���Ա�'])