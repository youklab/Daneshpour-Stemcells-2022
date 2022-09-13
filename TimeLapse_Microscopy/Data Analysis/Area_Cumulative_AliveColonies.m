%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Cumulative area of alive colonies, plotted over time %%%

clear all;
close all;
clc;


load('MicroscopyData.mat'); 


    for density=1:size(data.dens,2)-1
%     for density=6    
        AreaL_final = zeros(11,1);
%             for replicate=3
            for replicate=1:size(data.dens(density).rep,2)

    time=[0 10 20 30 40 50 60 70 80 90 96];
    area=data.dens(density).rep(replicate).area;
    area=area.*(0.48^2);
    Dead=numel(find(data.dens(density).rep(replicate).deadT~=size(area,1)));
    Alc=1;
    Dc=1;
    
    figure(1)
        mArea=nansum(area,2); % sum
        AreaL=mArea./mArea(1);
        
        [f,gof] = fit(time',AreaL,'exp1','StartPoint',[0 1]);
        color_rep = {[0.2 0.6 0],[0 0.4 1],[1 0.4 0]};
        
        figure(1)
        subplot(3,3,density)
        hold on
        plot(time,AreaL,'.','markersize',40,'Color',color_rep{replicate});
        hold on
        h1 = plot(f,'--');
        set(h1,'color',color_rep{replicate});
        set(h1,'LineWidth',3);
        xlabel('Time (hours)');
        ylabel('Cum area (\mum^2)');
        
        str = ['\mu_',num2str(replicate),' = ',num2str(f.b),', R^2 = ',num2str(round(gof.rsquare,3))];
        annot_pos = .70 - (replicate-1)./10;
        annotation('textbox',[.15 annot_pos .2 .2],'String',str,'FitBoxToText','on','Color',color_rep{replicate});
        box on;
            end
    end
        