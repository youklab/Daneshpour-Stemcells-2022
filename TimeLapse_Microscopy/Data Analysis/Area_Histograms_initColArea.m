%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Histograms of initial colony areas as a function of initial density %%
%%% (for all densities)

clear all;
close all;
clc;


load('MicroscopyData.mat'); 


time=[0 10 20 30 40 50 60 70 80 90 96];
nSets=1;
D0 = round([10000 18000 27000 36000 45000 60000 75000 90000]./21,0);

     for d=1:8
%          for d=1
             iArea_final = [];
            for r=1:size(data.dens(d).rep,2)
%                 for r=1:3
            area=data.dens(d).rep(r).area;
            area=area.*(0.48^2);
            
            
%             scatter(area(1,:),area(end,:)./area(1,:),40,'filled','MarkerFaceAlpha',5/8,'MarkerFaceColor',[0.5 0.5 0.5]);
            
            iArea_final = cat(2,iArea_final,area(1,:));

            
            end
            
            figure(1)
            hold on
            subplot(3,3,d)
            hold on
            histogram(iArea_final,15,'Normalization','probability','FaceAlpha',5/8,'FaceColor',[0.5 0.5 0.5]);

            hold on
            box on

            set(gca,'XminorTick','off');
            set(gca,'YminorTick','off');
            set(gca,'TickLength',[0.02, 0.1]);
            set(gca,'LineWidth',1);
            set(gca,'XColor','k');
            set(gca,'YColor','k');
%             xlim([0 1500]);
            xlim([0 1200]);
            ylim([0 0.4]);

            hold on
            xline(mean(iArea_final),'-r','LineWidth',2);

            title([num2str(D0(d)) ' cells / cm^2, n = ', num2str(size(iArea_final,2)), ', mean = ', num2str(round(mean(iArea_final),1))]);
            
            clear iArea_final
            
            hold on
            
     end

