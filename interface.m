%%%interface function
%%%subplot layout%%%%

if flag==0
    aa=figure; aa_fig_index=[aa_fig_index,aa];
    subplot(2,3,5), imagesc(a), axis square; axis off; hold on;
    
    %image for background calculation with threshold applied
    b2=double(im2)/double(max(max(max(im2))));
    subplot(2,3,4),im2bw(b2,double(thresh)/double(max(max(im2)))); hold on;
    title('Control image');
    
    subplot(2,3,3), hist(double(bkns1),50),axis tight; hold on;
    title({['threshold = ',num2str(thresh)];['#subthresh pxl = ',num2str(stn0)]});
    xlabel({['background = ',num2str(avgbk)];['background STD = ',num2str(stdbk)]});
    
    %experimental image w/ threshold applied
    subplot(2,3,6), im2bw(b,double(thresh)/double(max(max(im)))); hold on;
    title(['signal threshold = ',num2str(avgbkn)]);
    xlabel(['%threshold = ',num2str(stn)]);
    colormap(hot);
    
elseif flag==1
    %normalized intensity
    figure(aa);
    subplot(2,3,1), scatter(avgr, normint, 7, 'b'); hold on;
    subplot(2,3,1), errorbar(avgr, normint, nstdint, 'r');
else
    figure(aa); subplot(2,3,1), ylabel('Normalized Intensity');
    xlabel('Distance from Probe (Micron)'); hold on;
    xlim([0 bin*binr+5]);
    
    %experimental image w/ superimposed mask
    subplot(2,3,5), imagesc(imtest2), axis equal, axis tight; hold on;
    plot(x,y,'x','Color','w'); title('Image + Mask');
    
    %mask in microns
    subplot(2,3,2), imagesc(mask_dist); axis equal, axis tight; f=colorbar; hold on;
    set(get(f,'ylabel'),'String', 'Distance (\mum)');
    plot(x,y,'Marker','x','Color','w','LineWidth',2,'MarkerSize',8);
    title('Mask');
end