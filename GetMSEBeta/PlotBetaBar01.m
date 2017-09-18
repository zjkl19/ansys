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

ytickSet=[-0.01 0 0.01 0.02 0.03 0.04 0.05];    %y轴坐标刻度

beta=[5.19E-02
-7.49E-04
-7.05E-04
-7.47E-04
-4.72E-04
-1.00E-03
-7.65E-04
-8.27E-04
-8.80E-04
-7.80E-04
-8.61E-04
-8.18E-04
-8.02E-04
-8.11E-04
-8.47E-04
-7.61E-04
-8.51E-04
-7.91E-04
-9.63E-04
-9.30E-04
-8.58E-04
-1.31E-03
-8.23E-04
-8.37E-04
-1.07E-03
0.00E+00
-5.29E-04
-6.90E-04
-8.58E-04
-5.23E-04
-1.08E-03
-8.13E-04
-8.68E-04
-7.30E-04
-8.01E-04
-7.30E-04
-8.26E-04
-8.04E-04
-8.07E-04
-8.36E-04
-7.45E-04
-6.60E-04
-7.59E-04
-9.13E-04
-8.68E-04
-7.85E-04
-1.17E-03
-9.97E-04
-8.64E-04
-8.02E-04
-8.28E-04
0.00E+00
-6.48E-04
0.00E+00
-1.17E-03
-7.85E-04
-8.68E-04
-6.85E-04
-7.59E-04
-6.60E-04
-7.45E-04
-8.36E-04
-8.07E-04
-8.04E-04
-8.26E-04
-7.30E-04
-8.01E-04
-7.30E-04
-8.68E-04
-8.13E-04
-1.08E-03
-5.23E-04
-8.58E-04
-6.90E-04
-5.29E-04
-5.92E-04
-8.05E-04
-5.58E-04
-7.05E-04
-6.57E-04
-8.58E-04
-9.30E-04
-7.23E-04
-7.91E-04
-8.51E-04
-7.61E-04
-8.47E-04
-8.11E-04
-8.02E-04
-8.18E-04
-8.61E-04
-7.80E-04
-8.80E-04
-8.27E-04
-7.65E-04
-1.00E-03
-4.72E-04
-7.47E-04
-7.05E-04
-7.49E-04
-7.78E-04
];  %各单元beta
barWidth=0.4;
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