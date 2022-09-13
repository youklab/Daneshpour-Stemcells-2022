%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Stochastic simulation for modeling ES cell population growth %%%


% Reset all values
close all;
clear all;
clc;


% Figure specifications
figure(1);
cur_pos = get(gcf,'position');
cur_w = 550;
cur_h = 450;
set(gcf,'units','pixels','position',[cur_pos(1),cur_pos(2),cur_w,cur_h]);
clf
hold on

font_name = 'Arial';
font_size_tick = 18;
font_size_label = 18;

set(get(gca,'XAxis'),'FontSize', font_size_tick, 'FontName', font_name);
set(get(gca,'YAxis'),'FontSize', font_size_tick, 'FontName', font_name);

set(gca, 'Layer', 'top');
xlabel('Time (hours)', 'FontName', font_name, 'FontSize',font_size_label);
ylabel('Fold change in population density', 'FontName', font_name, 'FontSize',font_size_label);
set(gca,'YScale','log');
set(gca, 'YMinorTick','Off');
set(gca, 'TickLength', [0.025, 0.025]);
set(gca, 'LineWidth', 1.5);
box on
xlim([0 1000]);
ylim([10^-2 10^2]);
set(gca,'YminorTick','off');
set(gca,'TickLength',[0.015, 0.1]);
set(gca,'LineWidth',1);
set(gca,'XColor','k');
set(gca,'YColor','k');


% Initialization of simulation
mu = 1.2457./24; % maximum growth rate
pd = 0.6133./24; % death rate
Kmin = 485000; % free parameter
colors = { [0 0.4470 0.7410] [0.4660 0.6740 0.1880] [1 0 0] };

draw_step = 24; % calculation step
dish_size = 58; % surface area of 10-cm diameter dish (cm^2)
hill = 1; % Hill coefficient
volume_dish = 10; % volume of liquid medium in 10-cm diameter dish (mL)
CarryingK = round(10^7/dish_size); % carrying capacity, in number of cells

scale_cultures = 1;
tmax = 1000; % maximum time range for simulation
xlim([0 tmax]); % x limits
ylim([10^-2 10^2]); % y limits
D0 = round([300000 112000 50000]./dish_size); % initial number of cells
n_cultures = 10; % number of replicates


%Simulation run
for (j = 1:size(D0,2))
    A0=D0(j)
    for (i=1:n_cultures)
        Mt(1) = 0;
        At = A0;
        iDensity(j,i)=At*dish_size;
        pa_t=0;
        
        K = Kmin;
        Nt = A0;
        Nt_old = Nt;
        At_old = At;
        AFc_old=1;
        t=0;
        told=t;
        Kk=((CarryingK-At)/CarryingK);
        
        while (At > 0 && At < (9*10^9)/dish_size || At==0 && t<tmax) && t<=tmax
            if t>1
            pa_t = mu * (Mt(t-1)) / (K + (Mt(t-1)));
            end
            newborn = binornd(round(At),pa_t,1,1);
            deathpop=binornd(round(At),pd,1,1);           
   
            At = At + ((CarryingK-At)/CarryingK)*((newborn)- deathpop);
            
            if(At <15)
                At=0;
            end
            Afc=At/A0;
        
            if t>1
            Mt(t) = (dish_size*(At/volume_dish)+0.9913*Mt(t-1));
            end
            Nt = Nt + newborn;
            At_all(j,i)=At;
            aFC(j,i)=Afc;
            t = t + 1;
            deathPercDeath(j,t+1)=deathpop;
            AtPercDeath(j,t+1)=At;
            percDeath(j,t+1)=deathpop./At;

            if (mod(t,draw_step)==0)
               plot([told t], [AFc_old Afc] ,'.--','Color',colors{j},'LineWidth', 1.5, 'MarkerEdgeColor', [0 0 0], 'MarkerSize',10);
               told = t;
               AFc_old=Afc;
               At_old = At;
               Nt_old = Nt;
            end
        end
       plot([told t], [AFc_old Afc] ,'.--', 'Color', colors{j}, 'LineWidth', 1.5, 'MarkerEdgeColor', [0 0 0], 'MarkerSize',20);
        told = t;
        Nt_old = Nt;
        At_old = At;
        AFc_old=Afc;
        drawnow
    end
end
