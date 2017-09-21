%
%功能：求给定alpha的置信区间
%方差未知的情况下，求MU,Sigma的置信区间

%参考资料：
%1、《概率论与数理统计》 曹振华 赵平 P188-193
clear;clc;

alpha=0.05; %

xlsxFileName='fitResult';

sheetNo = 1;
xlRange = 'A1:A466';

Sample = xlsread(xlsxFileName,sheetNo,xlRange);


n=size(Sample,1);   %样本数

Xba=mean(Sample);   %样本均值

Sn=var(Sample);     %样本标准差

t1= tinv(1-alpha/2,n-1); %t分位点

chi1=chi2inv(1-alpha/2,n-1);  %chi2第1个分位点
chi2=chi2inv(alpha/2,n-1);  %chi2第2个分位点

MUInterval=[Xba-Sn*t1*n^-0.5,Xba+Sn*t1*n^-0.5];
SigmaInterval=[(n-1)^0.5*Sn*(chi1)^-0.5,(n-1)^0.5*Sn*(chi2)^-0.5];
disp(MUInterval);
disp(SigmaInterval);
