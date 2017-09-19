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

ytickSet=[-0.10 0 0.10  0.20 0.30 0.40 0.50];    %y������̶�

beta=[-0.021014493
-0.021063536
-0.021016431
-0.020969856
-0.020725389
-0.020905923
-0.021014074
-0.020957648
-0.020849949
-0.021100917
-0.020423601
-0.020952381
-0.021126761
-0.021077283
-0.020901639
-0.021006882
-0.020994832
-0.020905923
-0.020773074
-0.020848311
-0.020874533
-0.020664506
-0.020649521
-0.02079329
-0.020748244
-0.020705521
-0.020667727
-0.020639694
-0.020625243
-0.02050142
-0.020521288
-0.020445047
-0.020503363
-0.020476389
-0.02047816
-0.020507813
-0.019905213
-0.020276498
-0.019766397
-0.020193152
-0.020618557
-0.020236088
-0.019900498
-0.020424837
-0.02016129
-0.019952115
-0.019778481
-0.020424195
-0.020328382
-0.020265004
0.39953271
-0.020265004
-0.020328382
-0.020424195
-0.019778481
-0.019952115
-0.02016129
-0.020424837
-0.019900498
-0.020236088
-0.020618557
-0.020193152
-0.019766397
-0.020276498
-0.019905213
-0.020507813
-0.02047816
-0.020476389
-0.020503363
-0.020445047
-0.020521288
-0.02050142
-0.020625243
-0.020639694
-0.020667727
-0.020705521
-0.020748244
-0.02079329
-0.020649521
-0.020664506
-0.020874533
-0.020848311
-0.020773074
-0.020905923
-0.020994832
-0.021006882
-0.020901639
-0.021077283
-0.021126761
-0.020952381
-0.020423601
-0.021100917
-0.020849949
-0.020957648
-0.021014074
-0.020905923
-0.020725389
-0.020969856
-0.021016431
-0.021063536
-0.021014493
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

ylimScale=0.25*(max(beta)-min(beta));
ylim([min(beta)-ylimScale max(beta)+ylimScale]);
set(gca,'ytick',ytickSet);
set(gca,'FontName',tickFontName,'xtick',xTick,'XTickLabel',xTickLabel,'FontSize',tickFontSize); %����x���������ʱ��


xlabel(barXlabel,'FontName',xlabelFontName,'FontSize',xlabelFontSize); %����x���y�������
ylabel(barYlabel,'FontName',ylabelFontName,'FontSize',ylabelFontSize); 

legend(legendTitle); %����һ����ɫ�ͺ�ɫ�ֱ����ʲô
legend('hide');
%legend('show');