function [rat_locations, frames, video_file]=location_movie(video_file, movieStruct, refFrame, startFrame, endFrame, skipFrames, searchWindow, viewMov, movName, filtersize, roi_mask, pos_x, pos_y, bbsearch, rat_locations)
% [rat_locations, frames]=location_movie(movieStruct, refFrame, startFrame, endFrame, skipFrames, searchWindow, viewMov, {movName})
%
%Inputs:
%movieStruct (created with VideoReader (see help VideoReader if you are not sure))
%refFrame (grayscale image of scene without object of interest)
%Algorithm analyzes frames [startFrame:skipFrames:endFrame]
%searchWindow: max number of pixels you expect object to move between skipFrames frames. 
%viewMov: set to 1 to watch movie during analysis, 0 otherwise. Looks cool, though significantly slows down analysis.
%movName (optional): string of name to save movie with location estimate overlayed as .avi file. 
%
%Outputs:
%rat_locations: numFrames x 2 matrix each row gives location of object in corresponding frame
%frames: array of frame numbers from movie analyzed.

close all

movieStruct = VideoReader(video_file); %Read movie into MATLAB.
num_frames = movieStruct.NumberOfFrames %Number of frames in movie.
datFrame=read(movieStruct, startFrame);
datFrame=rgb2gray(datFrame);
dimensions = size(datFrame);

%If statement determining whether user desires a saved film.
if movName == 0
    saveMov = 0;
else 
    saveMov = 1;
end

%If you want to save the movie
if saveMov==1
    movieOut=VideoWriter([pwd '/Saved Videos/' movName], 'MPEG-4');
    % %following if you want display in real time
    originalRate=movieStruct.FrameRate;
    originalPeriod=1/originalRate;
    newPeriod=originalPeriod*skipFrames; %may change depending on how you skip frames
    newRate=1/newPeriod;
    movieOut.FrameRate=newRate;
    open(movieOut);
    writeVideo(movieOut, mat2gray(datFrame));
    %writeVideo(movieOut, currframe);
end
hold off;

%calculate frames to do
frames=startFrame+skipFrames:skipFrames:endFrame;
numFrames=length(frames);
framesDone=1;

%Predefine previous frame for occlusion;
location_trunc_prev = 0;
bbox_trunc_prev = 0;

%% Loop that calls truncated analysis script for all remaining frames of interest.
for index=frames
    if mod(framesDone,20)==0
        display(['Analyzing frame ' num2str(find(index==frames)) ' out of ' num2str(numFrames)]);
    end
    datFrame=read(movieStruct,index);
    datFrame=rgb2gray(datFrame); 
    region = datFrame(:,:,1).*roi_mask(:,:,1);
    
    %get location within search box
    [location_trunc, bbox_trunc]=location_frame_trunc(datFrame, refFrame, bbsearch, 0, roi_mask, location_trunc_prev, bbox_trunc_prev, filtersize);
    %Save as previous version for occlusion case (used as inputs in next
    %loop iteration)
    location_trunc_prev = location_trunc;
    bbox_trunc_prev = bbox_trunc;
    %translate location and truncated bounding box back into bb for full image.
    bbox=[bbsearch(1)+bbox_trunc(1) bbsearch(2)+bbox_trunc(2) bbox_trunc(3) bbox_trunc(4)];
    rat_locations(end+1,:)=[bbsearch(1)+location_trunc(1) bbsearch(2)+location_trunc(2)];   
    %get new bounding box
    bbsearch=new_bbox(bbox, dimensions, searchWindow);
    framesDone=framesDone+1;
    if saveMov || viewMov
        datFrame=read(movieStruct,index);
        datFrame=rgb2gray(datFrame); 
        ratcm=round(rat_locations(end,:));
        datFrame(ratcm(2)-5:ratcm(2)+5, ratcm(1)-5:ratcm(1)+5)=255;
        datFrame(ratcm(2)-3:ratcm(2)+3, ratcm(1)-3:ratcm(1)+3)=0;
        %The code immediately below plots the ROI on the saved video. 
        %To change the shade of the outline adjust the equality in the
        %if statement to an integer between 0 and 255.  X and Y position
        %is switched due to the rotation of the image when it is displayed.
        posy = round(pos_x(:,:));
        posx = round(pos_y(:,:));
        for zindex = 1:length(posx);
            datFrame(posx(zindex):posx(zindex)+2, posy(zindex):posy(zindex)+2) = 255;
        end
    end
    if viewMov
        figure(1)
        hold on
        imagesc(datFrame); colormap gray; set(gca,'YDir','normal');
        dimensions = size(datFrame);
        plot(pos_x, pos_y, 'r.');
        axis([0 dimensions(2) 0 dimensions(1)]);
        title(['Frame ' num2str(find(index==frames)) ' out of ' num2str(numFrames)]);
        pause(.002); %so renderer can keep up otherwise it skips many frames
        hold off
    end
    if saveMov
        writeVideo(movieOut, datFrame);
    end
end

if saveMov==1
   close(movieOut); 
end

frames=[startFrame frames];

end %main function definition

