%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Phase diagram for survival-vs-extinction fate of differentiating ES %%%
%%% cells (modeling & experiments)


close all;
clear all;
clc;

load('200827_PhaseBoundary.mat')

D0=round([0:1000:10^6]./58);

% surf([1:80],D0.*58,phaseBound'.*100);
surf([1:80]./5.8,D0,phaseBound'.*100);
set(gca,'yscale','log');

% blue = D2EDFA
% red = d2edfa
% 'D2EDFA','FFFFFF','FABDB2'

% hcb=colorbar;
shading interp
% J = customcolormap_preset('blue-white-red');
% J = customcolormap([0 0.5 1],{'#0086b8','#ffffff','#f38597'}); % darker blue and red
J = customcolormap([0 0.5 1],{'#d2edfa','#ffffff','#fabdb2'}); % ligher blue and red
colormap(J);
colorbar;

% set(gca,'Fontsize',18);
% set(gca,'LineWidth',1.2);
xlabel('Volume of liquid medium (mL)');
ylabel('Initial number of cells/cm^2');
zlabel('fraction of populations that survive');
% colorTitleHandle = get(hcb,'Title');
% titleString = 'Percentage of populations that expand';
% set(colorTitleHandle ,'String',titleString);
% title("Phase-Diagram by running simulations (n=10)");
xlim([0 65./5.8]);
% ylim([10^4 10^6]./58);
ylim([10^2 (10^6)./58]);
box on;
% view(0,90);
view(180,-90);
set(gca,'xdir','reverse');
set(gca,'YminorTick','off');



%%-- plot experimental data points
filenameDil=inputExcelDil();
[status,sheetsDil] = xlsfinfo(filenameDil);
numSheets=size(sheetsDil,1);
dataFile=xlsread(filenameDil,sheetsDil{1});

Dens = dataFile(:,1);
Vols = dataFile(:,2);
FCs = dataFile(:,3:end);
FC_mean = mean(FCs,2,'omitnan')./Dens;

FC_color_A = [0 0.4 0.8]; % FC > 1
FC_color_B = [0 0.6 0]; % 0.61 < FC <= 1
FC_color_C = [1 0 0]; % FC <= 0.61

for i = 1:size(Dens,1)
    if FC_mean(i,1) > 1
        hold on
        plot(Vols(i,1)./5.8,Dens(i,1)./58,'.','MarkerSize',30,'Color',FC_color_A);
    elseif FC_mean(i,1) <= 0.6
        hold on
        plot(Vols(i,1)./5.8,Dens(i,1)./58,'.','MarkerSize',30,'Color',FC_color_C);
    else
        hold on
        plot(Vols(i,1)./5.8,Dens(i,1)./58,'.','MarkerSize',30,'Color',FC_color_B);       
    end
end




