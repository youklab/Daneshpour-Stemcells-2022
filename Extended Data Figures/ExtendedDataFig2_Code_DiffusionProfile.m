%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Steady-state diffusion profile of secreted molecules %%%

clear all;
close all;
clc;

R = 7.5*10^-6;              % radius of spherical ES cell (m)
S = 100./(pi*R^2);          % constant molecule secretion rate (# molecules / m / secs) 
t_half = [0.1 10 48].*3600; % half-life of secreted molecule (secs)
gamma = log(2)./t_half;     % molecule degradation rate

rho = 1.35*10^6;            % Average protein density (g/cm3)
na = 6.022*10^23;           % Avogadro's number
kb = 1.38*10^-23;           % Boltzmann's constant (J/K)
T = 310.15;                 % Temperature (K)
n = 6.922*10^-4;            % Dynamic viscosity (Pa s)
r_mol = 16.4*10^-9;         % secreted molecule radius (m)
D = kb.*T./(6.*pi.*n.*r_mol);  % diffusion constant
lambda = sqrt(D ./ gamma);  % diffusion length

r = [0.01:0.01:8]./1000;    % radial distance from the center of ES cell

for i = 1:size(lambda,2)
    c_norm{i} = exp(-(r - R) ./ lambda(i));
    txt = ['t_{1/2} = ' num2str(t_half(i)./3600) ' hrs, \lambda = ' num2str(round(lambda(i).*1000,1)) ' mm'];
    plot(r.*1000,c_norm{i},'-','LineWidth',2,'DisplayName',txt);
    hold on
end

legend show
xlabel('Distance from secreting cell (mm)','FontWeight','bold');
ylabel('Normalized concentration','FontWeight','bold');
xlim([0 8]);
ylim([0 1]);
title('Steady-state diffusion profiles of a 100-kDa secreted molecule');

