%作损伤指标柱状图
clear;clc;

fixOption=1;    %是否修正损伤指标柱状图
                %0表示不修正，1表示修正

beta=[-0.034727703
-0.034174125
-0.03407542
-0.033707865
-0.033625219
-0.033415842
-0.0331253
0.074422878
-0.0331253
-0.033415842
-0.033625219
-0.033707865
-0.03407542
-0.034174125
-0.034727703
];  %各单元beta
barWidth=0.2;
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

set(gca,'XTickLabel',xTickLabel); %设置x轴所代表大时间
xlabel('单元编号'),ylabel('模态应变能变化率'); %设置x轴和y轴的名称
legend(legendTitle); %区分一下蓝色和红色分别代表什么
