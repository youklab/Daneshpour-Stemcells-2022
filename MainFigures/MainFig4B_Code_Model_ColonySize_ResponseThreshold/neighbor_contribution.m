%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Model to explain how colony size & response threshold dictate %%%
%%% when local communication is enough for survival

% When the threshold concentration is low enough for communication within a
% colony to determine the colony's fate

clear all;
close all;
clc;

n = linspace(1,1000,1000);

% 1. For short diffusion length:
% a=1;  % diffusion length lambda = a*R;  R = radius of cell
% short_c(1) = 2*pi;
% for i=2:length(n)
%     short_c(i) =  short_c(i-1) + ((2*pi*i)/(2*i-1))*exp(-2*(i-1)/a);
% end


% 2. For long diffusion length:
a=170;
long_c(1) = 2*pi;
for i=2:length(n)
    long_c(i) =  long_c(i-1) + ((2*pi*i)/(2*i-1))*exp(-2*(i-1)/a);
end

figure(1)
hold on
plot(n.^2, long_c, '-k','LineWidth',5);
hold on
% legend('short diffusion length: lambda = one-cell radius (R)', 'long diffusion length: lambda = 100R');
xlabel('Initial colony area (in arbitrary, rel. units)');
ylabel('Concentration sensed by the center cell in the colony');
xlim([10^2 10^6]);
ylim([3*10^1 3*10^2]);
box on
set(gca,'xscale','log');
set(gca,'yscale','log');

hold on
yline(2.3*10^2,'--r','High C_{thresh}');
hold on
yline(6*10^1,'--r','Low C_{thresh}');

hold on
xline(150,'--k');
xline(1100,'--k');

set(gca,'XminorTick','off');
set(gca,'YminorTick','off');
set(gca,'TickLength',[0.02, 0.1]);
set(gca,'LineWidth',1);
set(gca,'XColor','k');
set(gca,'YColor','k');
hold off

