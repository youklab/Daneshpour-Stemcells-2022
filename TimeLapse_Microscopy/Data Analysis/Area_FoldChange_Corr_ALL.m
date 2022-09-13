%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Fold-change in colony area after 4 days versus initial colony area %%%
%%% (all densities combined)

clear all;
close all;
clc;


load('MicroscopyData.mat'); 

for d = 1:size(data.dens,2)
    for r = 1:size(data.dens(d).rep,2)
        
        area = data.dens(d).rep(r).area;
        area = area.*(0.48^2);
        FoV = data.dens(d).rep(r).FoV;
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
        
        iAreaFoV_all{d,r} = iAreaFoV;
        fAreaFoV_all{d,r} = fAreaFoV;
     
%         figure(1)
%         
%         hold on
%         scatter(iAreaFoV,fAreaFoV./iAreaFoV,40,'filled','MarkerFaceAlpha',5/8,'MarkerFaceColor',[0.5 0.5 0.5]);
%         hold on
        
        clear uFoV cFoV x y iAreaFoV fAreaFoV

    end
end

iAreaFoV_all_conc = cell2mat(iAreaFoV_all(:)');
fAreaFoV_all_conc = cell2mat(fAreaFoV_all(:)');

figure(2)

hold on
scatter(iAreaFoV_all_conc,fAreaFoV_all_conc./iAreaFoV_all_conc,40,'filled','MarkerFaceAlpha',5/8,'MarkerFaceColor',[0.5 0.5 0.5]);

hold on
[f,gof]=fit(iAreaFoV_all_conc',fAreaFoV_all_conc'./iAreaFoV_all_conc','poly1');

hold on
plot(f,'k--');

hold on
str=['y = ' num2str(round(f.p1,5)) 'x + ' num2str(round(f.p2,3)) ' | R^2 = ' num2str(round(gof.rsquare,2))];
annotation('textbox',[.15 .70 .2 .2],'String',str,'FitBoxToText','on');

hold on
xlabel('Total initial colony-area per FoV','FontWeight','bold','FontSize',15);
ylabel('FC colony-area per FoV after 96 hours','FontWeight','bold','FontSize',15);
% % xlim([0 12]);
% % ylim([0 100]);
box on;
grid on;

% set(gca, 'XScale', 'log');
% set(gca, 'YScale', 'log');

