%������ָ����״ͼ
clear;clc;

fixOption=1;    %�Ƿ���������ָ����״ͼ
                %0��ʾ��������1��ʾ����

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
];  %����Ԫbeta
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

set(gca,'XTickLabel',xTickLabel); %����x���������ʱ��
xlabel('��Ԫ���'),ylabel('ģ̬Ӧ���ܱ仯��'); %����x���y�������
legend(legendTitle); %����һ����ɫ�ͺ�ɫ�ֱ����ʲô
