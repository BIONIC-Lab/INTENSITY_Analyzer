%%%Multi-shank Analysis: Creates rectangular mask in X or Y direction as
%%%selected by user.
if part==1
    if chan_loop==1
        bindir=menu('Choose analysis orientation','UP-direction','DOWN-direction','LEFT-direction','RIGHT-direction');
    end
    
    %%% setup graph
    %rectangular parameters
    redge=(imsize(2)-x-round(d1w/2));
    cc=d1w;
    ledge=(imsize(2)-redge-d1w);
    bedge=(imsize(1)-y-round(d1h/2));
    cr=d1h;
    tedge=(imsize(1)-bedge-d1h);
    %%%mask prep
    if bindir==1
        xarray1=(ledge+1)-repmat(1:ledge,ym,1);
        xarray1=zeros(size(xarray1));
        xarray2=repmat(0:0,ym,d1w);
        xarray2b=repmat(1:1,ym,d1w);
        xarray3=repmat(1:redge,ym,1);
        xarray3=zeros(size(xarray3));
        yarray1=(tedge+1)-repmat((1:tedge)',1,xm);
        yarray2=repmat((0:0)',d1h,xm);
        yarray3=repmat((1:bedge)',1,xm);
        yarray3=zeros(size(yarray3));
        xarray=cat(2,xarray1,xarray2,xarray3);
        xarrayt=cat(2,xarray1,xarray2b,xarray3);
        yarrayt=cat(1,yarray1,yarray2,yarray3);
        yarray=yarrayt.*xarrayt;
        dist=(xarray).^2+(yarray).^2;
    elseif bindir==2
        xarray1=(ledge+1)-repmat(1:ledge,ym,1);
        xarray1=zeros(size(xarray1));
        xarray2=repmat(0:0,ym,d1w);
        xarray2b=repmat(1:1,ym,d1w);
        xarray3=repmat(1:redge,ym,1);
        xarray3=zeros(size(xarray3));
        yarray1=(tedge+1)-repmat((1:tedge)',1,xm);
        yarray1=zeros(size(yarray1));
        yarray2=repmat((0:0)',d1h,xm);
        yarray3=repmat((1:bedge)',1,xm);
        xarray=cat(2,xarray1,xarray2,xarray3);
        xarrayt=cat(2,xarray1,xarray2b,xarray3);
        yarrayt=cat(1,yarray1,yarray2,yarray3);
        yarray=yarrayt.*xarrayt;
        dist=(xarray).^2+(yarray).^2;
    elseif bindir==3
        yarray1=(tedge+1)-repmat((1:tedge)',1,xm);
        yarray1=zeros(size(yarray1));
        yarray2=repmat((0:0)',d1h,xm);
        yarray2b=repmat(1:1,d1h,xm);
        yarray3=repmat((1:bedge)',1,xm);
        yarray3=zeros(size(yarray3));
        xarray1=(ledge+1)-repmat((1:ledge),ym,1);
        xarray2=repmat((0:0),ym,d1w);
        xarray3=repmat((1:redge),ym,1);
        xarray3=zeros(size(xarray3));
        yarray=cat(1,yarray1,yarray2,yarray3);
        yarrayt=cat(1,yarray1,yarray2b,yarray3);
        xarrayt=cat(2,xarray1,xarray2,xarray3);
        xarray=xarrayt.*yarrayt;
        dist=(xarray).^2+(yarray).^2;
    else 
        yarray1=(tedge+1)-repmat((1:tedge)',1,xm);
        yarray1=zeros(size(yarray1));
        yarray2=repmat((0:0)',d1h,xm);
        yarray2b=repmat(1:1,d1h,xm);
        yarray3=repmat((1:bedge)',1,xm);
        yarray3=zeros(size(yarray3));
        xarray1=(ledge+1)-repmat((1:ledge),ym,1);
        xarray1=zeros(size(xarray1));
        xarray2=repmat((0:0),ym,d1w);
        xarray3=repmat((1:redge),ym,1);
        yarray=cat(1,yarray1,yarray2,yarray3);
        yarrayt=cat(1,yarray1,yarray2b,yarray3);
        xarrayt=cat(2,xarray1,xarray2,xarray3);
        xarray=xarrayt.*yarrayt;
        dist=(xarray).^2+(yarray).^2;
    end
    
    plot([x-d1w/2 x-d1w/2],[y-d1h/2 y+d1h/2],'r');
    plot([x+d1w/2 x+d1w/2],[y-d1h/2 y+d1h/2],'r');
    plot([x-d1w/2 x+d1w/2],[y+d1h/2 y+d1h/2],'r');
    plot([x-d1w/2 x+d1w/2],[y-d1h/2 y-d1h/2],'r');
    
else
    %%%%
    x1=[x-d1 x+d1];
    x2=[x-d2 x+d2];
    y1=[y-d1 y+d1];
    y2=[y-d2 y+d2];
    
    figure(A);
    if bindir==1
        %%for y-dimension analysis
        %horizontal component of bin
        %plot([x-d1w/2 x+d1w/2],[y1(1)-d1h/2 y1(1)-d1h/2],'r'); hold on;
        plot([x-d1w/2 x+d1w/2],[y1(2)+d1h/2 y1(2)+d1h/2],'r');
        %plot([x-d1w/2 x+d1w/2],[y2(1)-d1h/2 y2(1)-d1h/2],'r');
        plot([x-d1w/2 x+d1w/2],[y2(2)+d1h/2 y2(2)+d1h/2],'r');
        %vertical component of bin
        plot([x-d1w/2 x-d1w/2],[y+d1+d1h/2 y+d2+d1h/2],'r');
        %plot([x-d1w/2 x-d1w/2],[y-d1-d1h/2 y-d2-d1h/2],'r');
        %plot([x+d1w/2 x+d1w/2],[y-d1-d1h/2 y-d2-d1h/2],'r');
        plot([x+d1w/2 x+d1w/2],[y+d1+d1h/2 y+d2+d1h/2],'r');
    elseif bindir==2
        plot([x-d1w/2 x+d1w/2],[y1(1)-d1h/2 y1(1)-d1h/2],'r'); hold on;
        %plot([x-d1w/2 x+d1w/2],[y1(2)+d1h/2 y1(2)+d1h/2],'r');
        plot([x-d1w/2 x+d1w/2],[y2(1)-d1h/2 y2(1)-d1h/2],'r');
        %plot([x-d1w/2 x+d1w/2],[y2(2)+d1h/2 y2(2)+d1h/2],'r');
        %vertical component of bin
        %plot([x-d1w/2 x-d1w/2],[y+d1+d1h/2 y+d2+d1h/2],'r');
        plot([x-d1w/2 x-d1w/2],[y-d1-d1h/2 y-d2-d1h/2],'r');
        plot([x+d1w/2 x+d1w/2],[y-d1-d1h/2 y-d2-d1h/2],'r');
        %plot([x+d1w/2 x+d1w/2],[y+d1+d1h/2 y+d2+d1h/2],'r');
    elseif bindir==3
        %%for x-dimension analysis
        %vertical component of bin
        plot([x1(1)-d1w/2 x1(1)-d1w/2],[y-d1h/2 y+d1h/2],'r'); hold on;
        %plot([x1(2)+d1w/2 x1(2)+d1w/2],[y-d1h/2 y+d1h/2],'r');
        plot([x2(1)-d1w/2 x2(1)-d1w/2],[y-d1h/2 y+d1h/2],'r');
        %plot([x2(2)+d1w/2 x2(2)+d1w/2],[y-d1h/2 y+d1h/2],'r');
        %horizontal component of bin
        %plot([x+d1+d1w/2 x+d2+d1w/2],[y-d1h/2 y-d1h/2],'r');
        plot([x-d1-d1w/2 x-d2-d1w/2],[y-d1h/2 y-d1h/2],'r');
        %plot([x+d1+d1w/2 x+d2+d1w/2],[y+d1h/2 y+d1h/2],'r');
        plot([x-d1-d1w/2 x-d2-d1w/2],[y+d1h/2 y+d1h/2],'r');
        %%%
    else
        %plot([x1(1)-d1w/2 x1(1)-d1w/2],[y-d1h/2 y+d1h/2],'r'); hold on;
        plot([x1(2)+d1w/2 x1(2)+d1w/2],[y-d1h/2 y+d1h/2],'r');
        %plot([x2(1)-d1w/2 x2(1)-d1w/2],[y-d1h/2 y+d1h/2],'r');
        plot([x2(2)+d1w/2 x2(2)+d1w/2],[y-d1h/2 y+d1h/2],'r');
        %horizontal component of bin
        plot([x+d1+d1w/2 x+d2+d1w/2],[y-d1h/2 y-d1h/2],'r');
        %plot([x-d1-d1w/2 x-d2-d1w/2],[y-d1h/2 y-d1h/2],'r');
        plot([x+d1+d1w/2 x+d2+d1w/2],[y+d1h/2 y+d1h/2],'r');
        %plot([x-d1-d1w/2 x-d2-d1w/2],[y+d1h/2 y+d1h/2],'r');
        %%%
        
    end
    
end