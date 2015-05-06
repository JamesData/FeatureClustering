%% [T,Jm,M] = GenInstance(PNumber,MNumber,InsNumber)
% 功能说明：生成实例，非重入。使用离散均匀分布生成加工工序时间和工件加工机器号
% 输入参数：
%           PNumber       - 工件数量
%           MNumber       - 机器或每个工件工序数量
%           InsNumber     - 实例数
% 输出参数：
%           T             - 各工件各工序使用的时间矩阵集合，[1,100]间的均匀分布
%           Jm            - 各工件各工序使用的机器矩阵集合
%           M             - 各机器组并行机台数,[10,20]间的均匀分布
%%
function [T,Jm,M] = GenInstance(PNumber,MNumber,InsNumber)

if nargin ~= 3
    error('Too many or too few input arguments!');
end

T = zeros(PNumber,MNumber,InsNumber);
Jm = zeros(PNumber,MNumber,InsNumber);
M = zeros(1,MNumber,InsNumber);
for i = 1 : InsNumber
    % 工序时间矩阵
    t = unidrnd(100,PNumber,MNumber);           % 离散随机分布
    T(:,:,i) = t;
    % 工序矩阵
    jm = zeros(PNumber,MNumber);
    for j = 1 : PNumber                         % 工件遍历
        jmTemp =zeros(1,MNumber);
        for k = 1 : MNumber                     % 机器遍历
            jmVal = unidrnd(MNumber);
            while(jmTemp(1,jmVal) == 1)         % 判断该机器号是否已被分配
                jmVal = unidrnd(MNumber);
            end
            jm(j,k) = jmVal;
            jmTemp(1,jmVal) = 1;                % 标记已分配的机器号
        end
    end
    Jm(:,:,i) = jm;
    % 机器矩阵
    m = zeros(MNumber,1);
    for j = 1 : MNumber
        m(j) = 10 + unidrnd(10);
    end
    M(:,:,i) = m;
end


end
