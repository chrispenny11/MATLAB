% Create system object to read file
videoSource = vision.VideoFileReader('n8_08_01_15_RGB.mp4','ImageColorSpace','Intensity','VideoOutputDataType','uint8');
% videoSource = vision.VideoFileReader('viptraffic.avi','ImageColorSpace','Intensity','VideoOutputDataType','uint8');

% Create detection object
detector = vision.ForegroundDetector(...
       'NumTrainingFrames', 5, ...
       'InitialVariance', 30*30);
   
%Blob analysis
blob = vision.BlobAnalysis(...
       'CentroidOutputPort', false, 'AreaOutputPort', false, ...
       'BoundingBoxOutputPort', true, ...
       'MinimumBlobAreaSource', 'Property', 'MinimumBlobArea', 250);
   
%Outline Shape
shapeInserter = vision.ShapeInserter('BorderColor','White');

%Play Result
videoPlayer = vision.VideoPlayer();
while ~isDone(videoSource)
     frame  = step(videoSource);
     fgMask = step(detector, frame);
     bbox   = step(blob, fgMask);
     out    = step(shapeInserter, frame, bbox);
     step(videoPlayer, out);
end