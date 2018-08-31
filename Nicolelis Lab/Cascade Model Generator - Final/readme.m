%% Cascade Model Generator Readme (Second Version)
% Chris Penny
% 5/6/16

%% FILEPATH NOTE: In order to use the positive image data set...
% One needs to replicate the original filepath.  The labeled image output
% is simply the image location (with full filepath) and the coordinates of
% the region of interest.  One could likely write a script to overwrite the
% filepath as a partial filepath; however, in the meantime, it is necessary
% to replicate the following path and place this folder in it:

% /Users/ChrisPenny/Documents/MATLAB/Nicolelis Analysis/Cascade Model Generator V2 2

%% Table of Contents
% -How to use the trainingImageLabeler
%   *trainingImageLabeler
%   *trainCascadeObjectDetector
% -Code Description
%   *screengrab.m
%   *negative_image_generator.m
%   *generate_roi.m
%   *Cascade Object Detector

%% *How to use trainingImageLabeler
% Open by entering trainingImageLabeler into the command prompt. 
%
% The trainingImageLabeler is MATLAB's built in GUI for training a Cascade
% Object Detector.  Its main function is to allow a user to manually label
% images with an ROI to designate an object as a positive sample for the
% detector.  Sessions are saved as .mat files - it is very important to
% save each session as failure to do so will result in the loss of all
% labeling.  Once the .mat file has been saved, the user can edit it at any
% point.  Notably, the .mat file is not the detector - rather, it is used
% to train the detector.  Before one runs the code to train the detector,
% they must open the .mat file in the trainingImageLabeler and click the
% Export ROIs button.  THe user is then prompted to enter a variable name -
% to use the already written code, use the name 'positiveInstances'.  This
% variable serves as the input to the trainCascadeObjectDetector function.
% Negative samples are to be included in a separate folder, the name of 
% which is also an input to the trainCascadeObjectDetector function. MATLAB
% automatically selects objects out of the negative samples, so one should
% not use the trainingImageLabeler on negative samples.  

%% trainCascadeObjectDetector function
% As noted, the positive samples labeled using the trainingImageLabeler, as
% well as the negative images folder are used to generate an .xml file
% containing the detector itself.  The basic function inputs are as follows:

% trainCascadeObjectDetector([output xml filename].xml, positive sample ROI
% export variable, negative sample folder name)

% The .xml file output can then be used with the
% vision.CascadeObjectDetector command to create a detection system object.

%% *Code Description* %%
% This folder contains all of the scripts used to generate images and train
% the Cascade Filter object in the MATLAB Computer Vision System.  All of
% the scripts and folders are described below.

%% screengrab.m
% This script takes a series of video inputs stored in the folder Zero Maze
% Videos and generates a series of screenshots for labeling in the
% trainingImageLabeler MATLAB GUI.  Screens are sampled at an interval
% selected by the user and saved in the Positive Image Bank Folder.  Once
% the screengrab.m script has been run, the user must import these images
% into the trainingImageLabeler, wherein the user should set the ROI around
% the relevant object on each frame.  Once a .mat file has been produced
% using the trainer, one can run the negative_image_generator.m script.

%% negative_image_generator.m
% This script creates negative image samples by removing the user set ROI
% of each positive sample.  This creates an image that may be fed as a
% negative to the detector trainer.  Negative images are saved in the
% Negative_Folder directory.  NOTE: The user must have manually labeled the
% relevant ROIs and have saved them in a .mat file before running this 
% script.  The appropriate .mat file must be entered by the user.  The user
% should include any extra negative samples in the Negative_Folder as well
% before running the detection scripts.

%% generate_roi.m
% Functionally, this script is nearly identical to the one found in
% EasyTrack.  It allows the user to set an ROI mask that will be applied to
% the video being analyzed.  It is essential to note that this ROI is
% entirely separate for the ROI selection used to train the detector - it
% is only being applied to the data video before detection occurs.

%% Cascade Object Detection Scripts
% A script has been written for each of the three feature sets available in
% the trainCascadeObjectDetector function in MATLAB: HOG, LBP, and Haar.
% Each of these feature sets uses different methods to train the detector.
%
% - Histogram of Oriented Gradients (HOG) 
% - Local Binary Patterns (LBP)
% - Haar Wavelets
% 
% With the exception of the relevant feature set, all of these scripts
% (labeled as hog_CascadeObjectDetector.m, for example) are identical.  The
% contain the necessary code to train the detector, which returns an .xml
% file containing the detector itself.  This detector is then fed into a
% series of instructions that sequentially applies the detector to frames
% of the object-containing video.  Prior to object detection, the user
% generated ROI mask is applied to the image.





