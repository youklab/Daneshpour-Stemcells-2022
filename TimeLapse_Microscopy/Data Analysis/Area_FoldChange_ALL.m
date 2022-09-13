%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Fold-change in colony area after 4 days versus initial colony area %%%
%%% (all densities plotted together)

clear all;
close all;
clc;


load('MicroscopyData.mat'); 


time=[0 10 20 30 40 50 60 70 80 90 96];
nSets=1;

Tot_iArea = [];
Tot_fcArea = [];

     for d=1:size(data.dens,2)
%      for d=1
%             for r=1
            for r=1:size(data.dens(d).rep,2)
            area=data.dens(d).rep(r).area;
            area=area.*(0.48^2);
%             scatter(area(1,:),area(end,:)./area(1,:),40,'filled','MarkerFaceAlpha',5/8,'MarkerFaceColor',[0.5 0.5 0.5]);
            area(isnan(area))=0;
            Tot_iArea = horzcat(Tot_iArea,area(1,:));
            Tot_fcArea = horzcat(Tot_fcArea,area(end,:)./area(1,:));
            hold on
            end
     end
     
     Tot_fcArea_log = Tot_fcArea;
     Tot_fcArea_log(Tot_fcArea_log==0)=0.1;
     
     scatter(Tot_iArea,Tot_fcArea_log,60,'filled','MarkerFaceAlpha',5/8,'MarkerFaceColor',[0.5 0.5 0.5]);
     hold on
     
     [f,gof]=fit(Tot_iArea',Tot_fcArea','poly1');
     corrPearson = corrcoef(Tot_iArea,Tot_fcArea);
     plot(f,'--r');
     
     box on
     xlabel('Initial colony area (\mum^2)');
     ylabel('Fold change in colony area after 96hrs');
%      set(gca, 'XScale', 'log');
     set(gca, 'YScale', 'log');
%      xlim([10^2 2*10^3]);
     ylim([10^-1 2*10^2]);
     xlim([0 1500]);
     
     
     
     
