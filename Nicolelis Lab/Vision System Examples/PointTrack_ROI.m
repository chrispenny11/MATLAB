%% Track a Face
%% Create System objects for reading and displaying video and for drawing a bounding box of the object. 

% Copyright 2015 The MathWorks, Inc.
clear

videoFileReader = vision.VideoFileReader('n8_08_01_15_RGB.mp4', 'VideoOutputDataType', 'uint8');
videoPlayer = vision.VideoPlayer('Position', [100, 100, 680, 520]);
objectFrame = step(videoFileReader);

%% Generate ROI
[roi_mask, pos_x, pos_y] = generate_roi(objectFrame);
% roi_mask = im2single(roi_mask);

%% Read the first video frame, which contains the object, define the region.
objectFrame = objectFrame.*repmat(roi_mask(:,:,1),[1,1,3]);

%% As an alternative, you can use the following commands to select the object region using a mouse. The object must occupy the majority of the region. 
figure; imshow(objectFrame);
objectRegion=round(getPosition(imrect))
%% Show initial frame with a red bounding box.
objectImage = insertShape(objectFrame, 'Rectangle', objectRegion,'Color', 'red'); 
figure; imshow(objectImage); title('Red box shows object region');
%% Detect interest points in the object region.
points = detectMinEigenFeatures(rgb2gray(objectFrame), 'ROI', objectRegion);
%% Display the detected points.
pointImage = insertMarker(objectFrame, points.Location, '+', 'Color', 'white');
figure, imshow(pointImage), title('Detected interest points');
%% Create a tracker object.
tracker = vision.PointTracker('MaxBidirectionalError', 1);
%% Initialize the tracker.
initialize(tracker, points.Location, objectFrame);
%% Read, track, display points, and results in each video frame.

i=1;
while ~isDone(videoFileReader)
      frame = step(videoFileReader);
      frame = uint8(frame);
%       for i = 1:3
%       roi_com(:,:, i) = roi_mask(:,:,1);
%       end
      frame = frame.*repmat(roi_mask(:,:,1),[1,1,3]);
%       frame = im2single(frame);
      [points, validity] = step(tracker, frame);
      out = insertMarker(frame, points(validity, :), '+');
      step(videoPlayer, out);
      Point_Vals{i} = points(validity, :) ;
      i=i+1;
end

%% Release the video reader and player.
release(videoPlayer);
release(videoFileReader);