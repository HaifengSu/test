fontsize = 8;
T = 150;

files10 = {'test_results/cost_2014-11-11_14:24:49.csv','test_results/cost_2014-11-11_14:23:47.csv','test_results/cost_2014-11-11_14:22:46.csv','test_results/cost_2014-11-11_14:20:43.csv'};
[s10 c10] = get_costs(files10,T,1:numel(files10));

files100 = {'test_results/cost_2014-11-11_15:07:39.csv','test_results/cost_2014-11-11_15:06:38.csv','test_results/cost_2014-11-11_15:05:36.csv','test_results/cost_2014-11-11_15:04:35.csv','test_results/cost_2014-11-11_15:03:33.csv','test_results/cost_2014-11-11_15:02:32.csv','test_results/cost_2014-11-11_15:01:31.csv','test_results/cost_2014-11-11_15:00:29.csv','test_results/cost_2014-11-11_14:59:28.csv','test_results/cost_2014-11-11_14:48:06.csv','test_results/cost_2014-11-11_14:47:05.csv','test_results/cost_2014-11-11_14:46:03.csv','test_results/cost_2014-11-11_14:45:02.csv','test_results/cost_2014-11-11_14:40:51.csv','test_results/cost_2014-11-11_14:39:49.csv','test_results/cost_2014-11-11_14:38:48.csv','test_results/cost_2014-11-11_14:37:47.csv','test_results/cost_2014-11-11_14:36:45.csv'};
[s100 c100] = get_costs(files100,T,1:numel(files100));

files1000 = {'test_results/cost_2014-11-11_15:20:13.csv','test_results/cost_2014-11-11_15:18:10.csv','test_results/cost_2014-11-11_15:16:08.csv','test_results/cost_2014-11-11_15:15:06.csv','test_results/cost_2014-11-11_15:14:05.csv','test_results/cost_2014-11-11_14:53:22.csv','test_results/cost_2014-11-11_14:52:20.csv','test_results/cost_2014-11-11_14:51:19.csv','test_results/cost_2014-11-11_14:50:17.csv','test_results/cost_2014-11-11_14:49:16.csv','test_results/cost_2014-11-11_14:30:09.csv','test_results/cost_2014-11-11_14:29:07.csv','test_results/cost_2014-11-11_14:28:06.csv'};
[s1000 c1000] = get_costs(files1000,T,1:numel(files1000));

hn=figure(2);clf;
set(hn,'PaperType','A4'); 
set(hn,'PaperOrientation','landscape');
set(hn,'PaperUnits','centimeters');
set(hn,'PaperPosition',[0 0 32 5]);

%%%%%%%%%% Drunken quadrotor panels (QRSIM)
filename = 'results_drunken.csv';
M = csvread(filename);

[m, s, e] = grpstats(M,[M(:,1)],{'mean','meanci','numel'});
subplot(1,6,1);

plot(-1,-1,'k.-');hold on;
plot(-1,-1,'r.-');hold on;

ms = 'loess';
vX = unique(M(:,1));
vY = smooth(m(:,4),ms);
vY1 = smooth(s(:,4,1),ms);
vY2 = smooth(s(:,4,2),ms);

% plot(unique(M(:,1)), smooth(m(:,4),ms),'k.-','linewidth',3); hold on;
% plot(unique(M(:,1)), smooth(s(:,4,1),ms),'k-'); hold on;
% plot(unique(M(:,1)), smooth(s(:,4,2),ms),'k-'); hold on;

shadedErrorBar(vX,vY,[vY1-vY,vY-vY2],'b');
%bar(unique(M(:,1))-.01, [(e(:,1)-e(:,3)), (e(:,1)-e(:,4))])
xlabel('Wind velocity (m/s)','fontsize',fontsize);
ylabel('Cost solution','fontsize',fontsize);
title('DQ with Wind','fontsize',fontsize);

axis tight;
set(gca,'ylim',[50 90]);
set(gca,'xlim',[0 0.2]);
set(gca,'xtick',unique(M(:,1)));
set(gca,'fontsize',fontsize);
grid on;

subplot(1,6,2);

bar(unique(M(:,1))-.01, [(e(:,1)-e(:,3))./e(:,1), (e(:,1)-e(:,4))./e(:,1)])
xlabel('Wind velocity (m/s)','fontsize',fontsize);
ylabel('% crashes','fontsize',fontsize);
title('DQ with Wind','fontsize',fontsize);
hl=legend('iLQG','PI');
set(hl,'fontsize',fontsize-1);
axis tight;
set(gca,'ylim',[0 1]);
set(gca,'xtick',unique(M(:,1)));
set(gca,'fontsize',fontsize);
grid on;

%%%%%%%%%% Holding Pattern panels (CRATES)
vX=1:T;
subplot(1,6,3);
if size(s100,1)>1
    A=shadedErrorBar(vX,-smooth(mean(s10)),smooth(std(s10)),'b');
    hold on;
    B=shadedErrorBar(vX,-smooth(mean(s100)),smooth(std(s100)),'r',0);
    C=shadedErrorBar(vX,-smooth(mean(s1000)),smooth(std(s1000)),[],0);
    %set(gca,'yscale','log');
    hl=legend([A.mainLine,B.mainLine,C.mainLine],'N=10','N=10^2','N=10^3')
    set(hl,'fontsize',fontsize-1);
else
    plot(-s100,'b');
end
xlabel('time','fontsize',fontsize);
ylabel('state cost','fontsize',fontsize);
title('HP: 5 quadrotors','fontsize',fontsize);
set(gca,'fontsize',fontsize);
grid on;
set(gca,'box','on');
hold on;
% 
% axes('position',[.35 .72 .10 .18]);
% hl=legend([A.mainLine,B.mainLine,C.mainLine],'N=10','N=10^2','N=10^3');
% set(hl,'position', [.26 .8 .005 .05]);
% set(hl,'fontsize',fontsize-2);
% A=shadedErrorBar(vX(T-10:end),-mean(s10(:,T-10:end)),std(s10(:,T-10:end)),'b');
% hold on;
% B=shadedErrorBar(vX(T-10:end),-mean(s100(:,T-10:end)),std(s100(:,T-10:end)),'r',0);
% C=shadedErrorBar(vX(T-10:end),-mean(s1000(:,T-10:end)),std(s1000(:,T-10:end)),[],0);
% axis tight;
% set(gca,'ylim',[100 120]);
% set(gca,'ytick',[100 120]);
% set(gca,'xtick',[140 150]);
% % set(gca,'yticklabel',[100 120]);
% % set(gca,'xticklabel',[140 150]);

if false
    subplot(1,6,4);
    if size(s100,1)>1
        A=shadedErrorBar([],smooth(mean(c10)),smooth(std(c10)),'b');
        hold on;
        B=shadedErrorBar([],smooth(mean(c100)),smooth(std(c100)),'r',0);
        C=shadedErrorBar([],smooth(mean(c1000)),smooth(std(c1000)),[],0);
        hl=legend([A.mainLine,B.mainLine,C.mainLine],'N=10','N=10^2','N=10^3')
        set(hl,'fontsize',fontsize-1);
    else
        plot(c100,'r');
    end
    xlabel('time','fontsize',fontsize);
    ylabel('control cost','fontsize',fontsize);
    title('five quadrotors','fontsize',fontsize);
    set(gca,'fontsize',fontsize);
    grid on;
    set(gca,'box','on');
    set(gca,'ylim',[0 30]);
end

%%%%%%%%%% Holding Pattern panels (Scaling CRATES)

vN = [1000, 7000, 100, 500, 5000];

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

files{3,2} = {'test_results/cost_2_100__2014-11-13_11:04:43.csv'};%,'test_results/cost_2_100__2014-11-13_11:47:48.csv',...
%     'test_results/cost_2_100__2014-11-13_12:30:52.csv','test_results/cost_2_100__2014-11-13_13:20:21.csv',...
%     'test_results/cost_2_100__2014-11-13_14:03:27.csv','test_results/cost_2_100__2014-11-13_14:46:32.csv'};

files{3,4} = {'test_results/cost_4_100__2014-11-13_11:07:06.csv','test_results/cost_4_100__2014-11-13_11:50:11.csv',...
    'test_results/cost_4_100__2014-11-13_12:33:16.csv','test_results/cost_4_100__2014-11-13_13:22:45.csv',...
    'test_results/cost_4_100__2014-11-13_14:05:50.csv','test_results/cost_4_100__2014-11-13_14:48:55.csv',...
    'test_results/cost_4_100__2014-11-13_15:32:01.csv','test_results/cost_4_100__2014-11-13_16:32:22.csv',...
    'test_results/cost_4_100__2014-11-13_17:15:26.csv','test_results/cost_4_100__2014-11-13_17:58:31.csv',...
    'test_results/cost_4_100__2014-11-13_18:41:36.csv','test_results/cost_4_100__2014-11-13_19:24:41.csv'};

files{3,6} = {'test_results/cost_6_100__2014-11-13_13:25:09.csv','test_results/cost_6_100__2014-11-13_14:51:19.csv','test_results/cost_6_100__2014-11-13_15:34:25.csv',...
   'test_results/cost_6_100__2014-11-13_17:17:50.csv' };
%,'test_results/cost_6_100__2014-11-13_17:17:50.csv','test_results/cost_6_100__2014-11-13_18:00:55.csv','test_results/cost_6_100__2014-11-13_18:44:00.csv','test_results/cost_6_100__2014-11-13_19:27:05.csv'};
%,'test_results/cost_6_100__2014-11-13_16:34:46.csv'

%'test_results/cost_6_100__2014-11-13_14:08:14.csv'};

%'test_results/cost_6_100__2014-11-13_11:09:30.csv'};%'test_results/cost_6_100__2014-11-13_11:52:35.csv''test_results/cost_6_100__2014-11-13_12:35:39.csv'};%

files{3,8} = {'test_results/cost_8_100__2014-11-13_11:11:54.csv','test_results/cost_8_100__2014-11-13_11:54:59.csv','test_results/cost_8_100__2014-11-13_13:27:33.csv'};
%,'test_results/cost_8_100__2014-11-13_14:10:38.csv','test_results/cost_8_100__2014-11-13_14:53:43.csv','test_results/cost_8_100__2014-11-13_15:36:49.csv','test_results/cost_8_100__2014-11-13_16:37:10.csv','test_results/cost_8_100__2014-11-13_17:20:14.csv','test_results/cost_8_100__2014-11-13_18:03:19.csv','test_results/cost_8_100__2014-11-13_18:46:24.csv','test_results/cost_8_100__2014-11-13_19:29:29.csv'};

%,'test_results/cost_8_100__2014-11-13_12:38:04.csv'

files{3,10} ={'test_results/cost_10_100__2014-11-13_11:14:19.csv',...
    'test_results/cost_10_100__2014-11-13_11:57:24.csv',...
    'test_results/cost_10_100__2014-11-13_12:40:28.csv',...
    'test_results/cost_10_100__2014-11-13_13:29:57.csv','test_results/cost_10_100__2014-11-13_14:13:03.csv','test_results/cost_10_100__2014-11-13_15:39:14.csv',...
    'test_results/cost_10_100__2014-11-13_16:39:35.csv','test_results/cost_10_100__2014-11-13_17:22:39.csv','test_results/cost_10_100__2014-11-13_18:05:44.csv',...
    'test_results/cost_10_100__2014-11-13_18:48:49.csv','test_results/cost_10_100__2014-11-13_19:31:54.csv'};


%'test_results/cost_10_100__2014-11-13_11:57:24.csv'};%'test_results/cost_10_100__2014-11-13_11:57:24.csv'};
%'test_results/cost_10_100__2014-11-13_11:14:19.csv'};%,'test_results/cost_10_100__2014-11-13_11:57:24.csv',
%'test_results/cost_10_100__2014-11-13_12:40:28.csv'};,'test_results/cost_10_100__2014-11-13_14:56:08.csv'

files{4,2} = {'test_results/cost_2_500__2014-11-13_11:19:05.csv','test_results/cost_2_500__2014-11-13_12:02:09.csv',...
    'test_results/cost_2_500__2014-11-13_12:45:14.csv','test_results/cost_2_500__2014-11-13_13:34:43.csv'};
files{5,2} = {'test_results/cost_2_5000__2014-11-13_11:33:26.csv','test_results/cost_2_5000__2014-11-13_12:16:31.csv',...
    'test_results/cost_2_5000__2014-11-13_12:59:36.csv','test_results/cost_2_5000__2014-11-13_13:49:05.csv'};

files{4,4} = {'test_results/cost_4_500__2014-11-13_11:21:28.csv','test_results/cost_4_500__2014-11-13_12:04:32.csv',...
    'test_results/cost_4_500__2014-11-13_12:47:37.csv'};
files{5,4} = {'test_results/cost_4_5000__2014-11-13_11:35:49.csv','test_results/cost_4_5000__2014-11-13_12:18:54.csv',...
    'test_results/cost_4_5000__2014-11-13_13:01:59.csv'};
files{4,6} = {'test_results/cost_6_500__2014-11-13_11:23:52.csv','test_results/cost_6_500__2014-11-13_12:06:56.csv',...
    'test_results/cost_6_500__2014-11-13_12:50:01.csv'};
files{5,6} = {'test_results/cost_6_5000__2014-11-13_11:38:13.csv','test_results/cost_6_5000__2014-11-13_12:21:18.csv',...
    'test_results/cost_6_5000__2014-11-13_13:04:23.csv'};
files{4,8} = {'test_results/cost_8_500__2014-11-13_11:26:16.csv','test_results/cost_8_500__2014-11-13_12:09:21.csv',...
    'test_results/cost_8_500__2014-11-13_12:52:25.csv'};
files{5,8} = {'test_results/cost_8_5000__2014-11-13_11:40:37.csv'};%,'test_results/cost_8_5000__2014-11-13_12:23:42.csv',...    'test_results/cost_8_5000__2014-11-13_13:06:47.csv'};
files{4,10} = {'test_results/cost_10_500__2014-11-13_11:28:41.csv'};%,'test_results/cost_10_500__2014-11-13_12:11:45.csv','test_results/cost_10_500__2014-11-13_12:54:50.csv'};
files{5,10} = { 'test_results/cost_10_5000__2014-11-13_13:09:12.csv'};


T = 700;
dT = 20;

vU = 2:2:10;
ms = zeros(2,numel(vU));
ss = zeros(2,numel(vU));
mc = zeros(2,numel(vU));
sc = zeros(2,numel(vU));
clear s;
for n = 2:3
    for u = 1:numel(vU)
        [s{n,u} c{n,u}] = get_costs(files{n,vU(u)},T,1:numel(files{n,vU(u)}));%:numel(files2));
        ms(n,u) = mean(mean(s{n,u}(:,T-dT:T),2));
        ss(n,u) = mean(std(s{n,u}(:,T-dT:T),0,2));
        mc(n,u) = mean(mean(c{n,u}(:,T-dT:T),2));
        sc(n,u) = std(std(c{n,u}(:,T-dT:T),0,2));
    end
end

vX = vU;
subplot(1,6,4);
C=shadedErrorBar(vX,65-ms(3,:),ss(3,:),'r');hold on;
A=shadedErrorBar(vX,65-ms(2,:),ss(2,:),'k');hold on;

hl=legend([C.mainLine,A.mainLine],...
    'N=10^2','N=10^4','location','northwest');
 set(hl,'fontsize',fontsize-1);

xlabel('number of quadrotors','fontsize',fontsize);
ylabel('state cost','fontsize',fontsize);
title('HP: scaling','fontsize',fontsize);
grid on;
set(gca,'box','on');
set(gca,'fontsize',fontsize);
set(gca,'xlim',[2 10]);


%%%%%%%%%% Holding Pattern panels (comparison iLQG and ESS)

load main.mat

% h3=figure;
stype ={'both'};%'state'; 'control'};
% set(h3,'PaperType','A4'); 
% set(h3,'PaperOrientation','portrait');
% set(h3,'PaperUnits','centimeters');
% set(h3,'PaperPosition',[0 0 30 10]);

for t=1

    SS_ilqg(SC_ilqg>80) = NaN;
    SC_ilqg(SC_ilqg>80) = NaN;
    %subplot(1,1,t);
    if strcmp(stype{t},'state')
        mcpi = mean( SS_pi );
        ccpi = ci( SS_pi );
        mcilqg = nanmean(SS_ilqg);
        scilqg = ci(SS_ilqg);
        
        me = nanmean(SS_pi-SS_ilqg);
        se = ci(SS_pi-SS_ilqg);
    elseif strcmp(stype{t},'control')
        mcpi = mean( SC_pi );
        scpi = ci( SC_pi );
        mcilqg = nanmean(SC_ilqg);
        scilqg = ci(SC_ilqg);
        
        me = nanmean(SC_pi-SC_ilqg);
        se = ci(SC_pi-SC_ilqg);        
    else
        spi = SC_pi+SS_pi;
        silqg = SS_ilqg+SC_ilqg;
        mcpi = mean( spi );
        scpi = ci( spi );
        mcilqg = nanmean( silqg );
        scilqg = ci( silqg );

        me = nanmean(silqg./spi);
        se = ci(silqg./spi);
    end

    subplot(1,6,5);
    %shadedErrorBar(NU,mcpi,[scpi(1,:)-mcpi; mcpi-scpi(2,:)],'r');hold on;
    %shadedErrorBar(NU,mcilqg,[scilqg(1,:)-mcilqg; mcilqg-scilqg(2,:)], 'b');hold on;
    vm = smooth(me);
    vm(end) = NaN;
    vs=[smooth(se(1,:)-me)' ; smooth(me-se(2,:))'];
    vs(:,end) = NaN;
    shadedErrorBar(NU, vm, vs,'b');hold on;
    %shadedErrorBar(NU,me,[se(1,:)-me ; me-se(2,:)],'b');hold on;
    set(gca,'xscale','log');
    axis tight;
    grid on;
    set(gca, 'xminorgrid','off');
    set(gca,'fontsize',fontsize);
    xlabel('Noise level \sigma_u^2','fontsize',fontsize);
    ylabel('Cost iLQG/PI','fontsize',fontsize);
    set(gca,'xtick', logspace(-3,0,4));
    set(gca,'xlim', [1e-3 1e0]);
    set(gca,'ylim', [.9 1.1]);
    plot(NU,ones(1,numel(NU)),'k','Linewidth',3);
    set(gca,'ytick', .9:.05:1.1);
    title('HP: Cost iLQG/PI','fontsize',fontsize);
end
%saveas(h3,'fig.eps','psc2');

subplot(1,6,6);
me = mean(mean_ess);
st = ci(mean_ess);
shadedErrorBar(NU,me,[st(1,:)-me; me-st(2,:)],'b');hold on;
set(gca,'xscale','log');
set(gca,'yscale','log');
axis tight;
grid on;
set(gca, 'xminorgrid','off');
set(gca, 'yminorgrid','off');
set(gca,'fontsize',fontsize);
xlabel('Noise level \sigma_u^2','fontsize',fontsize);
ylabel('ESS','fontsize',fontsize);
set(gca,'xtick', logspace(-3,0,4));
set(gca,'xlim', [1e-3 1e0]);
set(gca,'ytick', logspace(-1,3,5));
set(gca,'ylim', [1e0 1e3]);
title('HP: Expected Sample Size','fontsize',fontsize);
    

if false
    subplot(1,6,5);
    C=shadedErrorBar(vX,mc(3,:),sc(3,:),'r');hold on;
    A=shadedErrorBar(vX,mc(2,:),sc(2,:),'k');hold on;
    %B=shadedErrorBar(vX,mc(1,:),sc(1,:),'r');
    %C=shadedErrorBar(vX,mc(3,:),sc(3,:));
    hl=legend([C.mainLine,A.mainLine],...
        'N=10^2','N=10^4','location','northwest');
    set(hl,'fontsize',fontsize-1);
    xlabel('number of quadrotors','fontsize',fontsize);
    ylabel('control cost','fontsize',fontsize);
    set(gca,'fontsize',fontsize);
    grid on;
    set(gca,'box','on');
    set(gca,'xlim',[2 10]);

    subplot(1,6,6);
    C=shadedErrorBar(vX,mc(3,:),sc(3,:),'r');hold on;
    A=shadedErrorBar(vX,mc(2,:),sc(2,:),'k');hold on;
    %B=shadedErrorBar(vX,mc(1,:),sc(1,:),'r');
    %C=shadedErrorBar(vX,mc(3,:),sc(3,:));
    hl=legend([C.mainLine,A.mainLine],...
        'N=10^2','N=10^4','location','northwest');
    set(hl,'fontsize',fontsize-1);
    xlabel('number of quadrotors','fontsize',fontsize);
    ylabel('control cost','fontsize',fontsize);
    set(gca,'fontsize',fontsize);
    grid on;
    set(gca,'box','on');
    set(gca,'xlim',[2 10]);

    subplot(1,6,6);
    C=shadedErrorBar(vX,mc(3,:),sc(3,:),'r');hold on;
    A=shadedErrorBar(vX,mc(2,:),sc(2,:),'k');hold on;
    %B=shadedErrorBar(vX,mc(1,:),sc(1,:),'r');
    %C=shadedErrorBar(vX,mc(3,:),sc(3,:));
    hl=legend([C.mainLine,A.mainLine],...
        'N=10^2','N=10^4','location','northwest');
    set(hl,'fontsize',fontsize-1);
    xlabel('number of quadrotors','fontsize',fontsize);
    ylabel('control cost','fontsize',fontsize);
    set(gca,'fontsize',fontsize);
    grid on;
    set(gca,'box','on');
    set(gca,'xlim',[2 10]);

    %set(gca,'ylim',[0 30]);
end

saveas(hn,'fig_IJCAI.eps','psc2');
