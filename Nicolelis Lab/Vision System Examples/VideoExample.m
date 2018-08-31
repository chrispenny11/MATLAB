% This example demonstrates how to load and play a video using the system
% object functionality of MATLAB

clear

%Load video
videoFReader = vision.VideoFileReader('n8_08_01_15_RGB.mp4');

%Create video player object
videoPlayer = vision.DeployableVideoPlayer;

while ~isDone(videoFReader)
           videoFrame = step(videoFReader);
           step(videoPlayer, videoFrame);
end

%Release objects
release(videoPlayer);
release(videoFReader);