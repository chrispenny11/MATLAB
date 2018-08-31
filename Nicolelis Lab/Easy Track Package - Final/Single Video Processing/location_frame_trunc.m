function [location_trunc, bbox_trunc, diff_image]=location_frame_trunc(datFrame, refFrame, bbsearch, plot_on, roi_mask, location_trunc_prev, bbox_trunc_prev, filtersize)
%[location_trunc, bbox_trunc]=location_frame_trunc(datFrame, refFrame, bbsearch, plot_on)
%Works with data truncated using box in bbsearch.
%Search is limited to a localized area around the last known position.

%% Subtract Background Image
diff_image=refFrame-datFrame;

%% Apply Image Filter to Subtracted Image
% Median Filter
if filtersize~=0
    diff_image = medfilt2(diff_image, [filtersize,filtersize]);
end

%% Truncates and applies ROI Mask to current frame and creates b/w image.
diff_image = diff_image.*roi_mask(:,:,1);
diff_image=diff_image(bbsearch(2):bbsearch(2)+bbsearch(4), bbsearch(1):bbsearch(1)+bbsearch(3));
%threshold and remove excess
level = graythresh(diff_image)+.05; %finds threshold to minimize intraclass variance
if level>1
    level=1;
end
threshed_diff = im2bw(diff_image,level);

%% Tracking Analysis
%get centroid of largest blob in truncated world
blobs=regionprops(threshed_diff);
area_vector=[blobs.Area];

counter = 0; %Will break out of isempty loop at certain point. Failure 
%to do so would result in infinite loop(?) if rat is occluded.

while isempty(area_vector) 
    level = level-0.005;
    if level <0
        level=0;
    end
    threshed_diff = im2bw(diff_image,level);
    blobs=regionprops(threshed_diff);
    area_vector=[blobs.Area];
    counter = counter +1;
    if counter == 20;
        break;
    end;
end

if counter ~= 20;
    largest_object=find(area_vector==max(area_vector)); %find the lagest bounded bit in there
    location_trunc=blobs(largest_object).Centroid;
    bbox_trunc=blobs(largest_object).BoundingBox;
else %For full implementation, added to func input and output
    location_trunc = location_trunc_prev;
    bbox_trunc = bbox_trunc_prev;
end 
    
    
if plot_on
    imagesc(diff_image); hold on; scatter(location_trunc(1),location_trunc(2),75,'r','filled');
        set(gca,'YDir','normal');
end
