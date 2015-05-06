function PM = MakespanClustering(T,Instance_n,centerNum)
%% Makespan clustering algorithm
%
%%
if nargin ~= 3
    error('Too many or too few input arguments!');
end

p = path;
path(p, genpath(pwd));            % 加载本地搜索目录

% Makespan聚类
Makespan = sum(T,2);              % 计算Makespan

[P_n, M_n] = size(T);
fprintf('Start clustering on Makespan: \n');
[center,U,obj_fcn] = fcm(Makespan,centerNum);     % Cluster Makespan
% Find the data points with highest grade of membership in each cluster
% maxU = max(U);
% Cluster = cell(centerNum,1);
% for i = 1 : centerNum
%     indTmp = find(U(i,:) == maxU);
%     Cluster(i) = {indTmp};
% end

% or
maxU = max(U);
Cluster = zeros(P_n,centerNum);
for i = 1 : centerNum
    index = U(i,:) == maxU;
    Cluster(:,i) = index';
end

% 计算每个实例中工件的该特征属于各聚类中心的平均隶属度
p_n = P_n / Instance_n;
PM = zeros(Instance_n,centerNum);
for k = 1 : Instance_n
    PM(k,:) = sum(U(:,(k-1)*p_n+1:k*p_n),2)' ./ p_n;
end

path(p);
end
