%% Train A Stop Sign Detector
% This example shows you the steps involved in training a cascade object
% detector. It trains a 5-stage detector from a very small training set. In
% reality, an accurate detector requires many more stages and thousands of
% positive samples and negative images.
%% 
% Load the positive samples data from a .mat file. The file names and bounding boxes are contained in an array of structures named 'data'.

% Copyright 2015 The MathWorks, Inc.

load('stopSigns.mat');   
%%
% Add the images location to the MATLAB path.
imDir = fullfile(matlabroot,'toolbox','vision','visiondata','stopSignImages');
addpath(imDir);
%%
% Specify the folder for negative images.
negativeFolder = fullfile(matlabroot,'toolbox','vision','visiondata','nonStopSigns');   
%%
% Train a cascade object detector called 'stopSignDetector.xml' using HOG features. The following command may take several minutes to run:
trainCascadeObjectDetector('stopSignDetector.xml',data,negativeFolder,'FalseAlarmRate',0.2,'NumCascadeStages',5);   
%%
% Use the newly trained classifier to detect a stop sign in an image.
detector = vision.CascadeObjectDetector('stopSignDetector.xml');   
%%
% Read the test image.
img = imread('stopSignTest.jpg'); 
%%
% Detect a stop sign.
bbox = step(detector,img);
%%
% Insert bounding boxes and return marked image.
detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'stop sign');   
%%
% Display the detected stop sign.
figure;
imshow(detectedImg);
    
%%
% Remove the image directory from the path.
rmpath(imDir);