%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Cumulative area of alive colonies, plotted over time %%%

clear all;
close all;
clc;


load('MicroscopyData.mat'); 


%     for density=1:size(data.dens,2)-1
    for density=8    
        AreaL_final = zeros(11,1);
%             for replicate=3
            for replicate=1:size(data.dens(density).rep,2)


    time=[0 10 20 30 40 50 60 70 80 90 96];
    timefit=[0 10 20 30 40 50 60 70 80 90 96]';
    area=data.dens(density).rep(replicate).area;
    area=area.*(0.48^2);
    DeadT=data.dens(density).rep(replicate).deadT;
    Dead=numel(find(data.dens(density).rep(replicate).deadT~=size(area,1)));
    Surv=size(area,2)-Dead;
    
    i=1;
    AreaL=zeros(11,1);
    mArea=nansum(area(1,:),2); %nansum
    
for i=1:10
    PerAl(i)=size(find(DeadT==i),2); %second method
    AreaL(i+1)=AreaL(i) + nansum(area(i,find(DeadT==i))); %second method
    area(i,find(DeadT==i))
    
    if i>1
    PerAl(i) = PerAl(i-1) + size(find(DeadT==i),2); %second method
    AreaL(i+1) = AreaL(i) + nansum(area(i,find(DeadT==i))); %second method
    end
end

AreaL=AreaL./mArea(1);

figure(1)

[f,gof] = fit(timefit(1:11),AreaL,'exp1');

color_rep = {[0.2 0.6 0],[0 0.4 1],[1 0.4 0]};

figure(1)
% subplot(3,3,density)
hold on
plot(time(1:end),AreaL,'.','markersize',30,'Color',color_rep{replicate});
hold on
% stairs(time(1:end),AreaL,'-k');
% cdfplot(AreaL);
hold on
h1 = plot(f,'--');
set(h1,'color',color_rep{replicate});
set(h1,'LineWidth',3);
% xlabel('Time t (hours)','FontWeight','bold','FontSize',15);
% ylabel('Cumulative area of dead colonies (t)','FontWeight','bold','FontSize',15);

figure(1)
% subplot(3,3,density)
hold on
str = ['\gamma_',num2str(replicate),' = ',num2str(f.b),', R^2 = ',num2str(round(gof.rsquare,3))];
annot_pos = .70 - (replicate-1)./10;
annotation('textbox',[.15 annot_pos .2 .2],'String',str,'FitBoxToText','on','Color',color_rep{replicate});
box on;

ylim([0 1.5]);
xlim([-1 100]);
% set(gca,'yscale','log')
box on;
% set(gca, 'YScale', 'log');
% set(gca,'YminorTick','off');
set(gca,'TickLength',[0.05, 0.1]);
set(gca,'LineWidth',1);
set(gca,'XColor','k');
set(gca,'YColor','k');
            end
    end



