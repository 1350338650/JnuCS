function [Q, R] = ClassicalGS(A)
    %% ���ھ������ķʩ����������QR�ֽ�

    % �����Ѿ�����A��n�������޹ص�mά����
    % ����A������ n �� m �ģ�����n��A��������m������
    % ������Ҫ��չһ��A����������m����������
    % �Ͼ�n�����������ų�nά�ռ�

    
    % ��ȡA����������
    m = size(A, 1);
    n = size(A, 2);
    % ��ʼ������ֵ
    Q = zeros(m, m);
    R = zeros(m, n);
    % ���A�Ƿ�Ϊn�������޹ص�������
    if rank(A) < n
        disp('A ������ n �������޹ص�������ɵľ���');
        Q = 0;
        R = 0;
        return ;
    end
    % �� n < m ����Ҫ�������ʹ�� A �� rank Ϊ m
    if n < m
        % ��֤ rank Ϊ m ��Ϊֻ�Ǻܴ���� ������˵һ��
        while rank(A) ~= m
            for k = 1 : m - n
                % ���� A ���Ѿ��� n �������޹����������
                % ���ǿ�������ȡǰm - n������������������任
                % �������ǿ��Ժܴ���ʲ�����֮ǰ��������������ع�ϵ
                A(:, n+k) = rand(m, 1) .* A(:, k);
            end
        end
    end
    % ���ڽ��о���ĸ���ķʩ���������ֽ�
    for k = 1 : m
        y = A(:, k);
        for count = 1 : k-1
            if count > n
                break
            end
            R(count, k) = Q(:, count)' * A(:, k);
            y = y - R(count, k) * Q(:, count);
        end
        R(k, k) = norm(y);
        Q(:, k) = y / R(k, k);
    end
    % ֻ���� R �� m*n �Ĳ���
    R = R(1:m, 1:n);
end