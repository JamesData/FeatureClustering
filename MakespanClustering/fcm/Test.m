clear,clc,close all;
tic;
% % 1. 1 dimension
% data = rand(100,1);

% % 2. 2 dimension
% data = rand(100,2);

% 3. load data
load('data1.mat','data');

[dataNum,dataDim] = size(data);

centerNum = 3;
% options = [2;	             % exponent for the partition matrix U
%     200;	                 % max. number of iteration
%     1e-5;	                 % min. amount of improvement
%     1];	                     % info display during iteration
% [center,U,obj_fcn] = fcm(data,centerNum,options);
[center,U,obj_fcn] = fcm(data,centerNum);

% plot 2 dimension graph
plot(data(:,1), data(:,2),'o');
hold on;

% Find the data points with highest grade of membership in each cluster
maxU = max(U);
index = cell(centerNum);
for i =1 : centerNum
    indTmp = find(U(i,:) == maxU);
    index(i) = {indTmp};
    colorRGB = [1 i i] .* 0.2;                 % ensure colorRGB less than [1 1 1]
    line(data(index{i},1),data(index{i},2),'marker', '.','color', colorRGB);
end

% Plot the cluster centers
plot(center(:,1),center(:,2),'*','color','r')
hold off;

toc