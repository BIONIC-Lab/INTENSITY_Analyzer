%I.N.T.E.N.S.I.T.Y. Analyzer v1.1
%NTE Lab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Before you run this script, you need to prepare the
%following information:
%-Electrode size (Radius or Height and Width in MICRONS)
%-Bin Size (MICRONS)
%-Number of Bins (MICRONS)
%    =NOTE: if any of your bin exceeds the image size, you will get an
%    error
%-Scale Conversion (MICRONS/PIXEL)

close all; clear all; clc;

choice=menu('New file?','New File','Load File','Plot files');
%New File
if choice==1
    
    %%%Create folder with data%%%
    start=uigetdir('C:\','Where to save data?');
    foldname=input('Name your new folder to save analysis: ','s');
    mkdir(start,foldname);
    cd([start,'\',foldname]); stop=pwd;
    
    isetname=input('What is the name of this dataset?: ', 's');
    iat=menu('What Type of Electrode Analysis Today?','Radial Probe','Planar Probe','Planar(Multishank)','Planar Probe(Single side)','Planar(Single side Multishank');
    
    if iat~=1
        iERw=input('1) Width of Electrode in microns?: ');
        iERh=input('   Height of Electrode in microns?: ');
    else
        iER=input('1) Radius of Electrode in microns?: ');
    end
    %bin parameters
    iBins=input('2) What Bin Size in microns?: ');
    iNumBin=input('3) How Many Bins?: ');
    iScalemp=input('4) Microns/Pixel?: ');
    %background calculation selection
    disp('5) Percent from the corners to analyze background intensity?(0 for contorl Image)');
    ibkp=input('Recommended=5-20: ');
    disp('6) STDev multiplier to remove signal to determine background intensity');
    ibkstd=input('Recommended=1: ');
    disp('7) STDev from background to determine threshold');
    istdt=input('Recommended=1: ');
    
    %save new parameters
    if iat~=1; Parameters=cat(1,iat,iERw,iERh,iBins,iNumBin,iScalemp,ibkp,ibkstd,istdt);
    else Parameters=cat(1,iat,iER,iBins,iNumBin,iScalemp,ibkp,ibkstd,istdt); end
    %create parameters file
    inow=datestr(now, 'yyyymmmmddHHMMSS');
    cd(stop);
    iindex=strcat(isetname, inow, 'AIndex');
    %%%save Parameters
    xlswrite(iindex,Parameters);
    
    go=1;
    while go==1 || go==2
        selection_probe;
    end
    
    %Load File
elseif choice==2
    [filenamep,stop]=uigetfile('*AIndex.xls','Pick an excel file');
    cd(stop);
    Parameters=xlsread([stop,filenamep]);
    %%%load Parameters*
    iat=Parameters(1);
    if iat~=1
        iERw=Parameters(2); iERh=Parameters(3); iBins=Parameters(4);
        iNumBin=Parameters(5); iScalemp=Parameters(6); ibkp=Parameters(7);
        ibkstd=Parameters(8); istdt=Parameters(9);
    else
        iER=Parameters(2); iBins=Parameters(3); iNumBin=Parameters(4);
        iScalemp=Parameters(5); ibkp=Parameters(6);
        ibkstd=Parameters(7); istdt=Parameters(8);
        
    end
    
    go=1;
    while go==1 || go==2
        selection_probe;
    end
    
    %Plot Files
else
    %plot analyzed data by channel
    probe_plot;
end

