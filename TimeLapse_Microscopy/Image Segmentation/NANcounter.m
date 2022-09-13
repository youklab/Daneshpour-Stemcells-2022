g=0;
b=0;
for i=1:1:size(area,2)
    isnan(area(:,i))==1
        g=g+1;
    isnan(area(:,i))==0
        b=b+1;
end