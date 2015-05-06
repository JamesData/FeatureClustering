%% [center,U,obj_fcn] = MDFCM(MD,cluster_n)
% ����˵�����Թ���·����������MD������о��࣬���øĽ�k��ֵ�����㷨
% ���������
%           MD           - MD�������
%           c_n          - ����������
% ���������
%           center       - �������ģ�����
%           U            - ���־���
%           obj_fcn      - Ŀ�꺯����ֵ��
%%
function [center,U,obj_fcn] = MDFCM(MD,c_n)
[p_n,~] = size(MD);

% init
obj_fcn = 0;                                       % ��ʼ��Ŀ�꺯��ֵ
center = unidrnd(p_n,c_n,1);                       % ��ʼ����������
Cluster = cell(c_n,1);                             % ��ʼ�������༯��
NoChange = 1;                                      % flag���ж��Ƿ�ֹͣѭ��
k = 0;                                             % ��ʼ��������������
while(NoChange ~= 0)
    center_tmp = center;
    [MD_min,ind] = min(MD(center_tmp,:));          % ����������������������
    U = zeros(c_n,p_n);                            % ��ʼ���־���
    % ���㻮�־���
    for i = 1 : p_n
        U(ind(i),i) = 1;                           
    end
    % ���¼����������
    for j = 1 : c_n                          
        Cluster(j) = {find(ind == j)};
        ClusterSize = size(Cluster{j},2);
        MeanMD_min = 1;
        % �ҵ�ͬһ������������������ƽ��MD������̵Ĺ���
        for i = Cluster{j}
            cluster_tmp = Cluster{j};
            cluster_tmp(cluster_tmp==i) = [];
            MeanMD_temp = sum(MD(i,cluster_tmp)) / (ClusterSize-1);       % ����ù�����ͬһ����������������ƽ��MD����
            if MeanMD_min > MeanMD_temp
                MeanMD_min = MeanMD_temp;
                center_tmp(j) = i;                % �¾�������
            end
        end
    end
    k = k + 1;
    fprintf('Iteration count = %d\n', k);
    center_error = center-center_tmp;
    NoChange = sum(center_error);                 % ����flag
    center = center_tmp;                          % ���¾�������
end
% cal obj_fcn
% for j = 1 : c_n
%     MD(center(j),Cluster{j});
% end
    
end