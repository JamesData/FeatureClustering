function PP = MDClustering(T,Jm,Instance_n,centerNum)
%% MD clustering algorithm
%
%%
if nargin ~= 4
    error('Too many or too few input arguments!');
end

p = path;
path(p, genpath(pwd));


% 计算MD距离
MD = calMD(T,Jm);

% MD聚类
% 归一化
maxMD = max(max(MD));
[P_n,~] = size(MD);
for i = 1 : P_n
    MD(i,i) = 1;
end
minMD = min(min(MD));
L = maxMD - minMD;
MD = abs(MD - minMD .* ones(P_n)) ./ L;
for i = 1 : P_n
    MD(i,i) = 0;
end

fprintf('Start clustering on MD: \n');
[center,U,obj_fcn] = MDFCM(MD,centerNum);
% Find the data points with highest grade of membership in each cluster
maxU = max(U);
Cluster = cell(centerNum,1);
for i = 1 : centerNum
    indTmp = find(U(i,:) == maxU);
    Cluster(i) = {indTmp};
end

% % or
% maxU = max(U);
% Cluster = zeros(P_n,centerNum);
% for i = 1 : centerNum
%     index = U(i,:) == maxU;
%     Cluster(:,i) = index';
% end

% 计算每个实例中工件的该特征属于各聚类中心的平均隶属度
p_n = P_n / Instance_n;
PP = zeros(Instance_n,centerNum);
for k = 1 : Instance_n
    PP(k,:) = sum(U(:,(k-1)*p_n+1:k*p_n),2)' ./ p_n;
end

path(p);
end                             