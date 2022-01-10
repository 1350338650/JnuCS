function [Q, R, H_list] = HouseHolder(A)
    %% ���ں�˹�����·����QR�ֽ�
    % H_list ��ÿһ�������Ӿ���

    m = size(A, 1);
    n = size(A, 2);
    R = A;
    H_list = cell(1, n);
    for k = 1 : n
        x = R(k:end, k);
        w = zeros(size(x));
        w(1) = norm(x);

        v = w - x;
        P = (1 / (v' * v))*(v .* v');
        H_hat = eye(size(P)) - 2 * P;
        H = eye(m);
        H(k:end,k:end) = H_hat;
        R = H * R;  % �� k = n ʱ��R�������������ϵ�R
        % ����ʱ���� H_i * H_(i-1) * ... * H_2 * H_1 * A 

        H_list{k} = H;
    end
    % ���� Q
    Q = H_list{1};
    for k = 2 : n
        Q = Q * H_list{k};
    end
end