function [filename] = inputExcelDil()
[filename, folder] = uigetfile('*.xlsx','Select excel sheet with final densities');
if isequal(filename,0)
   disp('User selected Cancel');
   return
else
   disp(['User selected ', fullfile(folder, filename)]);
end
addpath(folder);
end