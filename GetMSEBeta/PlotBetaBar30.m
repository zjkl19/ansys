%������ָ����״ͼ
clear;clc;

fixOption=0;    %�Ƿ���������ָ����״ͼ
                %0��ʾ��������1��ʾ����
barXlabel='��Ԫ���';   %x������
barYlabel='����ָ��';   %y������

tickFontName='Times New Roman';
tickFontSize=18;
xlabelFontName='����';
ylabelFontName='����';
xlabelFontSize=18;
ylabelFontSize=18;

ytickSet=[-0.05 0 0.05 0.10 0.15 0.20 0.25 030 0.35 0.40 0.45];    %y������̶�

beta=[4.29E-01
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
0.00E+00
];  %����Ԫbeta
barWidth=0.6;
barData=beta;
if fixOption~=0
    fixbeta=beta-min(beta);
    barData=fixbeta;
end

bar(barData,barWidth);  

legendTitle='beta';

for i=1:size(beta,1)
    xTickLabel{i}=num2str(i);
end

xTickScaleLimit=30;
if size(beta,1)>xTickScaleLimit
    for i=2:size(beta,1)
        if mod(i-1,10)~=0
            xTickLabel{i}=' ';
        end
    end
end


set(gca,'ticklength',[0 0]);    %����x,y��Ŀ̶ȳ���Ϊ0

xlim([0 size(beta,1)]);    
xTick=1:size(beta,1);

set(gca,'FontName',tickFontName,'xtick',xTick,'XTickLabel',xTickLabel,'FontSize',tickFontSize); %����x���������ʱ��

ylimScale=0.2*(max(beta)-min(beta));
ylim([min(beta)-ylimScale max(beta)+ylimScale]);
set(gca,'ytick',ytickSet);
set(gca,'FontName',tickFontName,'xtick',xTick,'XTickLabel',xTickLabel,'FontSize',tickFontSize); %����x���������ʱ��


xlabel(barXlabel,'FontName',xlabelFontName,'FontSize',xlabelFontSize); %����x���y�������
ylabel(barYlabel,'FontName',ylabelFontName,'FontSize',ylabelFontSize); 

legend(legendTitle); %����һ����ɫ�ͺ�ɫ�ֱ����ʲô
legend('hide');
%legend('show');