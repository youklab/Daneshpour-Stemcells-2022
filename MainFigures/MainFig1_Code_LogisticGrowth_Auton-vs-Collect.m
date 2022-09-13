
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Fig. 1 - Code for modeling logisitic population growth %%%

%% Comparison of autonomous vs collective (w/ and w/o density threshold)

clear all;
close all;
clc;

figure(1)

% Autonomous growth
subplot(3,2,1) % panel A

mu_max = 1.2457./24;
Kmin = 3500;
dish_size = 58;
Kcar = round(10^7/dish_size); 
D0 = round([58 1000 3000 10000 25000 50000 75000 100000 112000 125000 150000 175000 200000 250000 300000 350000 500000 700000 900000 1200000 1500000 3000000 6000000]./dish_size);
gamma = 0.6133./24;

r_auton = mu_max-gamma;
time_auton = 1:1:500;
Dens_auton = D0([1 2 4 8 15 20]);
% t_D6 = 24.*6;
t_D6 = 200;

for i = 1:size(Dens_auton,2)
    N_auton_time(i,:) = Kcar ./ (1 + ((Kcar - Dens_auton(i))./Dens_auton(i)).*exp(-r_auton.*time_auton));
end

% N_auton_time = Kcar ./ (1 + ((Kcar - Dens_auton)./Dens_auton).*exp(-r_auton.*time_auton));
plot(time_auton,N_auton_time,'-','LineWidth',4);
hold on
% yline((mu_max-gamma),'-k','LineWidth',4);
hold on
yline(Kcar,'--','Carrying capacity');
xline(t_D6,'--','day 6');
set(gca, 'YScale', 'log');
% set(gca, 'YScale', 'log');
xlim([0 500]);
ylim([10^0 6*10^5]);
box on
title('A:  Autonomous growth');
xlabel('t in hours');
ylabel('N(t)');
set(gca,'XminorTick','off');
set(gca,'YminorTick','off');
set(gca,'TickLength',[0.015, 0.1]);
set(gca,'LineWidth',1);
set(gca,'XColor','k');
set(gca,'YColor','k');

subplot(3,2,2) % panel B
N_auton_D6 = Kcar ./ (1 + ((Kcar - D0)./D0).*exp(-r_auton.*t_D6));
plot(D0,N_auton_D6./D0,'-k','LineWidth',4);
hold on
plot(Dens_auton,N_auton_time(:,t_D6)./Dens_auton','.k','MarkerSize',30);
hold on
yline(1,'--');
set(gca, 'XScale', 'log');
set(gca, 'YScale', 'log');
title('B:  Autonomous growth');
xlabel('N(0)');
ylabel('F.C. after 6 days');
xlim([10^0 20690]);
ylim([10^-3 10^3]);
set(gca,'XminorTick','off');
set(gca,'YminorTick','off');
set(gca,'TickLength',[0.015, 0.1]);
set(gca,'LineWidth',1);
set(gca,'XColor','k');
set(gca,'YColor','k');


% Collective growth (scenario 1)
mu_0 = 1.2457./24;
% mu_0 = 1.2457./72;
K_M = 3500;
r_0 = 0.02;
t_D6_collS1 = 200;

tspan = [0:1:500];
Dens_collS1 = D0([1 2 4 8 15 20]);

subplot(3,2,3) % panel C
hold on

for i = 1:size(Dens_collS1,2)
    [t,N] = ode45(@(t,N) ((1-N./Kcar).*N.*(((mu_0.*N)./(K_M+N))+r_0)), tspan, Dens_auton(i));
    
    subplot(3,2,3) % panel C
    plot(t,N,'-','LineWidth',4);
    hold on
end

set(gca, 'YScale', 'log');
xlim([0 500]);
ylim([10^0 6*10^5]);
yline(Kcar,'--','Carrying capacity');
xline(t_D6_collS1,'--','day 6');
box on
title('C:  Collective growth (scenario 1)');
xlabel('t in hours');
ylabel('N(t)');
set(gca,'XminorTick','off');
set(gca,'YminorTick','off');
set(gca,'TickLength',[0.015, 0.1]);
set(gca,'LineWidth',1);
set(gca,'XColor','k');
set(gca,'YColor','k');

for i = 1:size(D0,2)
    [t,N] = ode45(@(t,N) ((1-N./Kcar).*N.*(((mu_0.*N)./(K_M+N))+r_0)), tspan, D0(i));
    N_collectS1_D6(1,i) = N(t_D6_collS1);
end

for i = 1:size(Dens_auton,2)
    [t,N] = ode45(@(t,N) ((1-N./Kcar).*N.*(((mu_0.*N)./(K_M+N))+r_0)), tspan, Dens_auton(i));
    subplot(3,2,4) % panel D
    plot(Dens_auton(i),N(t_D6_collS1)./Dens_auton(i),'.k','MarkerSize',30);
    hold on
end

hold on
plot(D0,N_collectS1_D6./D0,'-k','LineWidth',4);
yline(1,'--');
hold on
set(gca, 'XScale', 'log');
set(gca, 'YScale', 'log');
title('D:  Collective growth (scenario 1)');
xlabel('N(0)');
ylabel('F.C. after 6 days');
xlim([10^0 20690]);
ylim([10^-3 10^3]);
set(gca,'XminorTick','off');
set(gca,'YminorTick','off');
set(gca,'TickLength',[0.015, 0.1]);
set(gca,'LineWidth',1);
set(gca,'XColor','k');
set(gca,'YColor','k');


% Collective growth (scenario 2)
mu_0 = 1.2457./24;
K_M = 3500;
r_0 = -gamma;

tspan = [0:1:500];
Dens_collS1 = D0([1 2 4 8 15 20]);
t_D6_collS2 = 200;

subplot(3,2,5) % panel E
hold on

for i = 1:size(Dens_collS1,2)
    [t,N] = ode45(@(t,N) ((1-N./Kcar).*N.*(((mu_0.*N)./(K_M+N))+r_0)), tspan, Dens_auton(i));
    
    subplot(3,2,5) % panel E
    plot(t,N,'-','LineWidth',4);
    hold on
end

set(gca, 'YScale', 'log');
xlim([0 500]);
ylim([10^0 6*10^5]);
yline(Kcar,'--','Carrying capacity');
xline(t_D6_collS2,'--','day 6');
box on
title('E:  Collective growth (scenario 2)');
xlabel('t in hours');
ylabel('N(t)');
set(gca,'XminorTick','off');
set(gca,'YminorTick','off');
set(gca,'TickLength',[0.015, 0.1]);
set(gca,'LineWidth',1);
set(gca,'XColor','k');
set(gca,'YColor','k');

for i = 1:size(D0,2)
    [t,N] = ode45(@(t,N) ((1-N./Kcar).*N.*(((mu_0.*N)./(K_M+N))+r_0)), tspan, D0(i));
    N_collectS2_D6(1,i) = N(t_D6_collS2);
end

for i = 1:size(Dens_auton,2)
    [t,N] = ode45(@(t,N) ((1-N./Kcar).*N.*(((mu_0.*N)./(K_M+N))+r_0)), tspan, Dens_auton(i));
    subplot(3,2,6) % panel F
    plot(Dens_auton(i),N(t_D6_collS2)./Dens_auton(i),'.k','MarkerSize',30);
    hold on
end

hold on
plot(D0,N_collectS2_D6./D0,'-k','LineWidth',4);
hold on
yline(1,'--');
set(gca, 'XScale', 'log');
set(gca, 'YScale', 'log');
title('F:  Collective growth (scenario 2)');
xlabel('N(0)');
ylabel('F.C. after 6 days');
xlim([10^0 20690]);
ylim([10^-3 10^3]);
set(gca,'XminorTick','off');
set(gca,'YminorTick','off');
set(gca,'TickLength',[0.015, 0.1]);
set(gca,'LineWidth',1);
set(gca,'XColor','k');
set(gca,'YColor','k');
