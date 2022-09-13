%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Growth curves of colonies, plotted in time %%%
%%% (for all densities in subplots)

clear all;
close all;
clc;


load('MicroscopyData.mat'); 


    for density=1:size(data.dens,2)-1
        AreaL_final = zeros(11,1);
            for replicate=1:size(data.dens(density).rep,2)
                
    time=[0 10 20 30 40 50 60 70 80 90 96];
    area=data.dens(density).rep(replicate).area;
    area=area.*(0.48^2);
    Dead=numel(find(data.dens(density).rep(replicate).deadT~=size(area,1)));
    Alc=1;
    Dc=1;
      
    for i=1:size(area,2)
        if sum(isnan(area(:,i)))==0
            %Find alive colonies
            AreaAl(:,Alc)=area(:,i);
            
            figure(1);
            subplot(3,3,density)
            hold on
            plot(time,area(:,i)./area(1,i),'Color',[0.6 0.6 0.6]);
            hold on
        else
            figure(1)
            subplot(3,3,density)
            hold on
            plot(time,area(:,i)/area(1,i),'Color',[0.6 0.6 0.6]);
            hold on
        end
    end
           
        mArea=mean(area,2,'omitnan');
        AreaL=mArea./mArea(1);
        AreaL_final(:,replicate) = AreaL;
           end
    
           
        hold on
        figure(1)
        subplot(3,3,density)
        hold on
        plot(time,mean(AreaL_final,2,'omitnan'),'g-','LineWidth',3);
        xlim([-1 100]);
        ylim([3*10^-1 10^2]);
        box on;
        set(gca, 'YScale', 'log');
        set(gca,'YminorTick','off');
        set(gca,'TickLength',[0.05, 0.1]);
        set(gca,'LineWidth',1);
        set(gca,'XColor','k');
        set(gca,'YColor','k');        
        clear AreaL_final f mArea

            
            
    end




