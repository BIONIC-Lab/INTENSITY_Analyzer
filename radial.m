%%%Radial Analysis: Creates radial mask and radial bins superimposed on
%%%image
if part==1
    %%% input ring
    %maskprep
    xarray=repmat(1:xm,ym,1);
    yarray=repmat((1:ym)',1,xm);
    dist=(xarray-x).^2+(yarray-y).^2;
elseif part==2
    %%%Plots radial bins on selected images%%%%%%%%%%
    %%%Bin parameters specified in choose_analysis%%%
    
    d1_bin(bin)=d1;
    d2_bin(bin)=d2;
    
    c1_dist=(x-d1):.01:(x+d1);
    d1_dist=d1;
    d2_dist=d2;
    c2_dist=(x-d2):.01:(x+d2);
    cc1_dist=c1_dist;
    cc2_dist=c2_dist;
    c_circ1=sqrt(d1^2-(c1_dist-x).^2)+y;
    c_circ2=sqrt(d2^2-(c2_dist-x).^2)+y;
    cc_circ1=(2*y-c_circ1);
    cc_circ2=(2*y-c_circ2);
    
    if max(cc_circ1>1024)
        cut=find(max(cc_circ1));
        cc_circ1(cut)=[];
        cc1_dist(cut)=[];
        
    elseif max(cc_circ2>1024)
        cut=find(max(cc_circ1));
        cc_circ2(cut)=[];
        cc2_dist(cut)=[];
        
    elseif max(c_circ1>1024)
        cut=find(max(c_circ1));
        c_circ1(cut)=[];
        c1_dist(cut)=[];
        
    else max(c_circ2>1024);
        cut=find(max(c_circ2));
        c_circ2(cut)=[];
        c2_dist(cut)=[];
        
    end
    
    figure(A);
    %%%Plot radial Bins%%%
    plot(c1_dist,c_circ1,'r-'),plot(c2_dist,c_circ2,'r-'), hold on;
    plot(cc1_dist,cc_circ1,'r-'),plot(cc2_dist,cc_circ2,'r-'), hold on;
 
    
end