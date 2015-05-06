%% [center,U,obj_fcn] = MDFCM(MD,cluster_n)
% 功能说明：对工艺路径特征——MD距离进行聚类，采用改进k均值聚类算法
% 输入参数：
%           MD           - MD距离矩阵
%           c_n          - 聚类中心数
% 输出参数：
%           center       - 聚类中心（矩阵）
%           U            - 划分矩阵
%           obj_fcn      - 目标函数（值）
%%
function [center,U,obj_fcn] = MDFCM(MD,c_n)
[p_n,~] = size(MD);

% init
obj_fcn = 0;                                       % 初始化目标函数值
center = unidrnd(p_n,c_n,1);                       % 初始化聚类中心
Cluster = cell(c_n,1);                             % 初始化各聚类集合
NoChange = 1;                                      % flag，判断是否停止循环
k = 0;                                             % 初始化迭代计数变量
while(NoChange ~= 0)
    center_tmp = center;
    [MD_min,ind] = min(MD(center_tmp,:));          % 将工件划分至各个聚类中
    U = zeros(c_n,p_n);                            % 初始划分矩阵
    % 计算划分矩阵
    for i = 1 : p_n
        U(ind(i),i) = 1;                           
    end
    % 重新计算聚类中心
    for j = 1 : c_n                          
        Cluster(j) = {find(ind == j)};
        ClusterSize = size(Cluster{j},2);
        MeanMD_min = 1;
        % 找到同一聚类内与其他工件的平均MD距离最短的工件
        for i = Cluster{j}
            cluster_tmp = Cluster{j};
            cluster_tmp(cluster_tmp==i) = [];
            MeanMD_temp = sum(MD(i,cluster_tmp)) / (ClusterSize-1);       % 计算该工件与同一聚类内其他工件的平均MD距离
            if MeanMD_min > MeanMD_temp
                MeanMD_min = MeanMD_temp;
                center_tmp(j) = i;                % 新聚类中心
            end
        end
    end
    k = k + 1;
    fprintf('Iteration count = %d\n', k);
    center_error = center-center_tmp;
    NoChange = sum(center_error);                 % 更新flag
    center = center_tmp;                          % 更新聚类中心
end
% cal obj_fcn
% for j = 1 : c_n
%     MD(center(j),Cluster{j});
% end
    
end