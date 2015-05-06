%% function MD = calMD(T,Jm)
% 功能说明：    计算MD(Macroscopic Distance)距离
% 输入参数：
%        T     工件加工时间矩阵
%        R     工件释放时间矩阵
% 输出参数:
%        MD    MD距离矩阵
%%
function MD = calMD(T,Jm)
% 初始化
[PNumber, MNumber] = size(T);
MD = zeros(PNumber,PNumber);                   % MD矩阵
Ind = zeros(PNumber,MNumber);                  % 操作绝对位置(序号)矩阵
Len = MNumber;                                 % 总操作数
pos = zeros(PNumber,MNumber);                  % 操作相对位置矩阵
d = zeros(PNumber,PNumber,MNumber);            % 操作相对位置之差矩阵

for k = 1 : MNumber
    % 操作相对位置
    for i = 1 : PNumber
        [row,col] = find(Jm==k);
%         if numel(row)==0,break;end;
        pNum = row(i);                 % 工件号
        Ind(pNum,k) = col(i);
        pos(pNum,k) = col(i) ./ Len;
    end
    % 操作相对位置之差
    for i = 1: PNumber
        for j = 1 : PNumber
            d(i,j,k) = abs(pos(i,k)-pos(j,k));
        end
    end
end
% 最大距离
for i = 1 : PNumber
    for j = 1 : PNumber
        MD(i,j) = max(d(i,j,:));
    end
end

end