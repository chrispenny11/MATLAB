%% Vision System Examples
% This folder contains several examples taken from the Vision System
% Toolbox User Manual.  Some have been slightly modified to extend their
% functionality or use our data.

%% VideoExample.m
% This script creates a video play object - basically it plays a video.  It
% is a good introduction to the system object framework, which is somewhat
% remvoed from general MATLAB functionality.

%% TrainAStopSignDetectorExample.m
% This script serves as MATLABs example for the Cascade Object Detector
% functionality.  This example trains a detector to find a stop sign.  

%% TemplateMatch.m
% This script matches a target image with its location on a larger image. 
% It accomplishes this task using the TemplateMatcher system object.
% I didn't explore this one very much, but you may find it interesting.

%% PointTrack.m 
% This script identifies points of interest on a user selected ROI and
% tracks these points.  The program ultimately loses the points after
% several frames; however, I have seen scripts posted online wherein the
% region is automatically refreshed (using a Cascade Detector) to ensure
% that the program always has points to track.

%% PointTrack_ROI.m
% This example is identical to the one above with the exception that I have
% integrated the generate_roi.m script from EasyTrack to allow the user to
% select a region for overall analysis.

%% PatternMatching.m
% This script is likely the most complicated of the group.  It performs a
% correlation analysis on a target and checks video frames for a match with
% this target.  Gaussian Pyramids are used to increase the efficiency of
% the process, after which Fourier Transforms are taken and used to
% distinguish the location of the target using some sort of convolution 
% method.

%% multiObjectTracking.m
% The built in documentation is very good for this script.  It is designed
% to perform object detection on multiple objects simulatenously.  It is
% able to keep track of the identities of the objects being tracked by
% assigning detected objects to "Tracks" (objects themselves).  This script
% also provides an effective use of Kalman Filtering in cases of occlusion.
