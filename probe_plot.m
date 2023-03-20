%%Probe Plot: find average intensity profile for each imaging channel.
%%Plot superimopsed on graph (Intensity vs distance)

% choose folder with data obtained from Intensity_Main
datdir=uigetdir('C:\','Choose data folder'); cd(datdir);
num=input('How many imaging channels in this folder? (hint: check Excel filename): ');
disp('Note: all files in a channel group must have same number of bins & analysis parameters using Intensity_Main)');
% colormap for plotting
mapcolor=colormap(jet(num));

bb=figure;
% cc=figure; %%to plot bin area over distance
for chan=1:num
    data=dir(['*',num2str(chan),'.xls']);
    for samechan=1:size(data,1)
        datachan=data(samechan).name;
        xlschan=xlsread(datachan,1);
        %read in cols with normalized intensity and area
        int(:,samechan)=xlschan(:,3); area(:,samechan)=xlschan(:,4);
                
        %read in cols with bin values
        bin1=xlschan(:,1); bin2=xlschan(:,2);
        %mean bin location
        binm(:,samechan)=(bin2+bin1)/2;
               
    end
    %Check for zero-value bins %eliminate from mean calculation
    for k=1:size(int,1)
        tmpInt=int(k,:);
        tmpBin=binm(k,:);
        
        zfindtmp=tmpInt(tmpInt>=0.1);
        mInt(k)=mean(zfindtmp);
        stdInt(k)=std(zfindtmp)/sqrt(numel(zfindtmp));
        
        zindextmp=find(tmpInt>=0.1);
        Bin(k)=max(tmpBin(zindextmp));
        
    end
    clear int
    
    zfindm(chan)={mInt'};
    zfinds(chan)={stdInt'};
    
    binzero(chan)={Bin'};
    
    %intensity mean and standard error per bin
    cmi=mInt'; csi=stdInt'; bins=Bin';
    cmitot(:,chan)=cmi; csitot(:,chan)=csi; binstot(:,chan)=bins;
        
    %area and standard error per bin
    cma(:,chan)=mean(area,2); if size(area,2)>1, csa(:,chan)=std(area')'/size(area,2); end
    
    %plot mean intensity per bin
    figure(bb);
    chan_line(chan)=plot(bins,cmi,'Color',mapcolor(chan,:)); hold on;
    errorbar(bins,cmi,csi,'LineStyle','none','Color',mapcolor(chan,:));
    
    %plot mean area per bin
    %     figure(cc);
    %     plot(binm(:,1),cma(:,chan),'Color',mapcolor(chan,:)); hold on
    %     if size(area,2)>1, errorbar(binm(:,1),cma(:,chan),csa(:,chan),'LineStyle','none','Color',mapcolor(chan,:)); end
    
    chan_str(chan)={['chan',num2str(chan)]};
    
    clear cmi csi;
end
% save intensity figure
figure(bb);
legend(chan_line,chan_str);
xlabel('Distance from Implant (\mum)'), ylabel('Normalized Intensity');

cut=find(datdir=='\',1,'last')+1;
name=[datdir(cut:length(datdir)),'_meanChan'];
saveas(bb,[name,'.fig']);
saveas(bb,[name,'.png']);

for chan=1:num
    var={'Distance mean (um)','Intensity mean','Intensity STD','Area mean','Area STD','Channel'};
    xlswrite(name,var,chan,'A1');
    xlswrite(name,binstot(:,chan),chan,'A2');
    xlswrite(name,cmitot(:,chan),chan,'B2');
    xlswrite(name,csitot(:,chan),chan,'C2');
    xlswrite(name,cma(:,chan),chan,'D2');
    %xlswrite(name,csa(:,chan),chan,'E2');
    xlswrite(name,chan,chan,'F2');
end


%save area figure
% figure(cc);
% legend(chan_line,chan_str);
% xlabel('Distance from Implant (\mum)'), ylabel('Mean Area (\mum^2)');
% saveas(cc,[name,'.fig']);
% saveas(cc,[name,'.fig']);



