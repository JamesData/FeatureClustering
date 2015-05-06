%% D = calDeliveryDate(i,T,R)
% 功能说明：    计算交货期
% 输入参数：
%        i     第i个工件
%        T     工件加工时间矩阵      
%        R     工件释放时间矩阵
% 输出参数:
%        D     交货期
%%
function d = calDeliveryDate(i,T,R)
% t = 1096;
[~,MNumber] = size(T);

% 计算各工件总加工时间
TTime(i) = 0;
for j = 1 : MNumber
    TTime(i) = TTime(i) + T(i,j);
end
f = 1.5;                              % 交货期松紧系数

d = R(i) + f * TTime(i);   
end