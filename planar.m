%%%Planar Shank Analysis: Model electrode as rectangle with dim Width and
%%%Height. Successive bins plotted with rounded edges from the
%%%user-specified implant site.

if part==1
    %%% setup graph
    %rectangular parameters
    redge=(imsize(2)-x-round(d1w/2));
    cc=d1w;
    ledge=(imsize(2)-redge-d1w);
    bedge=(imsize(1)-y-round(d1h/2));
    cr=d1h;
    tedge=(imsize(1)-bedge-d1h);
    %%%mask prep
    xarray1=(ledge+1)-repmat(1:ledge,ym,1);
    xarray2=repmat(0:0,ym,d1w);
    xarray3=repmat(1:redge,ym,1);
    yarray1=(tedge+1)-repmat((1:tedge)',1,xm);
    yarray2=repmat((0:0)',d1h,xm);
    yarray3=repmat((1:bedge)',1,xm);
    xarray=cat(2,xarray1,xarray2,xarray3);
    yarray=cat(1,yarray1,yarray2,yarray3);
    dist=(xarray).^2+(yarray).^2;
    
    %define origin for arcs in each quadrant
    o1=[x+d1w/2,y+d1h/2];
    o2=[x-d1w/2,y+d1h/2];
    o3=[x-d1w/2,y-d1h/2];
    o4=[x+d1w/2,y-d1h/2];
else
    %%%basis coordinates
    x1=[x-d1 x+d1];
    x2=[x-d2 x+d2];
    y1=[y-d1 y+d1];
    y2=[y-d2 y+d2];
    %%%
    
    %%%new x bins
    plot([x1(1)-d1w/2 x1(1)-d1w/2],[y-d1h/2 y+d1h/2],'r'); hold on;
    plot([x1(2)+d1w/2 x1(2)+d1w/2],[y-d1h/2 y+d1h/2],'r');
    plot([x2(1)-d1w/2 x2(1)-d1w/2],[y-d1h/2 y+d1h/2],'r');
    plot([x2(2)+d1w/2 x2(2)+d1w/2],[y-d1h/2 y+d1h/2],'r');
    
    %%%new y bins
    plot([x-d1w/2 x+d1w/2],[y1(1)-d1h/2 y1(1)-d1h/2],'r'); hold on;
    plot([x-d1w/2 x+d1w/2],[y1(2)+d1h/2 y1(2)+d1h/2],'r');
    plot([x-d1w/2 x+d1w/2],[y2(1)-d1h/2 y2(1)-d1h/2],'r');
    plot([x-d1w/2 x+d1w/2],[y2(2)+d1h/2 y2(2)+d1h/2],'r');
    
    %%%rounded corners
    %%plots arc in 4th quadrant of image space (cartesian 1st quadrant)
    x_arc1=(o1(1)-d2):0.005:(o1(1)+d2);
    tmp1=(d2)^2; tmp2=(x_arc1-o1(1)).^2; tmp3=tmp1-tmp2;
    y_arc1=sqrt(tmp3)+o1(2);
    xmin1=ceil(length(x_arc1)/2);
    clear tmp2 tmp3;
    
    %%arc 3rd quadrant (cartesian 2nd quadrant)
    x_arc2=(o2(1)-d2):0.05:(o2(1)+d2);
    tmp1=(d2)^2; tmp2=(x_arc2-o2(1)).^2; tmp3=tmp1-tmp2;
    y_arc2=sqrt(tmp3)+o2(2);
    xmin2=ceil(length(x_arc2)/2);
    clear tmp2 tmp3;
    
    %%arc 2rd quadrant (cartesian 3rd quadrant)
    x_arc3=(o3(1)-d2):0.05:(o3(1)+d2);
    tmp1=(d2)^2; tmp2=(x_arc3-o3(1)).^2; tmp3=tmp1-tmp2;
    y_arc3=sqrt(tmp3)+o3(2);
    xmin3=ceil(length(x_arc3)/2);
    y_arc3_1=2*y-y_arc3-d1h;
    clear tmp2 tmp3;
    
    %arc 1st quadrant (cartesian 4th quadrant)
    x_arc4=(o4(1)-d2):0.005:(o4(1)+d2);
    tmp1=(d2)^2; tmp2=(x_arc4-o4(1)).^2; tmp3=tmp1-tmp2;
    y_arc4=sqrt(tmp3)+o4(2);
    xmin4=ceil(length(x_arc4)/2);
    
    y_arc4_1=2*y-y_arc4-d1h;
    clear tmp2 tmp3;
    
    %check if arcs exceed image size
    if max(y_arc1>1024)
        cut=find(max(y_arc1));
        y_arc1(cut)=[];
        x_arc1(cut)=[];
        
    elseif max(y_arc2>1024)
        cut=find(max(y_arc2));
        y_arc2(cut)=[];
        x_arc2(cut)=[];
        
    elseif max(y_arc3_1>1024)
        cut=find(max(y_arc3_1));
        y_arc3_1(cut)=[];
        x_arc3_1(cut)=[];
        
    else max(y_arc4_1>1024);
        cut=find(max(y_arc4_1));
        y_arc4_1(cut)=[];
        x_arc4(cut)=[];
        
    end
    
    plot(x_arc1(xmin1:length(x_arc1)),y_arc1(xmin1:length(y_arc1)),'r');
    plot(x_arc2(1:xmin2),y_arc2(1:xmin2),'r');
    plot(x_arc3(1:xmin3),y_arc3_1(1:xmin3),'r');
    plot(x_arc4(xmin4:length(x_arc4)),y_arc4_1(xmin4:length(y_arc4_1)),'r');
    
    clear xmin1 xmin2 xmin3 xmin4 x_arc1 x_arc2 x_arc3 x_arc4 y_arc1 y_arc2 y_arc3 y_arc3_1 y_arc4 y_arc4_1
    %%%%%%
    
end