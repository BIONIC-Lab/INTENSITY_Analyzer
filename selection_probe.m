%%%Selection panel for probe analysis

if go==2
    isetname=input('What is the name of this dataset?: ', 's');
    iat=menu('What Type of Electrode Analysis Today?','Radial Probe','Planar Probe','Planar(Multishank)','Planar Probe(Single side)','Planar(Single side Multishank');
    %electrode parameters for new analysis
    if iat~=1
        iERw=input('1) Width of Electrode in microns?: ');
        iERh=input('   Height of Electrode in microns?: ');
    else
        iER=input('1) Radius of Electrode in microns?: ');
    end
    %bin parameters for new analysis
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
    if iat~=1
        Parameters=cat(1,iat,iERw,iERh,iBins,iNumBin,iScalemp,ibkp,ibkstd,istdt);
    else
        Parameters=cat(1,iat,iER,iBins,iNumBin,iScalemp,ibkp,ibkstd,istdt);
    end
    %create parameters file
    inow=datestr(now, 'yyyymmmmddHHMMSS');
    % inow2=strcat(isetname, inow);
    cd(stop);
    % mkdir(inow2); cd(inow2);
    iindex=strcat(isetname, inow, 'AIndex');
    %%%save Parameters
    xlswrite(iindex,Parameters);
end

if go~=3
    %%%%%CALL MAIN INTENSITY ANALYSIS FUNCTION%%%%
    analysis_central;
    %%%%%
end

go=menu('Continue analysis?','Yes- with same metrics','Yes- choose other analysis','No');

if go==3
    goon=menu('Plot results?','Yes','No');
    if goon==1
        probe_plot;
    else
        %break;
    end
    
end
