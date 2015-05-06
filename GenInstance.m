%% [T,Jm,M] = GenInstance(PNumber,MNumber,InsNumber)
% ����˵��������ʵ���������롣ʹ����ɢ���ȷֲ����ɼӹ�����ʱ��͹����ӹ�������
% ���������
%           PNumber       - ��������
%           MNumber       - ������ÿ��������������
%           InsNumber     - ʵ����
% ���������
%           T             - ������������ʹ�õ�ʱ����󼯺ϣ�[1,100]��ľ��ȷֲ�
%           Jm            - ������������ʹ�õĻ������󼯺�
%           M             - �������鲢�л�̨��,[10,20]��ľ��ȷֲ�
%%
function [T,Jm,M] = GenInstance(PNumber,MNumber,InsNumber)

if nargin ~= 3
    error('Too many or too few input arguments!');
end

T = zeros(PNumber,MNumber,InsNumber);
Jm = zeros(PNumber,MNumber,InsNumber);
M = zeros(1,MNumber,InsNumber);
for i = 1 : InsNumber
    % ����ʱ�����
    t = unidrnd(100,PNumber,MNumber);           % ��ɢ����ֲ�
    T(:,:,i) = t;
    % �������
    jm = zeros(PNumber,MNumber);
    for j = 1 : PNumber                         % ��������
        jmTemp =zeros(1,MNumber);
        for k = 1 : MNumber                     % ��������
            jmVal = unidrnd(MNumber);
            while(jmTemp(1,jmVal) == 1)         % �жϸû������Ƿ��ѱ�����
                jmVal = unidrnd(MNumber);
            end
            jm(j,k) = jmVal;
            jmTemp(1,jmVal) = 1;                % ����ѷ���Ļ�����
        end
    end
    Jm(:,:,i) = jm;
    % ��������
    m = zeros(MNumber,1);
    for j = 1 : MNumber
        m(j) = 10 + unidrnd(10);
    end
    M(:,:,i) = m;
end


end
