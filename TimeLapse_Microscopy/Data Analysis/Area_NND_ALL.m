%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Nearest neighbor distances for colonies at start of differentiation %
%%% (all densities combined)

clear all;
close all;
clc;


load('MicroscopyData.mat'); 

time=[0 10 20 30 40 50 60 70 80 90 96];
nSets=1;

    for d=1:size(data.dens,2)
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
                    
%                     NNDm{d,r,i}=mean(NND,'omitnan');
%                     aFoV=1399.16*994.95;
%                     NNDi(i)=2*mean(NND,'omitnan')./sqrt(aFoV/size(CoMxTemp,2));
%                     NNDm{d,r}=mean(NND,'omitnan')
%                     NNDind{d,r}=NNDi;
                    i=i+1;
                    ind=ind+FoVtest(ind);
                    scatter(NND,areaFC,40,'filled','MarkerFaceAlpha',5/8,'MarkerFaceColor',[0.5 0.5 0.5]);
                    hold on
                    
                    clear CoMxTemp CoMyTemp dist NND AreaFC;
                    end
                    SeedDens = [10000; 18000; 27000; 36000; 45000; 60000; 75000; 90000]';
                    SeedDens=SeedDens./1000;
%                     NNDindM{d,r}=mean(NNDi,'omitnan')
                    clear NNDi areaT
%                     subplot(2,1,1)
%                     plot(SeedDens(d),NNDindM{d,r},'.b','markersize',30);
%                     hold on
%                     ylabel('NND index');
%                     xlabel('Seeding number (X10^3)')  
%                     subplot(2,1,2)
%                     plot(SeedDens(d),NNDm{d,r},'.b','markersize',30);
%                     hold on
%                     ylabel('NND (\mum)');
%                     xlabel('Seeding number (X10^3)')
%                     grid on
                   
                    
            end
    end
    
    box on
    grid on
    title('All seedings numbers and replicates are displayed','FontSize',10);
    xlabel('Initial Nearest Neighbour Distance (\mum)','FontWeight','bold','FontSize',12);
    ylabel('Fold change in colony area after 96hrs','FontWeight','bold','FontSize',12);
