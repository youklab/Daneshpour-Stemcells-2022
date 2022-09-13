tellerSurv=1;
tellerDead=1;
initSurv=zeros(10,85);
initDead=zeros(10,31);
for j=1:size(areatot,2)

 

if sum(isnan(areatot(:,j)))==0
hold on
figure(1)
plot(areatot(:,j),'Color',[0.27 0.27 0.27])
hold on
initSurv(:,tellerSurv)=areatot(:,j);
tellerSurv=tellerSurv+1;
else
hold on
figure(1)
plot(areatot(:,j),'Color',[0.47 0.87 0.27],'LineWidth',2.5)
hold on
initDead(:,tellerDead)=areatot(:,j);
tellerDead=tellerDead+1;
hold on;
end

end
AreaM=mean(areatot,2,'omitnan');
figure(1)
plot(AreaM,'Color',[1 0 0],'linewidth',2.5);
figure(2)
% for t=1:10
% h1=histogram(initDead(t,:),12);
% xlim([0 8000])
% ylim([0 20])
% hold on
% h2=histogram(initSurv(t,:));
% xlim([0 15000])
% ylim([0 20])
% h2.BinWidth=h1.BinWidth;
% pause(1.5)
% xlim([0 15000])
% clf
% end