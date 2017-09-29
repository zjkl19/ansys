%
%���ܣ������alpha����������
%����δ֪������£���MU,Sigma����������

%�ο����ϣ�
%1����������������ͳ�ơ� ���� ��ƽ P188-193
clear;clc;

alpha=0.05; %

xlsxFileName='fitResult';

sheetNo = 1;
xlRange = 'A1:A466';

Sample = xlsread(xlsxFileName,sheetNo,xlRange);


n=size(Sample,1);   %������

Xba=mean(Sample);   %������ֵ

Sn=var(Sample);     %������׼��

t1= tinv(1-alpha/2,n-1); %t��λ��

chi1=chi2inv(1-alpha/2,n-1);  %chi2��1����λ��
chi2=chi2inv(alpha/2,n-1);  %chi2��2����λ��

MUInterval=[Xba-Sn*t1*n^-0.5,Xba+Sn*t1*n^-0.5];
SigmaInterval=[(n-1)^0.5*Sn*(chi1)^-0.5,(n-1)^0.5*Sn*(chi2)^-0.5];
disp(MUInterval);
disp(SigmaInterval);
