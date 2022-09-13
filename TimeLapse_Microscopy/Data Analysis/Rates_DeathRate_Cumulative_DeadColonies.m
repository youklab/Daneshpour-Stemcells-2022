%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Calculation of death rates based on cumulative dead colonies %%%

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
            Dead{d,r}=data.dens(d).rep(r).deadT;
        
            i=1;
            AreaL=zeros(11,1);
            mArea=nansum(area(1,:),2); %nansum
%             mArea=mean(area(1,:),2); %nansum

            for i=1:10
%                     if i==1
                    PerAl(i)=size(find(Dead{d,r}==i),2);
%                     AreaL(i)=sum(area(i,find(Dead{d,r}==i))./area(1,find(Dead{d,r}==i))); %fold-change, sum
%                     AreaL(i+1)=nansum(area(i,find(Dead{d,r}==i))); %sum
                    AreaL(i+1)=AreaL(i)+nansum(area(i,find(Dead{d,r}==i))); %sum
%                     AreaL(i)=mean(area(i,find(Dead{d,r}==i)),'omitnan')./mArea; %mean
                    
                    area(i,find(Dead{d,r}==i))
%                     AreaL(i)=0;
%                     else
                        if i>1
                    PerAl(i)=PerAl(i-1)+size(find(Dead{d,r}==i),2);
%                     AreaL(i)=AreaL(i-1)+sum(area(i,find(Dead{d,r}==i))./area(1,find(Dead{d,r}==i))); %fold-change, sum
                    AreaL(i+1)=AreaL(i)+nansum(area(i,find(Dead{d,r}==i))); %sum
%                     AreaL(i)=nansum([ AreaL(i-1) mean(area(i,find(Dead{d,r}==i)),'omitnan')./mArea ]); %mean
                        end
%                     end
            end
            AreaL=AreaL./mArea(1);
            A=AreaL;
            
            f = fit(time(1:11),AreaL,'exp1');
%             f = fit(time(1:6),AreaL(1:6),'exp1'); % death rate only in first two days
            Gamma(d,r)=f.b;
            figure(1)
            hold on;
            plot(f,time(1:11),AreaL);
%             plot(f,time(1:6),AreaL(1:6)); % death rate only in first two days
            hold on
            clear aTemp PerAl AreaL area
            xlabel('Time in hours');
            ylabel('Area FC');
            leg{nSets}=[data.dens(d).rep(r).name,' rep',num2str(r)];
            legend(leg);
            nSets=nSets+1;
            [xx yy]=find(Gamma==0);
            
        Gamma(xx,yy)=NaN;
        figure(2)
        SeedDens = [10000; 18000; 27000; 36000; 45000; 60000; 75000; 90000; 120000]';
        SeedDens=SeedDens./1000;
        plot(SeedDens(d),Gamma(d,r),'*','markersize',5,'Color',[0.5 0.5 0.5])
        hold on

        end
        
   end
   

   figure(2)
   hold on
%    plot(SeedDens',mean(Gamma,2,'omitnan'),'.','MarkerSize',30,'Color',[1 0 0]);
%    errorbar(SeedDens',mean(Gamma,2,'omitnan'),std(Gamma',1,'omitnan'),'.','MarkerSize',30,'Color',[1 0 0]);
   errorbar(SeedDens',mean(Gamma,2,'omitnan'),std(Gamma',1,'omitnan'),'.','MarkerSize',30,'Color','k');
   
   %%linear fit
   [f,gof]=fit(SeedDens(1:8)',mean(Gamma(1:8,:),2,'omitnan'),'poly1');
   hold on
   plot(f,'k--');
   str=['y = ' num2str(round(f.p1,5)) 'x + ' num2str(round(f.p2,3))  ' | R^2 = ' num2str(round(gof.rsquare,2))];
   annotation('textbox',[.15 .70 .2 .2],'String',str,'FitBoxToText','on');
   
   %%horizontal fit
%    [f,gof]=polyfit(SeedDens',mean(Gamma,2,'omitnan'),0);
%    hold on
%    line([0,130],[f,f],'Color','black','LineStyle','--');

   hold on
%    title('Colony-area death rate (loss)','FontSize',10);
   ylabel('Death rate (1 / hour)','FontWeight','bold','FontSize',15);
   xlabel('Initial # of cells X 10^3 / 6-cm diameter dish','FontWeight','bold','FontSize',15);
   xlim([0 130]);
   ylim([0.001 0.045]);
%    ylim([0.005 0.06]); % adjusted
%    grid on;
   box on;
   
   figure(3)
   hold on
%    plot(SeedDens',mean(Gamma,2,'omitnan'),'.','MarkerSize',30,'Color',[1 0 0]);
%    errorbar(SeedDens',mean(Gamma,2,'omitnan'),std(Gamma',1,'omitnan'),'.','MarkerSize',30,'Color',[1 0 0]);
   errorbar((SeedDens'.*1000)./21,mean(Gamma,2,'omitnan'),std(Gamma',1,'omitnan'),'.','MarkerSize',30,'Color','k');
   
   %%linear fit
   [f,gof]=fit([(SeedDens'.*1000)./21]',mean(Gamma(1:8,:),2,'omitnan'),'poly1');
   hold on
   plot(f,'k--');
   
   corrPearson = corrcoef((SeedDens'.*1000)./21,mean(Gamma(1:8,:),2,'omitnan'));
   str=['y = ' num2str(round(f.p1,5)) 'x + ' num2str(round(f.p2,3))  ' | R^2 = ' num2str(round(gof.rsquare,2)) ' | \rho = ' num2str(round(corrPearson(1,2),2))];
   annotation('textbox',[.15 .70 .2 .2],'String',str,'FitBoxToText','on');
   
   %%horizontal fit
%    [f,gof]=polyfit(SeedDens',mean(Gamma,2,'omitnan'),0);
%    hold on
%    line([0,130],[f,f],'Color','black','LineStyle','--');

   hold on
%    title('Colony-area death rate (loss)','FontSize',10);
   ylabel('Death rate (1 / hour)','FontWeight','bold','FontSize',15);
   xlabel('Initial # of cells X 10^3 / 6-cm diameter dish','FontWeight','bold','FontSize',15);
   xlim([0 100000./21]);
   ylim([0.005 0.045]);
%    ylim([0.005 0.06]); % adjusted
%    grid on;
   box on;
   set(gca, 'XScale', 'log');
    
   

