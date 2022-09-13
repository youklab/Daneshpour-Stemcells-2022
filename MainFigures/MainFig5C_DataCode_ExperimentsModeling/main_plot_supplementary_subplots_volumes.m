%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Effect of changing liquid volume on survival of ES cells %%%
%%% (modeling & experiments)


close all;
clear all;
clc;

filenameDil=inputExcelDil();
[status,sheetsDil] = xlsfinfo(filenameDil);
numSheets=size(sheetsDil,2);

dataPop=xlsread(filenameDil,sheetsDil{1});
dataDiff=xlsread(filenameDil,sheetsDil{2});

Dens = dataPop(:,1);
Vols = dataPop(:,2);
FC_mean = mean(dataPop(:,3:end),2,'omitnan')./Dens(:,1);
% FC_err = std(dataPop(:,3:end),[],2,'omitnan')./(Dens(:,1) .* sqrt(sum(~isnan(dataPop(:,3:end)))));
FC_err = std(dataPop(:,3:end),[],2,'omitnan')./(Dens(:,1).*sqrt(sum(~isnan(dataPop(:,3:end)),2)));
Diff_mean = mean(dataDiff(:,3:end),2,'omitnan');
Diff_err = std(dataDiff(:,3:end),[],2,'omitnan')./sqrt(sum(~isnan(dataDiff(:,3:end))));

figure(1)

for i = 1:size(Dens,1)
    
    if dataPop(i,2) == 2
        hold on
        subplot(3,3,1)
        hold on
        yyaxis left
        errorbar(dataPop(i,1)./58,FC_mean(i,1),FC_err(i,1),'k.--','MarkerSize',20,'LineWidth',1);
        set(gca,'xscale','log');
        set(gca,'yscale','log');
        set(gca,'ycolor','k');
        ylim([0.1 30]);
        yyaxis right
        errorbar(dataPop(i,1)./58,Diff_mean(i,1),Diff_err(i,1),'.--','MarkerSize',20,'LineWidth',1,'Color',[0.2 0.6 0]);
        set(gca,'ycolor',[0.2 0.6 0]);
        xlim([8000 1000000]./58);
        ylim([0 100]);
        box on;
        title('2-mL');
        

        
        
    elseif dataPop(i,2) == 5
        hold on
        subplot(3,3,2)
        hold on
        yyaxis left
        errorbar(dataPop(i,1)./58,FC_mean(i,1),FC_err(i,1),'k.--','MarkerSize',20,'LineWidth',1);
        set(gca,'xscale','log');
        set(gca,'yscale','log');
        set(gca,'ycolor','k');
        ylim([0.1 30]);
        yyaxis right
        errorbar(dataPop(i,1)./58,Diff_mean(i,1),Diff_err(i,1),'.--','MarkerSize',20,'LineWidth',1,'Color',[0.2 0.6 0]);
        set(gca,'ycolor',[0.2 0.6 0]);
        xlim([8000 1000000]./58);
        ylim([0 100]);
        box on;
        title('5-mL');
        
    elseif dataPop(i,2) == 10
        hold on
        subplot(3,3,3)
        hold on
        yyaxis left
        errorbar(dataPop(i,1)./58,FC_mean(i,1),FC_err(i,1),'k.--','MarkerSize',20,'LineWidth',1);
        set(gca,'xscale','log');
        set(gca,'yscale','log');
        set(gca,'ycolor','k');
        ylim([0.1 30]);
        yyaxis right
        errorbar(dataPop(i,1)./58,Diff_mean(i,1),Diff_err(i,1),'.--','MarkerSize',20,'LineWidth',1,'Color',[0.2 0.6 0]);
        set(gca,'ycolor',[0.2 0.6 0]);
        xlim([8000 1000000]./58);
        ylim([0 100]);
        box on;
        title('10-mL');
        
    elseif dataPop(i,2) == 18
        hold on
        subplot(3,3,4)
        hold on
        yyaxis left
        errorbar(dataPop(i,1)./58,FC_mean(i,1),FC_err(i,1),'k.--','MarkerSize',20,'LineWidth',1);
        set(gca,'xscale','log');
        set(gca,'yscale','log');
        set(gca,'ycolor','k');
        ylim([0.1 30]);
        yyaxis right
        errorbar(dataPop(i,1)./58,Diff_mean(i,1),Diff_err(i,1),'.--','MarkerSize',20,'LineWidth',1,'Color',[0.2 0.6 0]);
        set(gca,'ycolor',[0.2 0.6 0]);
        xlim([8000 1000000]./58);
        ylim([0 100]);
        box on;
        title('18-mL');
        
    elseif dataPop(i,2) == 20
        hold on
        subplot(3,3,5)
        hold on
        yyaxis left
        errorbar(dataPop(i,1)./58,FC_mean(i,1),FC_err(i,1),'k.--','MarkerSize',20,'LineWidth',1);
        set(gca,'xscale','log');
        set(gca,'yscale','log');
        set(gca,'ycolor','k');
        ylim([0.1 30]);
        yyaxis right
        errorbar(dataPop(i,1)./58,Diff_mean(i,1),Diff_err(i,1),'.--','MarkerSize',20,'LineWidth',1,'Color',[0.2 0.6 0]);
        set(gca,'ycolor',[0.2 0.6 0]);
        xlim([8000 1000000]./58);
        ylim([0 100]);
        box on;
        title('20-mL');
        
    elseif dataPop(i,2) == 30
        hold on
        subplot(3,3,6)
        hold on
        yyaxis left
        errorbar(dataPop(i,1)./58,FC_mean(i,1),FC_err(i,1),'k.--','MarkerSize',20,'LineWidth',1);
        set(gca,'xscale','log');
        set(gca,'yscale','log');
        set(gca,'ycolor','k');
        ylim([0.1 30]);
        yyaxis right
        errorbar(dataPop(i,1)./58,Diff_mean(i,1),Diff_err(i,1),'.--','MarkerSize',20,'LineWidth',1,'Color',[0.2 0.6 0]);
        set(gca,'ycolor',[0.2 0.6 0]);
        xlim([8000 1000000]./58);
        ylim([0 100]);
        box on;
        title('30-mL');
        
    elseif dataPop(i,2) == 40
        hold on
        subplot(3,3,7)
        hold on
        yyaxis left
        errorbar(dataPop(i,1)./58,FC_mean(i,1),FC_err(i,1),'k.--','MarkerSize',20,'LineWidth',1);
        set(gca,'xscale','log');
        set(gca,'yscale','log');
        set(gca,'ycolor','k');
        ylim([0.1 30]);
        yyaxis right
        errorbar(dataPop(i,1)./58,Diff_mean(i,1),Diff_err(i,1),'.--','MarkerSize',20,'LineWidth',1,'Color',[0.2 0.6 0]);
        set(gca,'ycolor',[0.2 0.6 0]);
        xlim([8000 1000000]./58);
        ylim([0 100]);
        box on;
        title('40-mL');
        
    elseif dataPop(i,2) == 60
        hold on
        subplot(3,3,8)
        hold on
        yyaxis left
        errorbar(dataPop(i,1)./58,FC_mean(i,1),FC_err(i,1),'k.--','MarkerSize',20,'LineWidth',1);
        set(gca,'xscale','log');
        set(gca,'yscale','log');
        set(gca,'ycolor','k');
        ylim([0.1 30]);
        yyaxis right
        errorbar(dataPop(i,1)./58,Diff_mean(i,1),Diff_err(i,1),'.--','MarkerSize',20,'LineWidth',1,'Color',[0.2 0.6 0]);
        set(gca,'ycolor',[0.2 0.6 0]);
        xlim([8000 1000000]./58);
        ylim([0 100]);
        box on;
        title('60-mL');        
    end

end


%%

close all;
clc;

figure(2)

modelDens = load('Model_Dens_day0.mat');
modelDens_array = modelDens.D0;

modelFCD6_V2 = load('Model_FC_day6_matrix_V2.mat');
modelFCD6_V2_array = cell2mat(modelFCD6_V2.Model_FC_day6_matrix_V2);
modelFCD6_V5 = load('Model_FC_day6_matrix_V5.mat');
modelFCD6_V5_array = cell2mat(modelFCD6_V5.Model_FC_day6_matrix_V5);
modelFCD6_V10 = load('Model_FC_day6_matrix_V10.mat');
modelFCD6_V10_array = cell2mat(modelFCD6_V10.Model_FC_day6_matrix_V10);
modelFCD6_V20 = load('Model_FC_day6_matrix_V20.mat');
modelFCD6_V20_array = cell2mat(modelFCD6_V20.Model_FC_day6_matrix_V20);
modelFCD6_V30 = load('Model_FC_day6_matrix_V30.mat');
modelFCD6_V30_array = cell2mat(modelFCD6_V30.Model_FC_day6_matrix_V30);
modelFCD6_V40 = load('Model_FC_day6_matrix_V40.mat');
modelFCD6_V40_array = cell2mat(modelFCD6_V40.Model_FC_day6_matrix_V40);
modelFCD6_V60 = load('Model_FC_day6_matrix_V60.mat');
modelFCD6_V60_array = cell2mat(modelFCD6_V60.Model_FC_day6_matrix_V60);

% calculate means
mean_modelFCD6_V2 = mean(modelFCD6_V2_array,2);
mean_modelFCD6_V5 = mean(modelFCD6_V5_array,2);
mean_modelFCD6_V10 = mean(modelFCD6_V10_array,2);
mean_modelFCD6_V20 = mean(modelFCD6_V20_array,2);
mean_modelFCD6_V30 = mean(modelFCD6_V30_array,2);
mean_modelFCD6_V40 = mean(modelFCD6_V40_array,2);
mean_modelFCD6_V60 = mean(modelFCD6_V60_array,2);
mean_modelFCD6 = vertcat([mean_modelFCD6_V2' mean_modelFCD6_V5' mean_modelFCD6_V10' mean_modelFCD6_V20' mean_modelFCD6_V30' mean_modelFCD6_V40' mean_modelFCD6_V60']);

%calculate stds
std_modelFCD6_V2 = std(modelFCD6_V2_array,1,2);
std_modelFCD6_V5 = std(modelFCD6_V5_array,1,2);
std_modelFCD6_V10 = std(modelFCD6_V10_array,1,2);
std_modelFCD6_V20 = std(modelFCD6_V20_array,1,2);
std_modelFCD6_V30 = std(modelFCD6_V30_array,1,2);
std_modelFCD6_V40 = std(modelFCD6_V40_array,1,2);
std_modelFCD6_V60 = std(modelFCD6_V60_array,1,2);
std_modelFCD6 = vertcat([std_modelFCD6_V2' std_modelFCD6_V5' std_modelFCD6_V10' std_modelFCD6_V20' std_modelFCD6_V30' std_modelFCD6_V40' std_modelFCD6_V60']);

% calculate pop densities per volume
model_Dens_V2 = modelDens_array./2;
model_Dens_V5 = modelDens_array./5;
model_Dens_V10 = modelDens_array./10;
model_Dens_V20 = modelDens_array./20;
model_Dens_V30 = modelDens_array./30;
model_Dens_V40 = modelDens_array./40;
model_Dens_V60 = modelDens_array./60;
model_Dens = vertcat([model_Dens_V2 model_Dens_V5 model_Dens_V10 model_Dens_V20 model_Dens_V30 model_Dens_V40 model_Dens_V60]);

denslist = [10000 25000 50000 75000 100000 112000 125000 150000 175000 200000 250000 300000 350000 500000 700000 900000];
model_Dens_noVol = vertcat([denslist denslist denslist denslist denslist denslist denslist]);

popDensVol = (Dens./Vols)./58;
c = flip(distinguishable_colors(size(unique(Dens),1)),1);
allDens = unique(Dens);


% model data points
hold on
% errorbar(model_Dens,mean_modelFCD6,std_modelFCD6,'.','MarkerSize',20,'LineWidth',1,'Color',[0.85 0.85 0.85]);
for i=1:size(model_Dens,2)
    densMatch = find(allDens==model_Dens_noVol(i));
    hold on
    errorbar(model_Dens(i).*58,mean_modelFCD6(i),std_modelFCD6(i),'k.','LineWidth',1);
    plot(model_Dens(i).*58,mean_modelFCD6(i),'.','Color',c(densMatch,:),'MarkerSize',20);
    plot(model_Dens(i).*58,mean_modelFCD6(i),'ko','MarkerSize',6.5);
    clear densMatch
    hold on
end


% hold on
% plot(model_Dens,mean_modelFCD6,'k-','LineWidth',2);

% experimental data points
for i=1:size(popDensVol,1)
    densMatch = find(allDens==dataPop(i,1));
    hold on
    errorbar(popDensVol(i).*58,FC_mean(i),FC_err(i),'k.','LineWidth',1);
    plot(popDensVol(i).*58,FC_mean(i),'.','Color',c(densMatch,:),'MarkerSize',50);
    plot(popDensVol(i).*58,FC_mean(i),'ko','MarkerSize',15);
%     errorbar(popDensVol(i),FC_mean(i),FC_err(i),'k.','MarkerSize',50,'LineWidth',1);
    clear densMatch
    hold on
end

A = 1:size(allDens,1);
B = 1:size(allDens,1);

for i = 1:size(allDens,1)
    hold on
    f(i) = plot(A(i).*10^6,B(i).*10^6,'.','Color',c(i,:),'MarkerSize',20);
    hold on
end

hold on
legend([f(1),f(2),f(3),f(4),f(5),f(6),f(7),f(8),f(9),f(10),f(11),f(12),f(13),f(14),f(15),f(16),f(17)],{'172','431','862','1293','1724','1931','2155','2586','3017','3448','4310','5172','6034','8621','9483','12069','15517'},'Location','West');

set(gca,'yscale','log');
set(gca,'xscale','log');
% xlim([3*58*10^1 2*58*10^3]);
xlim([10^3 2*10^5]);
ylim([10^-1 3*10^1]);
xlabel('Pop. density / liquid volume (cells cm^{-1} mL^{-1})');
ylabel('Fold-change in pop. density after 6 days');
set(gca,'XminorTick','off');
set(gca,'YminorTick','off');
set(gca,'TickLength',[0.05, 0.1]);
set(gca,'LineWidth',1);
set(gca,'XColor','k');
set(gca,'YColor','k');
box on;







