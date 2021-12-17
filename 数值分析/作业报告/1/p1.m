clear;clc

%% ���峣��
A = diag(repmat(1/2,999,1),1) + diag(repmat(1/2,998,1),2);
A = A + diag(repmat(1/2,999,1),-1) + diag(repmat(1/2,998,1),-2);
A = diag(1:1000) + A;
b = repmat(1,1000,1);

%% �ж��Ƿ�Ϊ�ϸ�Խ�ռ�ž���
if abs(diag(A)) > sum(abs(A-diag(diag(A))),2)
    disp('Aha, here it is.')
else
    disp('Oh shit! Not a strictly diagonally dominant.')
end

LOOP = 15;    % ��������
% �������
real_x = inv(A) * b;

%% Jacobi Method
disp('Jacobi...')
% �ֽ�AΪ L D U
D = diag(diag(A));  % �ԽǾ���
L = tril(A,-1);      % �����Ǿ���
U = triu(A,1);      % �����Ǿ���
% �趨��ʼ��x����
old_x = zeros(length(b),1);
% ��¼ÿһ�ε������ֵ
Error_Jacobi = zeros(1,LOOP);
for count = 1: LOOP
    Jacobi = inv(D) * (b - (L + U) * old_x);
    % calculate error
    Error_Jacobi(count) = ErrorFunc(Jacobi, real_x);
    % update
    old_x = Jacobi;
end
% ��ʾ��
%disp('Jacobi method:')
%disp(new_x')


%% Gauss-seidel Method
disp('Gauss-seidel...')
% �趨��ʼ��x����
old_x = zeros(length(b),1);
Gauss_seidel = zeros(size(old_x));

% ��¼ÿһ�ε������ֵ
Error_Gauss_seidel = zeros(1,LOOP);
LU = L + U;
invD = inv(D);
for count = 1: LOOP
    % ������ÿ�������µ�ֵ��ÿ�����µ�ֵʱ����Щ�����Ѿ������µ�ֵ
    for index = 1 : length(old_x)
        old_x(index) = invD(index,index) * (b(index) - LU(index, :) * old_x);
        Gauss_seidel = old_x;
    end
    Error_Gauss_seidel(count) = ErrorFunc(Gauss_seidel, real_x);
end
% ��ʾ��
%disp('Gauss-seidel method:')
%disp(new_x')


%% SOR with omega == 1.1
disp('SOR...')
omega = 1.1;
% �趨��ʼ��x����
old_x = zeros(length(b),1);
invD = inv(D);
LU = L + U;
Error_SOR = zeros(1,LOOP);
for count = 1: LOOP
    for index = 1 : length(old_x)
        old_x(index) = (1 - omega) * old_x(index) + invD(index,index) * omega * (b(index) - (LU(index, :) * old_x));
    end
    SOR = old_x;
    Error_SOR(count) = ErrorFunc(SOR, real_x);
end
% ��ʾ��
%disp('SOR-omega1.1 method:')
%disp(new_x')


%% Conjugate Gradient Method
disp('Conjugate gradient...')
% �趨��ʼ��x����
x = zeros(length(b),1);
old_d = b;
old_r = b;
zero_r = zeros(size(old_r));
Error_Conjugate = zeros(1,LOOP);
for count = 1: LOOP
    if old_r == zero_r
        break
    else
        alpha = (old_r' * old_r) / (old_d' * A * old_d);
        Conjugate = x + alpha * old_d;  % new x
        new_r = old_r - alpha * A * old_d;
        my_beta = (new_r' * new_r) / (old_r' * old_r);
        new_d = new_r + my_beta * old_d;
        % calculate error
        Error_Conjugate(count) = ErrorFunc(Conjugate, real_x);
        % update d and r
        old_d = new_d;
        old_r = new_r;
        x = Conjugate;
    end
end
% ��ʾ��
%disp('Conjugate Gradient method:')
%disp(x')


%% Conjugate Gradient Method with Jacobi preconditioner
disp('Conjugate gradient with Jacobi...')
M = D;
% �趨��ʼ��x����
x = zeros(length(b),1);
old_r = b;
old_d = inv(M) * old_r;
old_z = old_d;

zero_r = zeros(size(old_r));

Error_CJ = zeros(1, LOOP);
for count = 1: LOOP
    if old_r == zero_r
        break
    else
        alpha = (old_r' * old_z) / (old_d' * A * old_d);
        Conjugate_Jacobi = x + alpha * old_d;  % new x
        new_r = old_r - alpha * A * old_d;
        new_z = inv(M) * new_r;
        my_beta = (new_r' * new_z) / (old_r' * old_z);
        new_d = new_z + my_beta * old_d;
        % calculate error
        Error_CJ(count) = ErrorFunc(Conjugate_Jacobi, real_x);
        % update d r z x
        old_d = new_d;
        old_r = new_r;
        old_z = new_z;
        x = Conjugate_Jacobi;
    end
end
% ��ʾ��
%disp('Conjugate Gradient method with Jacobi preconditioner:')
%disp(x')


%% �����ͼ
figure(1)
% Jacobi
plot(1:LOOP, Error_Jacobi, 'ok-', 'linewidth', 1.1, 'markerfacecolor', [217, 57, 47]/255)
hold on
% Gauss
plot(1:LOOP, Error_Gauss_seidel, 'sk-', 'linewidth', 1.1, 'markerfacecolor', [78, 165, 236]/255)
% SOR
plot(1:LOOP, Error_SOR, '*k-', 'linewidth', 1.1, 'markerfacecolor', [53, 116, 66]/255)
% Conjugate
plot(1:LOOP, Error_Conjugate, 'xk-', 'linewidth', 1.1, 'markerfacecolor', [159, 144, 191]/255)
% Conjugate with Jacobi
plot(1:LOOP, Error_CJ, 'pk-', 'linewidth', 1.1, 'markerfacecolor', [132, 134, 134]/255)
% Figure ����
set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times')
xlabel('Epochs')
ylabel('Error')
title('Problem 1 Performance')
legend('Jacobi', 'Gauss', 'SOR', 'Conjugate', 'Con & Jacobi')
grid on

%% �������excel
title = {"������","�ſɱ�","��˹����","SOR","�����ݶ�","�����ݶ�withԤ����"};
output = [real_x,Jacobi,Gauss_seidel,SOR,Conjugate,Conjugate_Jacobi];
output = [title; num2cell(output)];
