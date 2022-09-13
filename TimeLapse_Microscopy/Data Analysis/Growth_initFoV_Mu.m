%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Net growth rate of colonies versus initial number of colonies in FoV %
%%% (scatter plots & histograms)

clear all;
close all;
clc;


load('MicroscopyData.mat'); 


color = {[0.35 0.35 0.86],[0.4 0 0.6]};
SeedDens = flipud([10000; 18000; 27000; 36000; 45000; 60000; 75000; 90000;]./22');
time=[0 10 20 30 40 50 60 70 80 90 96]';
density = [8 7 6 5 4 3 2 1];

for d=1:size(density,2)
    for r = 1:size(data.dens(density(d)).rep,2)
        
        area = data.dens(density(d)).rep(r).area;
        area = area.*(0.48^2);
        FoV = data.dens(density(d)).rep(r).FoV;
        t=1;
        i=1;
        k=1;

        while t<=size(FoV,2)
            uFoV(i)=FoV(t);
            t=t+FoV(t);
            i=i+1;
        end

        cFoV=cumsum(uFoV);
        x = [1:1:size(uFoV,2)];
        y = [0 cFoV];

        for j = 1:size(x,2)
           iAreaFoV(j) = nansum(area(1,(y(j)+1):y(j+1))); 
           fAreaFoV(:,j) = nansum(area(:,(y(j)+1):y(j+1)),2);
        end
        
        aFC=fAreaFoV./fAreaFoV(1,:);
        
        figure(1)     
        
        iAreaFoV_all{d,r} = iAreaFoV;
        fAreaFoV_all{d,r} = fAreaFoV;
        aveFC{d,r} = fAreaFoV_all{d,r}./iAreaFoV_all{d,r};
                
        for j=1:size(x,2)
        ind=find(aFC(:,j)==0,2);
        if    isempty(ind)
        f = fit(time,aFC(:,j),'exp1');
        mu(j)=f.b;
        elseif ind(1)>2
             f = fit(time(1:ind(1)),aFC(1:ind(1),j),'exp1');
        mu(j)=f.b;
      
            else
        mu(j)=0;
        end
        clear f ind
        end
        
        
            
            if r==1
                 MuTot=mu;
                 uFoVTot=uFoV;
            else
                MuTot=cat(2,MuTot,mu);
                uFoVTot=cat(2,uFoVTot,uFoV);
            end
        
        hold on
       
        
        fig=figure(1);
        subplot(2,4,d)      
        scatter(uFoV,mu,90,'filled','MarkerFaceAlpha',5/8,'MarkerFaceColor',color{1});
         set(gcf,'renderer','Painters')
        ylim([-0.07 0.07]);
        xlim([0 40])
        yticks([-0.06 -0.03 0 0.03 0.06])
         set(gca,'Fontsize',12);
        box on
        clear uFoV cFoV x y iAreaFoV fAreaFoV aFC mu xx yy
        
        

    end
    [f,gof]=fit(uFoVTot',MuTot','poly1');
    corrPearson = corrcoef(uFoVTot,MuTot);
    corr(d)=round(corrPearson(2),3);
    rSquare(d) = gof.rsquare;
    plot(min(uFoVTot):max(uFoVTot),f(min(uFoVTot):max(uFoVTot)),'--k');
    str1=[num2str(round(SeedDens(d))) 'cells /cm² on day 0 ','\rho = ' num2str(corr(d))];
    title(str1);
    xlabel('');
    ylabel('');
    
    figure(2)
    hold on
    subplot(2,4,d) 
    hold on
    histogram(MuTot,10,'Normalization','probability','FaceAlpha',5/8,'FaceColor',[0.5 0.5 0.5]);
    
    hold on
    box on
    set(gca,'XminorTick','off');
    set(gca,'YminorTick','off');
    set(gca,'TickLength',[0.05, 0.1]);
    set(gca,'LineWidth',1);
    set(gca,'XColor','k');
    set(gca,'YColor','k');
    xlim([-0.06 0.06]);
    ylim([0 0.4]);
        
    hold on
    xline(mean(MuTot),'-r','LineWidth',2);
    xline(0,'--k','LineWidth',2);
    title(['n = ', num2str(size(MuTot,2)), ', mean = ', num2str(round(mean(MuTot),3))]);
    
    figure(3)
    hold on
    subplot(2,4,d) 
    hold on
    histogram(uFoVTot,10,'Normalization','probability','FaceAlpha',5/8,'FaceColor',[0.5 0.5 0.5]);
    
    hold on
    box on
    set(gca,'XminorTick','off');
    set(gca,'YminorTick','off');
    set(gca,'TickLength',[0.05, 0.1]);
    set(gca,'LineWidth',1);
    set(gca,'XColor','k');
    set(gca,'YColor','k');
    xlim([0 30]);
    ylim([0 0.4]);
        
    hold on
    xline(mean(uFoVTot),'-r','LineWidth',2);
    title(['Mean = ', num2str(round(mean(uFoVTot),2))]);
    
    clear MuTot uFoVTot
end

    han=axes(fig,'visible','off'); 
    han.Title.Visible='on';
    han.XLabel.Visible='on';
    han.YLabel.Visible='on';
    ylabel(han,'Net growth rate of colonies in 1-mm² field-of-view');
    xlabel(han,'Initial number of colonies in ~1 mm² field-of-view');
    set(gca,'Fontsize',12);
    set(gcf,'renderer','Painters')
    