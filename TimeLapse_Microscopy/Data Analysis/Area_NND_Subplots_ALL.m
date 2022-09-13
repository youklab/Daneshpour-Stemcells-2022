%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Nearest neighbor distances for colonies at start of differentiation %
%%% (all densities combined)

clear all;
close all;
clc;


load('MicroscopyData.mat'); 

time=[0 10 20 30 40 50 60 70 80 90 96];
nSets=1;

    for d=1:size(data.dens,2)-1
        NND_final = [];
        areaFC_final = [];
            for r=1:size(data.dens(d).rep,2)
                iFoV{d,r}=data.dens(d).rep(r).FoV;
                Dead{d,r}=data.dens(d).rep(r).deadT;
                areaT=data.dens(d).rep(r).area;
                areaT=areaT.*(0.48^2);
                CoMx=data.dens(d).rep(r).CoMx;
                CoMy=data.dens(d).rep(r).CoMy;
                CoMx=CoMx.*0.48;
                CoMy=CoMy.*0.48;
                nSets=nSets+1;

                ind=1;
                i=1;
                FoVtest=iFoV{d,r};
                DeadTtest=Dead{d,r};

                    while ind<=size(FoVtest,2)
                    pFoV(i)=FoVtest(ind);
                    pDeadT(i)=mean(DeadTtest(1,ind:(ind+(FoVtest(ind)-1))),'omitnan');
                    CoMxTemp=CoMx(1,ind:(ind+(FoVtest(ind)-1)));
                    CoMyTemp=CoMy(1,ind:(ind+(FoVtest(ind)-1)));
                    areaFC=areaT(end,ind:(ind+(FoVtest(ind)-1)))./areaT(1,ind:(ind+(FoVtest(ind)-1)));
                    
                        for k=1:size(CoMxTemp,2)
                            for n=1:size(CoMxTemp,2)
                                dist(k,n)=sqrt(((CoMxTemp(k)-CoMxTemp(n)).^2)+((CoMyTemp(k)-CoMyTemp(n)).^2));
                                if dist(k,n)==0
                                    dist(k,n)=NaN;
                                end
                            end
                        end
                        
                    distance{d,r,i}=dist;
                    
                    for n=1:size(CoMxTemp,2)
                        NND(n)=min(dist(:,n));
                    end
                    
                    i=i+1;
                    ind=ind+FoVtest(ind);                    
                    NND_final = cat(2,NND_final,NND);
                    NND_final_matrix{d,r} = mean(NND);
                    areaFC_final = cat(2,areaFC_final,areaFC);
                    
                    
                    clear CoMxTemp CoMyTemp dist NND AreaFC;
                    end
                    SeedDens = [10000; 18000; 27000; 36000; 45000; 60000; 75000; 90000]';
                    SeedDens=SeedDens./1000;

                    clear NNDi areaT                   
                    
            end
             
    
        areaFC_final(isnan(areaFC_final))=4*10^-1;
        NND_final(isnan(NND_final))=0;
        figure(1)
        hold on
        subplot(3,3,d)
        hold on
        scatter(NND_final,areaFC_final,30,'filled','MarkerFaceAlpha',5/8,'MarkerFaceColor',[0.5 0.5 0.5]);
        [f,gof]=fit(NND_final',areaFC_final','poly1');
                
        corrPearson = corrcoef(NND_final,areaFC_final);
        rSquare = gof.rsquare; 

        hold on
        f_x = [10^1:1:8*10^1];
        plot(f_x,f.p2 + f.p1 .* f_x,'r-','LineWidth',2);
        hold on

        hold on
        box on

        set(gca, 'XScale', 'log');
        set(gca, 'YScale', 'log');
        set(gca,'XminorTick','off');
        set(gca,'YminorTick','off');
        set(gca,'TickLength',[0.05, 0.1]);
        set(gca,'LineWidth',1);
        set(gca,'XColor','k');
        set(gca,'YColor','k');
        xlim([10^1 10^3]);
        ylim([4*10^-1 2*10^2]);
        
        title(['R^2 = ', num2str(round(rSquare(1),5)), ' | \rho = ', num2str(round(corrPearson(1,2),3))]);
        
        figure(2)
        hold on
        subplot(3,3,d)
        hold on
        histogram(NND_final,15,'Normalization','probability','FaceAlpha',5/8,'FaceColor',[0.5 0.5 0.5]);
        
        hold on
        box on
        
        set(gca,'XminorTick','off');
        set(gca,'YminorTick','off');
        set(gca,'TickLength',[0.05, 0.1]);
        set(gca,'LineWidth',1);
        set(gca,'XColor','k');
        set(gca,'YColor','k');
        xlim([10^1 10^3]);
        ylim([0 0.3]);
        
        hold on
        xline(mean(NND_final),'-r','LineWidth',2);
        title(['n = ', num2str(size(NND_final,2)), ', mean = ', num2str(round(mean(NND_final),0))]);
        
        figure(3)
        
        SeedDens = [10000; 18000; 27000; 36000; 45000; 60000; 75000; 90000; 120000]./21';
        y(d) = mean(NND_final);
        sem(d) = std(cell2mat(NND_final_matrix(d,:)'),1,'omitnan');
        errorbar(SeedDens(d),mean(NND_final),std(cell2mat(NND_final_matrix(d,:)'),1,'omitnan'),'.k','MarkerSize',30);
%         errorbar(SeedDens(d),mean(NND_final),std(NND_final,1,'omitnan'),'.k','MarkerSize',30);
        xlim([0 100000./21]);
        ylim([0 500]);
        hold on

        
        clear NND_final areaFC_final f f_x corrPearson rSquare   

    end
    




    



