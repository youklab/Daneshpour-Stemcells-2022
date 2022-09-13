%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Fold-change in colony area after 4 days versus initial colony area %%%
%%% (for selected densities)

clear all;
close all;
clc;


load('MicroscopyData.mat'); 


time=[0 10 20 30 40 50 60 70 80 90 96];
nSets=1;
color = {[0.2 0.8 1],[1 0.2 0.4]};
density = [6 2]; % selected densities


     for d=1:size(density,2)
         areaInit_final = [];
         areaFC_final = [];
            for r=1:size(data.dens(density(d)).rep,2)
            area=data.dens(density(d)).rep(r).area;
            area=area.*(0.48^2);
            ind=find(isnan(area(end,:)));
            area(end,ind)=0;
            
            figure(1)
            hold on
            scatter(area(1,:),area(end,:)./area(1,:),90,'filled','MarkerFaceAlpha',5/8,'MarkerFaceColor',color{d});
            hold on
            areaInit = area(1,:);
            areaFC = area(end,:)./area(1,:);
            areaInit_final = cat(2,areaInit_final,areaInit);
            areaFC_final = cat(2,areaFC_final,areaFC);
            
            aveFC{d,r} = mean(area(end,:)./area(1,:),'omitnan');
            hold on
            clear f areaInit areaFC
            
            end
            
            figure(1)
            hold on
            [f,gof]=fit(areaInit_final',areaFC_final','poly1');
            plot(f,'--');
            hold on
            
            corrPearson{d} = corrcoef(areaInit_final,areaFC_final);
            rSquare(d) = gof.rsquare;
                        
            clear areaInit_final areaFC_final
            
     end
     
%      repMeans = mean(cell2mat(aveFC),2);
%      for d=1:size(density,2)
%          figure(1)
%          hold on
%          line([0,1400],[repMeans(d),repMeans(d)],'Color', color{d}, 'LineWidth', 1);
%      end

     box on;
%      grid on;
     title('All seedings numbers and replicates are displayed','FontSize',10);
     xlabel('Initial colony area (\mum^2)','FontWeight','bold','FontSize',12);
     ylabel('Fold change in colony area after 96hrs','FontWeight','bold','FontSize',12);
     str1=['R^2 = ' num2str(round(rSquare(1),5)) ' | \rho = ' num2str(round(corrPearson{1}(2),3))];
     annotation('textbox',[.15 .70 .2 .2],'String',str1,'FitBoxToText','on');
     str2=['R^2 = ' num2str(round(rSquare(2),5)) ' | \rho = ' num2str(round(corrPearson{2}(2),3))];
     annotation('textbox',[.15 .60 .2 .2],'String',str2,'FitBoxToText','on');
     
%      ylim([0 18]);
     ylim([0.4 100]);
     xlim([0 1200]);
     set(gca, 'YScale', 'log');
