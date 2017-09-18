%作损伤指标柱状图
clear;clc;

fixOption=0;    %是否修正损伤指标柱状图
                %0表示不修正，1表示修正
barXlabel='单元编号';   %x轴名称
barYlabel='损伤指标';   %y轴名称

tickFontName='Times New Roman';
tickFontSize=18;
xlabelFontName='仿宋';
ylabelFontName='仿宋';
xlabelFontSize=18;
ylabelFontSize=18;

ytickSet=[-0.05 0 0.05 0.10 0.15 0.20 0.25 030 0.35 0.40 0.45];    %y轴坐标刻度

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
];  %各单元beta
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


set(gca,'ticklength',[0 0]);    %设置x,y轴的刻度长度为0

xlim([0 size(beta,1)]);    
xTick=1:size(beta,1);

set(gca,'FontName',tickFontName,'xtick',xTick,'XTickLabel',xTickLabel,'FontSize',tickFontSize); %设置x轴所代表大时间

ylimScale=0.2*(max(beta)-min(beta));
ylim([min(beta)-ylimScale max(beta)+ylimScale]);
set(gca,'ytick',ytickSet);
set(gca,'FontName',tickFontName,'xtick',xTick,'XTickLabel',xTickLabel,'FontSize',tickFontSize); %设置x轴所代表大时间


xlabel(barXlabel,'FontName',xlabelFontName,'FontSize',xlabelFontSize); %设置x轴和y轴的名称
ylabel(barYlabel,'FontName',ylabelFontName,'FontSize',ylabelFontSize); 

legend(legendTitle); %区分一下蓝色和红色分别代表什么
legend('hide');
%legend('show');