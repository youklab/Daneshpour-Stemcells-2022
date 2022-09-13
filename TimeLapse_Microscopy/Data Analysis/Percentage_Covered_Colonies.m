%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Percentage of dish area covered with colonies at the start %%%
%%% (for all densities)

clear all;
close all;
clc;


load('MicroscopyData.mat'); 


 Dens = [1 2 3 4 5 6 7 8];
 Density=[10 18 27 36 45 60 75 90]./21;
 
%  Dens= [2 4 8];
%  Density=[18000 36000 90000]./21;
 teller=1;
 AreaFoV=(17*2880*2048);
  for d=Dens
      for r=1:size(data.dens(d).rep,2)
          area=data.dens(d).rep(r).area;
          A0(r)=sum(area(1,:)); 
      end
      stdA0=std(A0);
      Err=stdA0./sqrt(r);
      ErrPerc=Err./AreaFoV;
      Perc=A0./AreaFoV;
      dens(d) = Density(teller).*1000;
      y(d) = mean(Perc)*100;
      sem(d) = ErrPerc*100;
      errorbar(Density(teller).*1000,mean(Perc)*100,ErrPerc*100,'.--', 'LineWidth', 1, 'MarkerSize', 30,'Color',[0 0 0]);
      hold on
      teller=teller+1;
      xlim([0 100./21].*1000);
      ylim([0 0.8]);
      xlabel('# cells / cm²');
      ylabel('% area covered');
      hold on
      clear A0 area
  end
