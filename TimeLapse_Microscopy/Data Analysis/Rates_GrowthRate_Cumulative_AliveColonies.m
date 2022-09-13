%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Calculation of growth rates based on cumulative (alive) colonies %%%

clear all;
close all;
clc;


load('MicroscopyData.mat'); 
      
      time=[0 10 20 30 40 50 60 70 80 90 96]';
   nSets=1;
   for d=1:size(data.dens,2)
        for r=1:size(data.dens(d).rep,2)
            area=data.dens(d).rep(r).area;
            area=area.*(0.48^2);
            
            % Fill NaNs with last reported area of that colony 
%             for i=1:size(area,2)
%                 if size(find(~isnan(area(:,i))),1)<size(area,1)
%                     indnan=find(isnan(area(:,i)));
%                     area(indnan,i)=area(indnan(1)-1,i);
%                 else
%                     area(:,i)=area(:,i);
%                 end
%             end


            
%             mArea{d,r}=mean(area,2,'omitnan'); % mean, omitnan
%             mArea{d,r}=mean(area,2,'includenan'); % mean, include nan
            mArea{d,r}=nansum(area,2); % sum
%             A=mArea{d,r}(1);
%             mArea{d,r}=mArea{d,r}-mArea{d,r}(1);
%             mArea{d,r}=cumsum(mArea{d,r});
%             A=mArea{d,r}(1);
%             mArea{d,r}=mArea{d,r}-mArea{d,r}(1);

%             aFC{d,r}=mArea{d,r}./A;
            aFC{d,r}=mArea{d,r}./mArea{d,r}(1);
            
            f = fit(time,aFC{d,r},'exp1');
%             f = fit(time(1:6),aFC{d,r}(1:6),'exp1'); % growth rate only in first two days
            mu(d,r)=f.b;
%             mu(d,r)=f.p1;
            
            figure(1)
            hold on;
            plot(f,time,aFC{d,r});
%             plot(f,time(1:6),aFC{d,r}(1:6)); % growth rate only in first two days
            hold on;
            clear area f
            
            xlabel('Time in hours');
            ylabel('Area FC');
            leg{nSets}=[data.dens(d).rep(r).name,' rep',num2str(r)];
            legend(leg);
            nSets=nSets+1;
            clear AreaAlT
            [xx yy]=find(mu==0);
        mu(xx,yy)=NaN;
        figure(2)
        SeedDens = [10000; 18000; 27000; 36000; 45000; 60000; 75000; 90000; 120000]';
        SeedDens=SeedDens./1000;
        plot(SeedDens(d),mu(d,r),'*','markersize',5,'Color',[0.5 0.5 0.5]);
        hold on
        end
%         [xx yy]=find(mu==0);
%         mu(xx,yy)=NaN;
%         figure(2)
%         SeedDens = [10000; 18000; 27000; 36000; 45000; 60000; 90000]';
%         SeedDens=SeedDens./1000;
%         plot(SeedDens(d),mu(d,r),'omitnan','.r','markersize',20)
%         hold on
%         errorbar(SeedDens(d),mean(mu(d,:)),std(mu(d,:)))
%         title('Colony-area growth rate (gain)','FontSize',10);
%         ylabel('Colony-area growth rate \mu (hr^-1)','FontWeight','bold','FontSize',12);
%         xlabel('Seeding number (X10^3)','FontWeight','bold','FontSize',12);
        xlim([0 100]);
%         ylim([0.005 0.035]);
        grid on
        box on
        
   end
   
   
   
%    for i=1:size(mu,1)
%        
%        
%    end
%    
%    f = fit(SeedDens,mu,'exp1');
%    hold on;
   
   
   figure(2)
   hold on
   [g,gof]=fit(SeedDens',mean(mu,2,'omitnan'),'poly1');
%    plot(SeedDens',mean(mu,2,'omitnan'),'.','MarkerSize',30,'Color',[0 0.4 0.8]);
%    errorbar(SeedDens',mean(mu,2,'omitnan'),std(mu',1,'omitnan'),'.','MarkerSize',30,'Color',[0 0.4 0.8]);
   errorbar(SeedDens',mean(mu,2,'omitnan'),std(mu',1,'omitnan'),'.','MarkerSize',30,'Color','k');
   hold on
   plot(g,'k--');
   
   str=['y = ' num2str(round(g.p1,5)) 'x + ' num2str(round(g.p2,3)) ' | R^2 = ' num2str(round(gof.rsquare,2))];
   annotation('textbox',[.15 .70 .2 .2],'String',str,'FitBoxToText','on');
   
%    title('Colony-area growth rate (gain)','FontSize',10);
   ylabel('Net growth rate (1 / hour)','FontWeight','bold','FontSize',15);
   xlabel('Initial # of cells X 10^3 / 6-cm diameter dish','FontWeight','bold','FontSize',15);
   xlim([0 100]);
   ylim([-0.02 0.02]);
%    ylim([-0.025 0.04]); % adjusted
   grid on
   box on
   
      figure(3)
   hold on
   [g,gof]=fit(SeedDens(1:8)',mean(mu(1:8,:),2,'omitnan'),'poly1');
%    plot(SeedDens',mean(mu,2,'omitnan'),'.','MarkerSize',30,'Color',[0 0.4 0.8]);
%    errorbar(SeedDens',mean(mu,2,'omitnan'),std(mu',1,'omitnan'),'.','MarkerSize',30,'Color',[0 0.4 0.8]);
   errorbar(SeedDens',mean(mu,2,'omitnan'),std(mu',1,'omitnan'),'.','MarkerSize',30,'Color','k');
   hold on
   plot(g,'k--');
   
   corrPearson = corrcoef(SeedDens(1:8),mean(mu(1:8,:),2,'omitnan'));
   str=['y = ' num2str(round(g.p1,5)) 'x + ' num2str(round(g.p2,3)) ' | R^2 = ' num2str(round(gof.rsquare,2)) ' | \rho = ' num2str(round(corrPearson(1,2),2))];
   annotation('textbox',[.15 .70 .2 .2],'String',str,'FitBoxToText','on');
   
%    title('Colony-area growth rate (gain)','FontSize',10);
   ylabel('Net growth rate (1 / hour)','FontWeight','bold','FontSize',15);
   xlabel('Initial # of cells X 10^3 / 6-cm diameter dish','FontWeight','bold','FontSize',15);
   xlim([0 100]);
   ylim([-0.02 0.02]);
%    ylim([-0.025 0.04]); % adjusted
%    grid on;
   box on;
    
   
   
   
