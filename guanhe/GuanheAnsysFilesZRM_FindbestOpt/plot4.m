%功能：作出4张子图
clear;clc;

figure (1) 

barData=load('beta.txt');

for i=1:101
    xTickLabel{i}=num2str(i);
end

xTickScaleLimit=30;
if 101>xTickScaleLimit
    for i=2:101
        if mod(i-1,10)~=0
            xTickLabel{i}=' ';
        end
    end
end

tickFontName='Times New Roman';
tickFontSize=12;

barXlabel='单元编号';   %x轴名称
barYlabel='损伤指标';   %y轴名称

%barWidth=0.9;
%%
subplot(2,2,1), hold('on')

title('beta')

bar(barData(:,1),0.9);

xlim([0 101]);    
xTick=1:101;
set(gca,'ticklength',[0 0]);    %设置x,y轴的刻度长度为0
set(gca,'FontName',tickFontName,'xtick',xTick,'XTickLabel',xTickLabel,'FontSize',tickFontSize); %设置x轴所代表大时间

xlabel('单元编号','FontName','仿宋','FontSize',12); %设置x轴和y轴的名称
ylabel('损伤指标','FontName','仿宋','FontSize',12); 

subplot(2,2,2),  hold('on')
G=bar(barData(2,:)); set(G,'linewidth',0.9), xlabel(sprintf('单元编号')), ylabel('损伤指标'), title('(b)竖向二阶')
%%
subplot(2,2,3),  hold('on')
G=bar(t(:,3),X111(:,3),'k'); set(G,'linewidth',0.9), xlabel(sprintf('单元编号')), ylabel('损伤指标'), title('(c)竖向三阶')
%%
subplot(2,2,4), hold('on')
G=bar(t(:,4),X111(:,4),'k'); set(G,'linewidth',0.9), xlabel(sprintf('单元编号')), ylabel('损伤指标'), title('(d)竖向四阶')
