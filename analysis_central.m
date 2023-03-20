%%%%Analysis Central
%%%%This function loads in image and controls, finds threshold from control
%%%%background. Specific analysis methods are called below.

% Start this script by running Intensity_Main.m
% Release version 1.1 -TK Kozai 2015
%  -Prevented INTENSITY from adding tissue area in the probe footprint into the first bin. 
%  
% Features Added by TK Kozai, 2012
%  -RoI steps/bins
%  -background intensity and displays values/plot
%  -auto detects image size
%  -auto detects image type
%  -auto plots graph and prints bins and intensities
%  -added scale feature
%  -masks for rectangular probes
% written by Fong Ming Hooi, 2009
% calculate intensty of ROI
% - average intensity
% - max intensity

%%%% **** INPUT PARAMETERS HERE *******

%bin steps
binr=iBins;
%microns/pixel
scalemp=iScalemp;
%number of bins to measure
bin=iNumBin;
%standard deviation for cut-off threshold and background noise level
stdthresh=istdt;
bkstdthresh=ibkstd;
bpp=ibkp; %pix # of microns from each corner to calculate background intensity

%   CODE STARTS HERE
%   CODE STARTS HERE
%   CODE STARTS HERE
%   CODE STARTS HERE
%   CODE STARTS HERE
%   CODE STARTS HERE
%   CODE STARTS HERE
%   CODE STARTS HERE
%   CODE STARTS HERE
%   CODE STARTS HERE
%   CODE STARTS HERE
%   CODE STARTS HERE
%   CODE STARTS HERE
%   CODE STARTS HERE
%   CODE STARTS HERE
%   CODE STARTS HERE
%   CODE STARTS HERE

imagedir=uigetdir('C:\','Pick an image folder for analysis');
cd(imagedir); images=dir('*.tif');
chan=size(images,1);
cut=find(imagedir=='\',1,'last')+1;
L=length(imagedir);

if bpp==0
    ctrldir=uigetdir(imagedir, ['Pick control folder for ',imagedir(cut:L)]);
    cd(ctrldir); ctrls=dir('*.tif');
    %check controls
    while size(ctrls,1)~=chan
        disp('Error! Number of control channels does not match number of images for analysis!');
        ctrldir=uigetdir(imagedir, ['Pick control folder for ',imagedir(cut:L)]);
        cd(ctrldir); ctrls=dir('*.tif');
    end
end

A_fig_index=[]; aa_fig_index=[];
for chan_loop=1:chan
    %load in images by channel
    filenamei=images(chan_loop).name;
    a=imread([imagedir,'\',filenamei]);
    imsize=size(a);
    
    if bpp==0
        filenamec=ctrls(chan_loop).name;
        ctrlimg=imread([ctrldir,'\',filenamec]);
    end
    
    bpx=round(imsize(2)*bpp/100);
    bpy=round(imsize(1)*bpp/100);
    
    %electrode dimensions
    if iat~=1
        elw=iERw;
        elh=iERh;
        d1w=double(round(elw/scalemp));  %start # pixels from RoI
        d1h=double(round(elh/scalemp));
        d1temp=min(min([d1w d1h]));
        %bin parameters
        d1=double(0/scalemp);
        d2=double((0+binr)/scalemp); %bin size in pixels
    else
        elr=iER;
        d1=double(0/scalemp);  %start # pixels from RoI
        d2=double((0+binr)/scalemp); %bin size in pixels
    end
    %step size in pixels
    radius=double(binr/scalemp);
    dist=d2*bin;
    
    A=figure; A_fig_index=[A_fig_index,A];
    imagesc(imadjust(a)), colormap(gray); axis square; axis tight; hold on;
    %colormap(gray);
    title('Pick center of ROI','FontWeight','bold');
    
    %%%gray scale
    imtt=mean(mean(a(:,:,1)));
    si=size(imsize);
    
    if si(2)>2
        if imsize(3)>1
            for imtn=2:imsize(3)
                imt=mean(mean(a(:,:,imtn)));
                imtt=cat(1,imtt,imt);
            end
        end
        
        imtmax=max(imtt);
        
        for imtn=1:imsize(3)
            if imtt(imtn)==imtmax
                im=a(:,:,imtn);
                im2=a(:,:,imtn);
                if bpp==0
                    im2=ctrlimg(:,:,imtn);
                end
            end
        end
    else
        im=a(:,:,1);
        im2=a(:,:,1);
        if bpp==0
            im2=ctrlimg(:,:,1);
        end
    end
    
    %size of relavent image slice
    [ym,xm]=size(im2);
    %im2=a(:,:,2); %when looking at RGB img
    %im3=a(:,:,3); %when looking at RGB img
    
    %control analysis
    if bpp==0
        bpx=round(xm/2);
        bpy=round(ym/2);
    end
    xbp=xm-bpx+1;
    ybp=ym-bpy+1;
    
    %%%background (picks corners)
    bk1=im2(1:bpy,1:bpx);
    bk2=im2(1:bpy,xbp:xm);
    bk3=im2(ybp:ym,1:bpx);
    bk4=im2(ybp:ym,xbp:xm);
    bk_all=cat(1,bk1,bk2,bk3,bk4);
    avgbk=mean(bk_all(:));
    stdbk=std(double(bk_all(:)));
    bksa=sort(bk_all(:));
    
    %%%threshhold
    %%%thresh=avgbk-stdbk;
    %remove signal from background
    avgbkn=avgbk+bkstdthresh*stdbk;
    bkns=bksa(bksa<avgbkn);
    avgbk=mean(bkns(:));
    stdbk=std(double(bkns(:)));
    %
    bkns1=bkns(bkns<avgbk);
    bknssum=0;
    for bknscounter=1:numel(bkns1)
        bknssub=(avgbk-bkns1(bknscounter))^2;
        bknssum=double(bknssum)+double(bknssub);
    end
    stdbk=sqrt((1/numel(bkns1))*bknssum);
    %
    thresh=avgbk-stdthresh*stdbk;
    if thresh<min(bksa)
        thresh=min(bksa)+1;
    end
    
    %calculate number of pixels below threshold
    subthresh=sort(im(:));
    subthresh=subthresh(subthresh<thresh);
    stn=size(subthresh);
    stn=stn(1);
    stn0=stn;
    stn=stn/xm/ym*100;
    
    %%%background display
    disp(['background=',num2str(avgbk),', bSTD=',num2str(stdbk),', threshold=',num2str(thresh),', %filter=',num2str(stn)]);
    store0=[ avgbk, stdbk, thresh, stn, stn0, 0, 0];
    
    %threshold image
    b=double(im)/double(max(max(max(im))));
    
    if chan_loop==1
        [x,y]=ginput(1); %pick center
        y=round(y);
        x=round(x);
    end
    
    figure(A); %set up fig for the bin
    plot(x,y,'x','Color','r');
    
    nbin=bin;
    
    part=1;
    if iat==1
        radial; pre='R_';
    elseif iat==2
        planar; pre='P_';
    elseif iat==3
        multi; pre='M_';
    elseif iat==4
        planar_single; pre='PS_';
    else
        multi_single; pre='MS_';
    end
    
    %main interface
    flag=0;
    interface;
    
    %Begin Binning
    part=2;
    for bin=1:nbin
        d1_bin(bin)=d1*scalemp;
        d2_bin(bin)=d2*scalemp;
        
        tmpdata=im;
        %center mask
        rmask=zeros(ym,xm);
        if max(max(dist))>=d1^2
            rmask(dist>d1^2&dist<=d2^2)=1;
        end
        if max(max(dist))<d1^2
            tmpdata=0;
        end
        %apply threshold
        tmpdata(rmask==0)=0;
        tmpdata=tmpdata(:);
        tmpdata=tmpdata(tmpdata>1);
        tmpdata=sort(tmpdata);
        tmpempty=isempty(tmpdata);
        if tmpempty==1
            tmpdata=0;
        end
        avgint=mean(tmpdata);
        sumint=sum(tmpdata);
        stdint=std(double(tmpdata(:)));
        maxint=double(max(max(max(tmpdata))));
        d1m=double(d1*scalemp);
        d2m=double(d2*scalemp);
        avgr=((d2m-d1m)/2+binr*bin-binr);
        normint=avgint/avgbk;
        nstdint=stdint/avgbk;
        disp(['R=',num2str(d1m),' to ',num2str(d2m),', NormInt=',num2str(normint),', NormSTD=',num2str(nstdint),', avg=',num2str(avgint),', max=',num2str(maxint),', std=',num2str(stdint)]);
        
        %%%Bin intensity
        bin_intsum(bin)=sumint;
        bin_intraw(bin)=avgint;
        bin_int(bin)=normint;
        
        %%%Bin area
        pixel_num=numel(tmpdata);
        bin_area(bin)=pixel_num*(scalemp^2);
        tot_bin_area(bin)=(sum(sum(rmask)))*(scalemp^2);
        
        figure(A);
        if iat==1
            radial;
        elseif iat==2
            planar;
        elseif iat==3
            multi;
        elseif iat==4
            planar_single;
        else
            multi_single;
        end
        
        %%%%
        flag=1;
        interface;
        
        %setup next bin
        d1=d1+radius;
        d2=d2+radius;
        
    end
    
    imtest1=double(im);
    maximtest=max(max(imtest1));
    maxdist=max(max(sqrt(dist)));
    distscalar=maxdist/maximtest;
    imdist=sqrt(dist)/distscalar;
    imdist=round(imdist);
    %mask converted to distance in microns
    mask_dist=round(sqrt(dist)*scalemp);
    %apply mask to image (for visualization)
    imtest2=imtest1+imdist;
    
    %Append image figure
    figure(A); title('Binned Image');
    %main plotting interface
    flag=2;
    interface;
    %save to excel
    cd(stop);
    value_save;
    
    clear d1 d2 d1_bin d2_bin store_int bin_area;
end

%%%Save output figures for all channels
cd(stop); cut=find(imagedir=='\',1,'last')+1; L=length(imagedir);
for fig=1:chan
    saveas(A_fig_index(fig),[pre,imagedir(cut:L),'_chan',num2str(fig),'_bin.fig']);
    saveas(A_fig_index(fig),[pre,imagedir(cut:L),'_chan',num2str(fig),'_bin.png']);
    figure(A_fig_index(fig)), close;
    
    saveas(aa_fig_index(fig),[pre,imagedir(cut:L),'_chan',num2str(fig),'_main.fig']);
    saveas(aa_fig_index(fig),[pre,imagedir(cut:L),'_chan',num2str(fig),'_main.png']);
    figure(aa_fig_index(fig)), close;
    
end


%%%input square
%[y,x]=ginput(1);
%xstart=round(x)-pixels/2;
%xend=round(x)+pixels/2;
%ystart=round(y)-pixels/2;
%yend=round(y)+pixels/2;

%roi=im(xstart:xend,ystart:yend);
%roi2=im2(xstart:xend,ystart:yend); %when looking at RGB img
%roi3=im3(xstart:xend,ystart:yend); %when looking at RGB img
%roi_all=cat(3,roi,roi2,roi3); %when looking at RGB img

%t1=roi>(max(max(roi))/10); %?
%t2=roi2>(max(max(roi2))/10); %?
%t3=roi3>(max(max(roi3))/10); %?

%avgint=sum(sum(sum(roi_all)))/(pixels+1)^2;
%maxint=max(max(max(roi_all)));
%subplot(1,2,2), imagesc(roi_all), axis square
%title(['avg=',num2str(avgint),', max=',num2str(maxint)])
%

%n=size(tmpdata);
%avgint=sum(sum(sum(tmpdata)))/n(1);
%maxint=max(max(max(tmpdata)));
%subplot(1,2,2), imagesc(tmpdata), axis square
%title(['avg=',num2str(avgint),', max=',num2str(maxint),', background=',num2str(avgbk),', bSTD=',num2str(stdbk)])
%%mean_abovethreshold=



