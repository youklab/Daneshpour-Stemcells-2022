%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Stochastic model to explain how colony size & response threshold %%%
%%% dictate when local communication is enough for survival

close all;
clear all;
clc;

FC_D6_Knormal = struct2cell(load('Model_FC_day6_matrix_Knormal.mat'));
FC_D6_Knormal = cell2mat(FC_D6_Knormal{1,1});
FC_D6_Klow = struct2cell(load('Model_FC_day6_matrix_Klow.mat'));
FC_D6_Klow = cell2mat(FC_D6_Klow{1,1});
FC_D6_Khigh = struct2cell(load('Model_FC_day6_matrix_Khigh_2.mat'));
FC_D6_Khigh = cell2mat(FC_D6_Khigh{1,1});

dish_size=58;
D0 = round([150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000 1050 1100]);

figure(1)
plot(D0,FC_D6_Knormal,'.k','MarkerSize',15);
% plot(D0,FC_D6_Knormal,'.','MarkerSize',15,'Color','#CF81B6');
hold on
% plot(D0,FC_D6_Klow,'.r','MarkerSize',15);
hold on
% plot(D0,FC_D6_Khigh,'.b','MarkerSize',15,'Color','#FCBF94');
plot(D0,FC_D6_Khigh,'.b','MarkerSize',15);

hold on
rRangeL = 3;
rRangeR = 23;

FC_D6_Knormal(FC_D6_Knormal == 0) = NaN;
FC_D6_Khigh(FC_D6_Khigh == 0) = NaN;
[f,gof]=fit(D0',mean(FC_D6_Knormal,2,'omitnan'),'poly1');
[g,gof]=fit(D0',mean(FC_D6_Khigh,2,'omitnan'),'poly1');

corrPearsonNormal = corrcoef(D0',mean(FC_D6_Knormal,2,'omitnan'));
corrPearsonHigh = corrcoef(D0',mean(FC_D6_Khigh,2,'omitnan'));

plot(f,'--k');
plot(g,'--b');

plot(D0',mean(FC_D6_Knormal,2,'omitnan'),'.','MarkerSize',40,'MarkerEdgeColor','k');
plot(D0',mean(FC_D6_Khigh,2,'omitnan'),'.','MarkerSize',40,'MarkerEdgeColor','k');

set(gca,'yscale','log');
xlim([0 1200]);
ylim([4*10^-2 4*10^0]);

hold on
title(['Low C_{thresh} (black) w/ r = ' num2str(round(corrPearsonNormal(1,2),3)) '  |  High C_{thresh} (blue) w/ r = ' num2str(round(corrPearsonHigh(1,2),3))]);

xlabel('Initial colony area (\mum^2)');
ylabel('Colony area after 4 days rel. to initial area');

set(gca,'XminorTick','off');
set(gca,'YminorTick','off');
set(gca,'TickLength',[0.02, 0.1]);
set(gca,'LineWidth',1);
set(gca,'XColor','k');
set(gca,'YColor','k');
