clear,clc,close all;
data1 = randn(200,1)+3;
data2 = randn(200,1)+7;
data(1:100,1:2) = [data1(1:100),data2(1:100)];
data(101:200,1:2) = [data2(101:200),data1(101:200)];


centerNum = 2;
[center,U,obj_fcn] = fcm(data,centerNum);

% Find the data points with highest grade of membership in each cluster
maxU = max(U);
index = cell(centerNum);
for i =1 : centerNum
    indTmp = find(U(i,:) == maxU);
    index(i) = {indTmp};
    colorRGB = [1 i i] .* 0.3;                 % ensure colorRGB less than [1 1 1]
    line(data(index{i},1),data(index{i},2),'lineStyle', 'none','marker', 'o','color', colorRGB);
end

% Plot the cluster centers
line(center(:,1),center(:,2),'lineStyle', 'none','markersize',10,'marker', '*','color', 'r');