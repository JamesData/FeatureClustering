function PC = MCClustering(M,Instance_n,centerNum)
%% Machine Capability clustering algorithm
% 
%%

p = path;
path(p, genpath(pwd));            % add the current folder to the search path

% �����ӹ���������
fprintf('Start clustering on machine capability: \n');
[center,U,obj_fcn] = fcm(M,centerNum);
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

% ����ÿ��ʵ���и��������ڸ��������ĵ�������
PC = U';

path(p)                           % restore the previous search path   
                            
end
