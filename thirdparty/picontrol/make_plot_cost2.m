clear;
fontsize = 18;
T = 150;

files10 = {'test_results/cost_2014-11-11_14:24:49.csv','test_results/cost_2014-11-11_14:23:47.csv','test_results/cost_2014-11-11_14:22:46.csv','test_results/cost_2014-11-11_14:20:43.csv'};
[s10 c10] = get_costs(files10,T,1:numel(files10));

files100 = {'test_results/cost_2014-11-11_15:07:39.csv','test_results/cost_2014-11-11_15:06:38.csv','test_results/cost_2014-11-11_15:05:36.csv','test_results/cost_2014-11-11_15:04:35.csv','test_results/cost_2014-11-11_15:03:33.csv','test_results/cost_2014-11-11_15:02:32.csv','test_results/cost_2014-11-11_15:01:31.csv','test_results/cost_2014-11-11_15:00:29.csv','test_results/cost_2014-11-11_14:59:28.csv','test_results/cost_2014-11-11_14:48:06.csv','test_results/cost_2014-11-11_14:47:05.csv','test_results/cost_2014-11-11_14:46:03.csv','test_results/cost_2014-11-11_14:45:02.csv','test_results/cost_2014-11-11_14:40:51.csv','test_results/cost_2014-11-11_14:39:49.csv','test_results/cost_2014-11-11_14:38:48.csv','test_results/cost_2014-11-11_14:37:47.csv','test_results/cost_2014-11-11_14:36:45.csv'};
[s100 c100] = get_costs(files100,T,1:numel(files100));

files1000 = {'test_results/cost_2014-11-11_15:20:13.csv','test_results/cost_2014-11-11_15:18:10.csv','test_results/cost_2014-11-11_15:16:08.csv','test_results/cost_2014-11-11_15:15:06.csv','test_results/cost_2014-11-11_15:14:05.csv','test_results/cost_2014-11-11_14:53:22.csv','test_results/cost_2014-11-11_14:52:20.csv','test_results/cost_2014-11-11_14:51:19.csv','test_results/cost_2014-11-11_14:50:17.csv','test_results/cost_2014-11-11_14:49:16.csv','test_results/cost_2014-11-11_14:30:09.csv','test_results/cost_2014-11-11_14:29:07.csv','test_results/cost_2014-11-11_14:28:06.csv'};
[s1000 c1000] = get_costs(files1000,T,1:numel(files1000));

hn=figure(2);clf;
% set(hn,'PaperType','A4'); 
% set(hn,'PaperOrientation','portrait');
% set(hn,'PaperUnits','centimeters');
% set(hn,'PaperPosition',[0 0 20 15]);

vX=1:T;
subplot(2,2,1);
if size(s100,1)>1
    A=shadedErrorBar(vX,-smooth(mean(s10)),smooth(std(s10)),'b');
    hold on;
    B=shadedErrorBar(vX,-smooth(mean(s100)),smooth(std(s100)),'r',0);
    C=shadedErrorBar(vX,-smooth(mean(s1000)),smooth(std(s1000)),[],0);
    %set(gca,'yscale','log');
    legend([A.mainLine,B.mainLine,C.mainLine],'N=10','N=100','N=1000')
else
    plot(-s100,'b');
end
xlabel('time','fontsize',fontsize);
ylabel('state cost','fontsize',fontsize);
title('5 agents','fontsize',fontsize);
set(gca,'fontsize',fontsize);
grid on;
set(gca,'box','on');
hold on;
axes('position', [.25 .75 .2 .15]);
legend([A.mainLine,B.mainLine,C.mainLine],'N=10','N=100','N=1000','location','best')
A=shadedErrorBar(vX(T-10:end),-mean(s10(:,T-10:end)),std(s10(:,T-10:end)),'b');
hold on;
B=shadedErrorBar(vX(T-10:end),-mean(s100(:,T-10:end)),std(s100(:,T-10:end)),'r',0);
C=shadedErrorBar(vX(T-10:end),-mean(s1000(:,T-10:end)),std(s1000(:,T-10:end)),[],0);
axis tight;
set(gca,'ylim',[100 120]);

subplot(2,2,3);
if size(s100,1)>1
    A=shadedErrorBar([],smooth(mean(c10)),smooth(std(c10)),'b');
    hold on;
    B=shadedErrorBar([],smooth(mean(c100)),smooth(std(c100)),'r',0);
    C=shadedErrorBar([],smooth(mean(c1000)),smooth(std(c1000)),[],0);
    legend([A.mainLine,B.mainLine,C.mainLine],'N=10','N=100','N=1000')
else
    plot(c100,'r');
end
xlabel('time','fontsize',fontsize);
ylabel('control cost','fontsize',fontsize);
title('5 agents','fontsize',fontsize);
set(gca,'fontsize',fontsize);
grid on;
set(gca,'box','on');

saveas(hn,'costs.eps','psc2');
