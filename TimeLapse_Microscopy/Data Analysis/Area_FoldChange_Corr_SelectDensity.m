%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Fold-change in colony area after 4 days versus initial colony area %%%
%%% (all densities combined)

clear all;
close all;
clc;


load('MicroscopyData.mat');


color = {[0.8 0.6 0],[0.4 0 0.6]};
density = [6 2];

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
           iAreaFoV(j) = sum(area(1,(y(j)+1):y(j+1))); 
           fAreaFoV(j) = sum(area(11,(y(j)+1):y(j+1)),'omitnan');
        end
        
        figure(1)
        hold on
        scatter(iAreaFoV./mean(area(1,:)),fAreaFoV./iAreaFoV,90,'filled','MarkerFaceAlpha',5/8,'MarkerFaceColor',color{d}); % to plot numbers per FoV
%         scatter(iAreaFoV,fAreaFoV./iAreaFoV,70,'filled','MarkerFaceAlpha',5/8,'MarkerFaceColor',color{d}); % to plot areas per FoV
               
        
        iAreaFoV_all{d,r} = iAreaFoV;
        fAreaFoV_all{d,r} = fAreaFoV;
        aveFC{d,r} = fAreaFoV_all{d,r}./iAreaFoV_all{d,r};
     

        clear uFoV cFoV x y iAreaFoV fAreaFoV

    end
end



% iAreaFoV_all_conc = cell2mat(iAreaFoV_all(:)');
% fAreaFoV_all_conc = cell2mat(fAreaFoV_all(:)');
% repMeans = mean(cell2mat(aveFC),2);


% for d=1:size(density,2)
%          figure(1)
%          hold on
%          line([0,25],[repMeans(d),repMeans(d)],'Color', color{d}, 'LineWidth', 1);
%          hold on
% end
     

iAreaFoV_all_1 = iAreaFoV_all(1,:);
iAreaFoV_all_1 = cat(2,iAreaFoV_all_1{:});
iAreaFoV_all_2 = iAreaFoV_all(2,:);
iAreaFoV_all_2 = cat(2,iAreaFoV_all_2{:});

fAreaFoV_all_1 = fAreaFoV_all(1,:);
fAreaFoV_all_1 = cat(2,fAreaFoV_all_1{:});
fAreaFoV_all_2 = fAreaFoV_all(2,:);
fAreaFoV_all_2 = cat(2,fAreaFoV_all_2{:});

figure(1)
hold on
[f,gof]=fit(iAreaFoV_all_1',fAreaFoV_all_1'./iAreaFoV_all_1','poly1');
corrPearson_1 = corrcoef(iAreaFoV_all_1,fAreaFoV_all_1./iAreaFoV_all_1);
rSquare_1 = gof.rsquare;
plot(f,'k--');

hold on
[g,gof]=fit(iAreaFoV_all_2',fAreaFoV_all_2'./iAreaFoV_all_2','poly1');
corrPearson_2 = corrcoef(iAreaFoV_all_2,fAreaFoV_all_2./iAreaFoV_all_2);
rSquare_2 = gof.rsquare;
plot(g,'r--');
hold on
            




% figure(2)

% hold on
% scatter(iAreaFoV_all_conc,fAreaFoV_all_conc./iAreaFoV_all_conc,70,'filled','MarkerFaceAlpha',6/8,'MarkerFaceColor',[0.5 0.5 0.5]);

% hold on
% [f,gof]=fit(iAreaFoV_all_conc',fAreaFoV_all_conc'./iAreaFoV_all_conc','poly1');
% 
% hold on
% plot(f,'k--');
% 
% hold on
% str=['y = ' num2str(round(f.p1,5)) 'x + ' num2str(round(f.p2,3)) ' | R^2 = ' num2str(round(gof.rsquare,2))];
% annotation('textbox',[.15 .70 .2 .2],'String',str,'FitBoxToText','on');

hold on
seedDens = [10 18 27 36 45 60 75 90 120];
title(['Condition: '  num2str(seedDens(density)) 'k cells / 6-cm diameter dish']);
xlabel('Initial number of colonies per FoV (\mum^2)','FontWeight','bold','FontSize',10);
ylabel('Fold-change in total colony-area per FoV after 96 hours','FontWeight','bold','FontSize',10);
xlim([0 25]);
ylim([0 12]);
box on;

hold on
str1=['R^2 = ' num2str(round(rSquare_1,5)) ' | \rho = ' num2str(round(corrPearson_1(2),3))];
annotation('textbox',[.15 .70 .2 .2],'String',str1,'FitBoxToText','on');
str2=['R^2 = ' num2str(round(rSquare_2,5)) ' | \rho = ' num2str(round(corrPearson_2(2),3))];
annotation('textbox',[.15 .60 .2 .2],'String',str2,'FitBoxToText','on');
% grid on;

% set(gca, 'XScale', 'log');
% set(gca, 'YScale', 'log');





