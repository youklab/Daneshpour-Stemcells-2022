%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Average initial colony area at the start of differentiation %%%
%%% (for all densities)

clear all;
close all;
clc;


load('MicroscopyData.mat'); 


 Dens = [1 2 3 4 5 6 7 8];
 Density=[10 18 27 36 45 60 75 90];
 teller=1
  for d=Dens
      for r=1:size(data.dens(d).rep,2)
          area=data.dens(d).rep(r).area;
          area=area.*(0.48^2)
          A0mean(r)=mean(area(1,:))
      end
      stdA0=std(A0mean);
      Err=stdA0./sqrt(r);
      errorbar((Density(teller).*1000)./21,mean(A0mean),Err,'.', 'LineWidth', 1, 'MarkerSize', 30,'Color',[0 0 0]);
      teller=teller+1;
      xlim(([0 100].*1000)./21);
      ylim([250 550]);
      xlabel('Initial number of cells / cm^2')
      ylabel('Average initial colony area (\mum^2)')
      hold on
      clear A0 area A0means
  end
