function PD = SlackClustering(T,Instance_n,centerNum)
%% Slack clustering algorithm
% 
%%
if nargin ~= 3
    error('Too many or too few input arguments!');
end

p = path;
path(p, genpath(pwd));

% ���㽻���ɽ���
[P_n,M_n] = size(T);
% cal delivery date
R = zeros(P_n,1);                 % initalize release time
Makespan = sum(T,2);              % cal total process time
Beta = 1.5;                       % slack coefficient
D = R + Makespan .* Beta;         % delivery date

% Slack�����ɽ��Ⱦ���
S = D - Makespan;                 % cal slack
fprintf('Start clustering on Slack: \n');
[center,U,obj_fcn] = fcm(S,centerNum);
% Find the data points with highest grade of membership in each cluster
maxU = max(U);
Cluster = cell(centerNum);
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

% ����ÿ��ʵ���й����ĸ��������ڸ��������ĵ�ƽ��������
p_n = P_n / Instance_n;
PD = zeros(Instance_n,centerNum);
for k = 1 : Instance_n
    PD(k,:) = sum(U(:,(k-1)*p_n+1:k*p_n),2)' ./ p_n;
end

path(p);
                           
end