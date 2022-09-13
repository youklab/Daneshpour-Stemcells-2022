%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Stochastic survival-vs-extinction fates of populations near %%%
%%% density threshold

%% Load data
stat15d = xlsread('FinalPop-P1-lowpopzeros (2).xlsx',16);
stat16d = xlsread('FinalPop-P1-lowpopzeros (2).xlsx',17);
expData= xlsread('FinalPop-P1-lowpopzeros (2).xlsx',7);

%% Read & process data

D0 = stat15d(:,1);
D0=flipud(D0);
expData(11,:)=stat15d(11,:);
expData(12,:)=stat16d(12,:);
At=expData;
At([16 17],2:4)=0;
At=flipud(At);
teller=1;

for i=1:size(At,1)
    sliceD=At(i,2:end);
    [x ind]=find(sliceD<3000)
    if ~isempty(ind)
    At(i,ind+1)=1;
    end
    [x ind]=find(sliceD>=3000);
    if ~isempty(ind)
        At(i,ind+1)=0;
    end
    [x ind]=find(~isnan(At(i,2:end)))
    if i==1
        summarY=At(i,ind+1);
        
        for j=1:numel(ind)
            if j==1
            summaryX=At(i,1);
            else
            summaryX=horzcat(summaryX,At(i,1)); 
            end
        end
        
    else
    summarY=horzcat(summarY,At(i,ind+1));
        for j=1:numel(ind)
                summaryX=horzcat(summaryX,At(i,1));     
        end
    end
    
end



%% Logistic regression for experimental data

[b,dev,stats] = mnrfit(summaryX,summarY+1);
xFitD=linspace(0,900000,10000);
z = b(1) + (xFitD * b(2));
z = 1./(1 + exp(-z));
LogRegExp = [xFitD',z'];
LogRegExp = sortrows(LogRegExp);
plot(LogRegExp(:,1)./58,(1-LogRegExp(:,2)).*100,'-r','LineWidth',3);

hold on
plot(summaryX./58,summarY.*100,'k.','MarkerSize',25);

xlabel('Initial number of cells / cm²'); 
ylabel('% of replicates that went extinct after 15 days');  
set(gca,'xscale','log');
% xlim([10 10000]);
xlim([100 1000000/58]);
set(gca, 'XMinorTick','Off');

%% Compare model & experiments


data=load('1408_Statitics_Surival_LogRegPlot.mat');
At_all=data.At_all;
D0=data.D0;

At_all2=ones(size(D0,2),size(At_all,2));
At_all2(1:size(At_all,1)-1,:)=At_all(1:end-1,:);
    
At_all=At_all2;


for i=1:size(At_all,1)
    for j=1:size(At_all,2)
        if At_all(i,j)>0
            At_all(i,j)=1;
        end
        
    end
    percExt2(i)=abs((100-100*sum(At_all(i,:))./size(At_all,2)));
end

figure(1)
plot(D0,percExt2,'--r','Markersize',5,'Linewidth',2);
hold on
xlabel('Initial number of cells / cm²'); 
ylabel('% of replicates that went extinct after 15 days');   
yticks([0 20 40 60 80 100])
set(gca,'xscale','log');
xlim([100 10000]);
set(gca, 'XMinorTick','Off');
xticks([10 100 1000 10000]);


D0_unique = unique(summaryX);
for i=1:size(D0_unique,2)
    D0_unique_perc(i) = mean(summarY(summaryX==D0_unique(i))).*100;
end

hold on
plot(D0_unique./58,D0_unique_perc,'.k','Markersize',30);
legend('Model (n = 10)','Experiments (n >= 3)');

