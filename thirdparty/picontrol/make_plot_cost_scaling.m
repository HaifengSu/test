clear;

T = 700;
dT = 20;
vN = [1000, 7000];

files{1,2} = {'test_results/cost_1_2014-11-12_15:40:06.csv','test_results/cost_1_2014-11-12_15:37:43.csv','test_results/cost_1_2014-11-12_15:35:21.csv',};
files{1,4} = {'test_results/cost_1_2014-11-12_15:42:29.csv','test_results/cost_1_2014-11-12_15:44:52.csv','test_results/cost_1_2014-11-12_15:54:26.csv',...
    'test_results/cost_1_2014-11-12_16:49:28.csv','test_results/cost_1_2014-11-12_16:51:51.csv',...
    'test_results/cost_1_2014-11-12_16:54:14.csv','test_results/cost_1_2014-11-12_16:56:37.csv',...
    'test_results/cost_1_2014-11-12_16:59:00.csv'};
files{1,6} = {'test_results/cost_1_2014-11-12_15:54:26.csv',...
    'test_results/cost_1_2014-11-12_17:01:23.csv','test_results/cost_1_2014-11-12_17:03:47.csv',...
    'test_results/cost_1_2014-11-12_17:06:10.csv',...
    'test_results/cost_1_2014-11-12_17:10:58.csv','test_results/cost_1_2014-11-12_17:13:21.csv',...
    'test_results/cost_1_2014-11-12_17:18:09.csv'};
files{1,8} = {'test_results/cost_1_2014-11-12_16:01:39.csv','test_results/cost_1_2014-11-12_15:59:14.csv','test_results/cost_1_2014-11-12_15:56:50.csv',...
    'test_results/cost_1_2014-11-12_17:18:09.csv','test_results/cost_1_2014-11-12_17:20:33.csv',...
    'test_results/cost_1_2014-11-12_17:22:57.csv','test_results/cost_1_2014-11-12_17:25:21.csv',...
    'test_results/cost_1_2014-11-12_17:27:46.csv','test_results/cost_1_2014-11-12_17:30:10.csv',...
    'test_results/cost_1_2014-11-12_17:32:34.csv'};
files{1,10} = {'test_results/cost_1_2014-11-12_16:08:52.csv','test_results/cost_1_2014-11-12_16:06:28.csv','test_results/cost_1_2014-11-12_16:04:03.csv',...
    'test_results/cost_1_2014-11-12_17:34:59.csv','test_results/cost_1_2014-11-12_17:37:24.csv',...
    'test_results/cost_1_2014-11-12_17:39:48.csv','test_results/cost_1_2014-11-12_17:42:13.csv',...
    'test_results/cost_1_2014-11-12_17:44:38.csv','test_results/cost_1_2014-11-12_17:47:02.csv',...
    'test_results/cost_1_2014-11-12_17:49:27.csv'};

files{2,2} = {'test_results/cost_1_2014-11-12_20:05:36.csv','test_results/cost_1_2014-11-12_19:05:58.csv','test_results/cost_1_2014-11-12_18:53:59.csv','test_results/cost_1_2014-11-12_18:42:00.csv','test_results/cost_1_2014-11-12_18:30:02.csv','test_results/cost_1_2014-11-12_18:18:04.csv','test_results/cost_1_2014-11-12_18:06:05.csv','test_results/cost_1_2014-11-12_17:54:06.csv','test_results/cost_1_2014-11-12_17:28:12.csv','test_results/cost_1_2014-11-12_17:30:09.csv','test_results/cost_1_2014-11-12_17:42:08.csv'};
files{2,4} = {'test_results/cost_1_2014-11-12_20:07:59.csv',...
    'test_results/cost_1_2014-11-12_19:08:21.csv',...
    'test_results/cost_1_2014-11-12_18:56:22.csv',...
    'test_results/cost_1_2014-11-12_18:44:24.csv',...
    'test_results/cost_1_2014-11-12_18:32:25.csv',...
    'test_results/cost_1_2014-11-12_18:08:28.csv','test_results/cost_1_2014-11-12_17:56:29.csv','test_results/cost_1_2014-11-12_17:32:32.csv','test_results/cost_1_2014-11-12_17:44:31.csv'};
files{2,6} = {'test_results/cost_1_2014-11-12_20:10:23.csv','test_results/cost_1_2014-11-12_19:10:45.csv','test_results/cost_1_2014-11-12_18:58:46.csv','test_results/cost_1_2014-11-12_18:46:47.csv','test_results/cost_1_2014-11-12_18:34:49.csv','test_results/cost_1_2014-11-12_18:22:50.csv','test_results/cost_1_2014-11-12_18:10:52.csv','test_results/cost_1_2014-11-12_17:58:53.csv','test_results/cost_1_2014-11-12_17:34:56.csv','test_results/cost_1_2014-11-12_17:46:54.csv'};
files{2,8} = {'test_results/cost_1_2014-11-12_20:00:48.csv',...
    'test_results/cost_1_2014-11-12_19:01:11.csv',...
    'test_results/cost_1_2014-11-12_18:49:12.csv',...
    'test_results/cost_1_2014-11-12_18:37:13.csv',...
    'test_results/cost_1_2014-11-12_18:13:16.csv','test_results/cost_1_2014-11-12_18:01:17.csv','test_results/cost_1_2014-11-12_17:37:20.csv','test_results/cost_1_2014-11-12_17:49:19.csv'};
files{2,10} = {'test_results/cost_1_2014-11-12_20:03:13.csv','test_results/cost_1_2014-11-12_19:03:35.csv','test_results/cost_1_2014-11-12_18:51:36.csv','test_results/cost_1_2014-11-12_18:39:38.csv','test_results/cost_1_2014-11-12_18:27:39.csv','test_results/cost_1_2014-11-12_18:15:41.csv','test_results/cost_1_2014-11-12_18:03:42.csv','test_results/cost_1_2014-11-12_17:39:45.csv','test_results/cost_1_2014-11-12_17:51:43.csv'};

vU = 2:2:10;
ms = zeros(2,numel(vU));
ss = zeros(2,numel(vU));
mc = zeros(2,numel(vU));
sc = zeros(2,numel(vU));
for n = 1:2
    for u = 1:numel(vU)
        [s{n,u} c{n,u}] = get_costs(files{n,vU(u)},T,1:numel(files{n,vU(u)}));%:numel(files2));
        ms(n,u) = mean(mean(s{n,u}(:,T-dT:T),2));
        ss(n,u) = mean(std(s{n,u}(:,T-dT:T),0,2));
        mc(n,u) = mean(mean(c{n,u}(:,T-dT:T),2));
        sc(n,u) = std(std(c{n,u}(:,T-dT:T),0,2));
    end
end

hn=figure(2);
% set(hn,'PaperType','A4'); 
% set(hn,'PaperOrientation','portrait');
% set(hn,'PaperUnits','centimeters');
% set(hn,'PaperPosition',[0 0 20 15]);
fontsize = 18;

vX = vU;
subplot(2,2,2);
A=shadedErrorBar(vX,-ms(2,:),ss(2,:),'.b');
hold on;
B=shadedErrorBar(vX,-ms(1,:),ss(1,:),'.r');
xlabel('# quadrotors');
ylabel('state cost');
grid on;
set(gca,'box','on');
set(gca,'fontsize',fontsize);

subplot(2,2,4);
A=shadedErrorBar(vX,mc(2,:),sc(2,:),'b');
hold on;
B=shadedErrorBar(vX,mc(1,:),sc(1,:),'r');
xlabel('# quadrotors','fontsize',fontsize);
ylabel('control cost','fontsize',fontsize);
grid on;
set(gca,'box','on');

saveas(hn,'costs_scaling.eps','psc2');
