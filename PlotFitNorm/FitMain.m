%��beta������̬�ֲ����
clear;clc;

xlsFileName='fitResult.xlsx';
sheetNo=1;
xlRange='A1:A466';

beta=xlsread(xlsFileName,sheetNo,xlRange);

sheetNo = 1;
%-----------------------------�������------------------------------------------

alpha=0.05; %1-alpha:���Ŷ�
n=size(beta,1);   %������
Xba=mean(beta);   %������ֵ
Sn=var(beta);     %������׼��

t1= tinv(1-alpha/2,n-1); %t��λ��

chi1=chi2inv(1-alpha/2,n-1);  %chi2��1����λ��
chi2=chi2inv(alpha/2,n-1);  %chi2��2����λ��

MUInterval=[Xba-Sn*t1*n^-0.5,Xba+Sn*t1*n^-0.5];
SigmaInterval=[(n-1)^0.5*Sn*(chi1)^-0.5,(n-1)^0.5*Sn*(chi2)^-0.5];
%disp(MUInterval);
%disp(SigmaInterval);

Mu=0.5*(MUInterval(1)+MUInterval(2)); %��ֵ
Sigma=Mu*(SigmaInterval(1)+SigmaInterval(2));  %��׼��
%----------------------------------------------------------------------------

[f,xi] = ksdensity(beta);
figure
plot(xi,f,...
    'b',...    %��ɫ     
    'LineWidth',2);
hold on;


[muhat,sigmahat] = normfit(beta);   %�����Ȼ��������mu��sigma
y1=normpdf(xi,muhat,sigmahat);
plot(xi,y1,...
    'r',...
    'LineWidth',2);

%text(muhat,37,' \rightarrow ����');

hold on;

barPercent=0.2; %Set the width of each bar to barPercent percent of the total space available for each bar
bar(xi,f,barPercent,'FaceColor',[96 96 96]/255)     %��ɫ

legend('ʵ����ʷֲ�','�����Ȼ���������̬�ֲ�')

xlabel('����ָ��','FontName','����','FontSize',12); %����x���y�������
ylabel('P','FontName','����','FontSize',12); 

%--------------------------
x_=xi;
y_=f;
for i=1:size(xi,2)
% ���λ��ַ�
    if f(i)-y1(i)>0
        y_(i)=y1(i);
    end
end
s = trapz(x_,y_);
disp(['�غ϶�:' num2str(s)]);

disp(['��ɢbetaֵ����ϵ����' num2str(std(beta)./mean(beta))]); 
disp(['��Ϻ�ĸ����ܶȺ�������ϵ����' num2str(sigmahat./muhat)]);

