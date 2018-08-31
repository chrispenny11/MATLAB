function [bbox, bbsearch, rat_locations] = verify_location(video_file, blankFrame, searchWindow, plot_on, roi_mask, startFrame)
%verify_location.m
%Allows the user to manually verify the initial position of the object.

%% Load in Data Movie
movieStruct = VideoReader(video_file); %Read movie into MATLAB.
firstFrame=read(movieStruct, startFrame);
firstFrame=rgb2gray(firstFrame);

%% Subtracting Background
dimensions=size(blankFrame); %x and y
%subtract from blank
diff_image=blankFrame-firstFrame;
%threshold and remove excess

%% Apply ROI Mask
diff_image = diff_image.*roi_mask(:,:,1);

%% Tracking Analysis
%Performs object analysis on the initial frame. Subsequent frames analyzed
%using location_frame_trun.m
level = graythresh(diff_image)+.05; %finds threshold to minimize intraclass variance %decision 1
if level>1
    level=1;
end
threshed_diff = im2bw(diff_image,level); %Creates image of all black and white based on grey threshold.
%get centroid of largest blob
blobs=regionprops(threshed_diff);
area_vector=[blobs.Area];
while isempty(area_vector) %if nothing was detected, too strong of a threshold, redo
    level = level-0.01;
    threshed_diff = im2bw(diff_image,level);
    blobs=regionprops(threshed_diff);
    area_vector=[blobs.Area];
end
largest_object=find(area_vector==max(area_vector)); %find the lagest bounded bit in there
rat_locations=blobs(largest_object).Centroid;
%Get bounding box
bbox=blobs(largest_object).BoundingBox;
bbsearch=new_bbox(bbox, dimensions, searchWindow);
if plot_on
    imagesc(blankFrame); hold on; scatter(rat_locations(1),rat_locations(2),75,'r','filled');colormap('gray');
    set(gca,'YDir','normal');
    plot_bbox(bbox,'r')
    plot_bbox(bbsearch,'y')
end

imagesc(blankFrame-firstFrame);colormap('gray');set(gca,'YDir','normal');hold on;
scatter(rat_locations(1),rat_locations(2),75,'r','filled');
plot_bbox(bbox,'r')
%User gives manual input
dlgquest1=['Click in center of object (red spot is estimate)'];
title(dlgquest1,'fontweight','b');
rat_locations=ginput(1);
scatter(rat_locations(1),rat_locations(2),75, 'g','filled');
dlgquest2=['Draw rectangle around object (red rectangle is estimate). Double click when done.'];
title(dlgquest2,'fontweight','b');
rect_handle= imrect;
bbox = wait(rect_handle)
bbsearch=new_bbox(bbox, dimensions, searchWindow);
plot_bbox(bbox,'g')
rect_handle.delete;
title('');pause(.002); %pause so it doesn't skip drawing the green dot


end

