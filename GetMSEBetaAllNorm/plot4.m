%���ܣ�����4����ͼ
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

barXlabel='��Ԫ���';   %x������
barYlabel='����ָ��';   %y������

%barWidth=0.9;
%%
subplot(2,2,1), hold('on')

title('beta')

bar(barData(:,1),0.9);

xlim([0 101]);    
xTick=1:101;
set(gca,'ticklength',[0 0]);    %����x,y��Ŀ̶ȳ���Ϊ0
set(gca,'FontName',tickFontName,'xtick',xTick,'XTickLabel',xTickLabel,'FontSize',tickFontSize); %����x���������ʱ��

xlabel('��Ԫ���','FontName','����','FontSize',12); %����x���y�������
ylabel('����ָ��','FontName','����','FontSize',12); 

subplot(2,2,2),  hold('on')
G=bar(barData(2,:)); set(G,'linewidth',0.9), xlabel(sprintf('��Ԫ���')), ylabel('����ָ��'), title('(b)�������')
%%
subplot(2,2,3),  hold('on')
G=bar(t(:,3),X111(:,3),'k'); set(G,'linewidth',0.9), xlabel(sprintf('��Ԫ���')), ylabel('����ָ��'), title('(c)��������')
%%
subplot(2,2,4), hold('on')
G=bar(t(:,4),X111(:,4),'k'); set(G,'linewidth',0.9), xlabel(sprintf('��Ԫ���')), ylabel('����ָ��'), title('(d)�����Ľ�')
