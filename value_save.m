%%%Save Output Values in Excel%%%

name=[pre,filenamei,'_chan',num2str(chan_loop),'.xls'];
var={'Bin lower (um)','Bin upper (um)','Sum Intensity','Average Intensity','Average Intensity Normalized','Area um^2','Total Bin Area um^2','Bckgrnd Threshold','Avg Bckgrnd Int','Bckgrnd STD' ...
    '#Subthresh pxl','Signal Threshold','%Threshold'};    

%Row 1: Variable names  
xlswrite(name,var,1,'A1');
%Lower Bin
xlswrite(name,d1_bin',1,'A2');
%Upper Bin
xlswrite(name,d2_bin',1,'B2');
%Sum Bin Intensity
xlswrite(name,bin_intsum',1,'C2');
%Mean Bin Intensity
xlswrite(name,bin_intraw',1,'D2');
%Mean Bin Intensity Normalized
xlswrite(name,bin_int',1,'E2');
%Mean Bin Area
xlswrite(name,bin_area',1,'F2');
%Total Bin Area
xlswrite(name,tot_bin_area',1,'G2');
%Threshold for Noise Calculation
xlswrite(name,thresh,1,'H2');
%Average Background Intensity
xlswrite(name,avgbk,1,'I2');
%Standard Deviation of Background Intensity
xlswrite(name,stdbk,1,'J2');
%Number of Pixels below Threshold (used for Noise calculation)
xlswrite(name,stn0,1,'K2');
%Signal Threshold for Exerpimental image 
xlswrite(name,avgbkn,1,'L2');
%Percent of Pixels below Signal Threshold
xlswrite(name,stn,1,'M2');
