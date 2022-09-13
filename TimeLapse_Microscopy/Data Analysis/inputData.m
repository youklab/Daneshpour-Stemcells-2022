function [data] = inputData
%Input of the microscopy data
%   Detailed explanation goes here
curDir=cd;
nDens=input('Amount of densities: ');
 
for d=1:nDens
    
    reps=input('Amount of replicates: ');
    
    for r=1:reps
       
         selpath = uigetdir;
         name{d}=selpath(end-5:end)
         cd(selpath);
         FoV=dir('*XY*');
         nCells=1;
         
         for F=1:size(FoV,1)
             cd(FoV(F).name);
             cells=dir('*C0*');
             for i=1:size(cells,1)
                 load(cells(i).name);
                 dataT{1}.FoV=size(cells,1);
                 FoVtemp(nCells)=size(cells,1);
                 dataMic{nCells,d}=dataT;
                 deadTimeTemp(nCells)=size(dataMic{nCells,d},2);

                     for j=1:size(dataMic{nCells,d},2)
                        areatemp(j,nCells)=dataMic{nCells,d}{j}.Area;
                        CoMxtemp(j,nCells)=dataMic{nCells,d}{j}.CoM(1);
                        CoMytemp(j,nCells)=dataMic{nCells,d}{j}.CoM(2);
                     end

                 nCells=nCells+1;
             end
             mDeadTf(F)=mean(deadTimeTemp((nCells-i):nCells-1));
             gmDeadTf(F)=geomean(deadTimeTemp((nCells-i):nCells-1));
             nfield(F)=dataMic{nCells-1,d}{1}.FoV;
             cd(selpath)
         end
             mDeadT{d}=mDeadTf;
             gmDeadT{d}=gmDeadTf;
             nField{d}=nfield;
             clear mDeadTf;
             clear gmDeadTf;
             clear nfield;
                for k=1:size(areatemp,2)
                    xx=find(areatemp(:,k)==0);
                    areatemp(xx,k)=NaN;
                    CoMxtemp(xx,k)=NaN;
                    CoMytemp(xx,k)=NaN;
                end

            data.dens(d).rep(r).nCells=nCells-1;
            data.dens(d).rep(r).deadT=deadTimeTemp;
            data.dens(d).rep(r).area=areatemp;
            data.dens(d).rep(r).FoV=FoVtemp;
            data.dens(d).rep(r).CoMx=CoMxtemp;
            data.dens(d).rep(r).CoMy=CoMytemp;
            data.dens(d).rep(r).name=name{d};
            clear areatemp deadTimeTemp FoVtemp CoMxtemp CoMytemp;
    end

    
end
cd(curDir);
end