%对beta进行正态分布拟合
clear;clc;

xlsFileName='fitResult.xlsx';
sheetNo=1;
xlRange='A1:A466';

beta=xlsread(xlsFileName,sheetNo,xlRange);

sheetNo = 1;
%-----------------------------区间估计------------------------------------------

alpha=0.05; %1-alpha:置信度
n=size(beta,1);   %样本数
Xba=mean(beta);   %样本均值
Sn=var(beta);     %样本标准差

t1= tinv(1-alpha/2,n-1); %t分位点

chi1=chi2inv(1-alpha/2,n-1);  %chi2第1个分位点
chi2=chi2inv(alpha/2,n-1);  %chi2第2个分位点

MUInterval=[Xba-Sn*t1*n^-0.5,Xba+Sn*t1*n^-0.5];
SigmaInterval=[(n-1)^0.5*Sn*(chi1)^-0.5,(n-1)^0.5*Sn*(chi2)^-0.5];
%disp(MUInterval);
%disp(SigmaInterval);

Mu=0.5*(MUInterval(1)+MUInterval(2)); %均值
Sigma=Mu*(SigmaInterval(1)+SigmaInterval(2));  %标准差
%----------------------------------------------------------------------------

[f,xi] = ksdensity(beta);
figure
plot(xi,f,...
    'b',...    %颜色     
    'LineWidth',2);
hold on;


[muhat,sigmahat] = normfit(beta);   %最大似然估计所得mu和sigma
y1=normpdf(xi,muhat,sigmahat);
plot(xi,y1,...
    'r',...
    'LineWidth',2);

%text(muhat,37,' \rightarrow 正弦');

hold on;

barPercent=0.2; %Set the width of each bar to barPercent percent of the total space available for each bar
bar(xi,f,barPercent,'FaceColor',[96 96 96]/255)     %灰色

legend('实测概率分布','最大似然估计拟合正态分布')

xlabel('损伤指标','FontName','仿宋','FontSize',12); %设置x轴和y轴的名称
ylabel('P','FontName','仿宋','FontSize',12); 

%--------------------------
x_=xi;
y_=f;
for i=1:size(xi,2)
% 梯形积分法
    if f(i)-y1(i)>0
        y_(i)=y1(i);
    end
end
s = trapz(x_,y_);
disp(['重合度:' num2str(s)]);

disp(['离散beta值变异系数：' num2str(std(beta)./mean(beta))]); 
disp(['拟合后的概率密度函数变异系数：' num2str(sigmahat./muhat)]);

