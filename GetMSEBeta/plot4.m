
figure (1) 
load beta.txt;
%%
subplot(2,2,1), hold('on')
G=bar(barData1,barWidth); 
subplot(2,2,2),  hold('on')
G=bar(t(:,2),X111(:,2),'k'); set(G,'linewidth',0.9), xlabel(sprintf('单元编号')), ylabel('损伤指标'), title('(b)竖向二阶')
%%
subplot(2,2,3),  hold('on')
G=bar(t(:,3),X111(:,3),'k'); set(G,'linewidth',0.9), xlabel(sprintf('单元编号')), ylabel('损伤指标'), title('(c)竖向三阶')
%%
subplot(2,2,4), hold('on')
G=bar(t(:,4),X111(:,4),'k'); set(G,'linewidth',0.9), xlabel(sprintf('单元编号')), ylabel('损伤指标'), title('(d)竖向四阶')
