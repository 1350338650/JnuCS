%% ��ֵ�����ڶ���ʵ�� ��ֵ
% ���ߣ��������������
% ��Ϯ������!!

function f = ndd(sam_x,sam_y)
% ndd - Description
% ndd Ϊ Newton's divided difference����д��
% ����˼�壬����ţ�ٲ��̲�ֵ����ʽ
% x��������x
% y��������y
% f����ֵ����ʽ
% Syntax: f = ndd(x,y)
    n = length(sam_x);          % ��ȡ��������
    table = zeros(n,n);
    table(:,1) = sam_y;         % ��ʼ�����̱�

    % ������̱�
    for gap = [1: n-1]
        for count = [1: n-gap]
            table(count, gap+1) = (table(count+1,gap) - table(count,gap))/(sam_x(count+gap) - sam_x(count));
        end
    end
    % �γ�ϵ����
    c = table(1,:);
    % �γ�(x-x_i) x_matrix
    syms x
    x_mat = sym(ones(n,1));
    for iter1 = [2:n]
        x_mat(iter1:n,1) = x_mat(iter1:n,1) * (x - sam_x(iter1-1));
    end
    % ����ţ�ٲ��̲�ֵ����ʽ
    f(x) = c * x_mat;
    % ���򣬷���
    f = simplify(f);
end