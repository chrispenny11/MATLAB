%% Easy Track: Video Processing 
% Easy Track is a collection of MATLAB scripts and functions that can be 
% used to perform object tracking on video data. The program may be run in
% batch or single video processing variants.  Prior to using Easy Track,
% the user should work through the examples in both single and batch
% processing as outlined below.  

%% User Guide:

% MATLAB is the computational software package that Easy Track has been
% written in.  It is a language that possesses both scripts and functions.
% Easy Track is composed of these several of each, which are summarized in
% brief below.  In order to run Easy Track, the user need only run the
% run_easytrack_single or run_eastrack_batch scripts; however, it is
% important that the user adheres to the following directory structure (as
% described below).  The following is a step-by-step guide to running Easy
% Track.  The user should proceed through the following steps using
% examples before attempting to use it on their data sets.

% STEP ONE: File Structure

% First, the user must ensure that the file structure is correct and that
% all of the proper scripts and functions are present.  The file structure
% is outlined as follows:

% FILE STRUCTURE
% Easy Track Package (folder)
%
%       readme.m
%
%       Single Video Processing (folder)
%           ExampleVideo.mp4
%           generate_background.m
%           generate_roi.m
%           location_frame_trunc.m
%           location_movie.m
%           new_bbox.m
%           plot_bbox.m
%           run_easytrack_single.m
%           Saved Videos (folder)
%           verify_background.m
%           verify_location.m
%
%       Batch Video Processing (folder)
%           ExampleVideoOne.mp4
%           ExampleVideoTwo.mp4
%           generate_background.m
%           generate_roi.m
%           location_frame_trunc.m
%           location_movie.m
%           new_bbox.m
%           plot_bbox.m
%           run_easytrack_single.m
%           Saved Videos (folder)
%           verify_background.m
%           verify_location.m

% STEP TWO: Run Easy Track

% After the user verifies that the file structure is complete and correct,
% the user should then run either the MATLAB script run_easytrack_single.m
% or run_easytrack_batch.m, depending on whether the user desires single or
% batch processing.  This can be accomplished in one of two ways.  The user
% may navigate to the folder representing the desired method, double click
% the appropriate .m file, and press the green run arrow.  Alternatively,
% users may highligh and run one of the code samples below (depending on
% the desired mode).  Note that the main script has numerous input
% parameters - the examples should be run with the default parameters.  For
% inidivudal use, the name and funtion of each parameter is described in
% the Input Parameters section of this step below.  For Windows users, the
% code can be initiated after highlighting by pressing F9.  For Mac users,
% the code can be run by highlighting and pressing Shift+Fn+F7.

% Highlight + F9 to Run Single Video Processing Example Code:
% cd('Single Video Processing'); run('run_easytrack_single.m');

% Highlight + F9 to Run Batch Video Processing Example Code:
% cd('Batch Video Processing'); run('run_easytrack_batch.m');

% It is important to be aware of the following input parameters (for
% example code use the default settings).  They represent user options for
% running Easy Track - depending on the nature of the data being analyzed
% it may be necessary to adjust some of the following parameters.  Other
% parameters are simply up to user preference.  It is reccommended that
% users determine the correct settings by running Easy Track in Single mode
% before using the Batch option.

% INPUT PARAMETERS:
% - startFrame_background: starting frame for background generation
% - endFrame_background: end frame for background generation
% - startFrame: start frame for video analysis
% - endFrame: end frame for video analysis
% - searchWindow: truncated search window for frame by frame tracking based
% on set area around previous location.  NOTE: A improperly sized search
% window is one of the most common Easy Track errors.  Particular attention
% should be payed to this setting.
% - skipFrame: sets sampling interval for video analysis
% - movieShow: toggle whether or not to watch movie during analysis - not
% available in batch processing
% - filtersize: toggle/change frame filter size

% STEP THREE: Select Files for Analysis

% Once the user has begun the process of running the main Easy Track script
% (run_easytrack_single/batch.m), they will be prompted to select the video
% files that are the subject of analysis.  Accordingly, the user must
% select either "ExampleVideo" or "ExampleVideoOne" and "ExampleVideoTwo",
% depending on whether they are running the single or batch example.  The
% user will be prompted to do this with a pop-up window.  It is important
% to note that videos for analysis should be located in the file structure
% in place of the example videos for individual analysis.  

% STEP FOUR: Wait for Background Generation

% Following the selection of the proper videos for analysis, the user must
% wait for the Easy Track script to generate a background frame for the
% analysis.  This action requires no action from the user, but it will take
% some time.

% STEP FIVE: Verify Background

% After Easy Track has generated a background for use in the analysis, the
% user will be prompted with a dialogue box asking them to verify the
% generated background.  If the background appears satisfactory, the user
% should select "Yes" and proceed to Step Six.  If the background image
% appears distorted, the user may retry the generation step by increasing
% the number of frames used to generate the image.  In batch processing,
% the user may also remove the given data video from analysis - whether the
% user attempts to redo the background frame or remove the video is at the
% user's discretion.

% STEP SIX: Set Region of Interest (ROI)

% Once the user has verified the background image, the script will prompt
% the user to set a Region of Interest (ROI) for analysis.  The purpose of
% this step is to inform the program of the relevant areas of activity for
% object tracking.  Users will be asked to set the ROI by first selecting
% the desired shape (rectangle, ellipse, annulus) followed by the
% appearance of a pop-up window displaying a still frame from the data
% video.  Users are then asked to draw the ROI on the still frame, and
% double click inside the ROI to set it.  

% STEP SEVEN: Verify Initial Location

% The last step of the user verification portion of Easy Track requires the
% user to verify the initial guess of the object location.  Easy Track will
% attempt to locate the object of interest and its location in the first
% frame for analysis.  The user will then be asked to draw a rectangle
% around the object on a pop-up frame, click on its center, and finally 
% double click to close the prompt.

% STEP EIGHT: Video Analysis

% After the last user verification step is complete, Easy Track will begin
% to analyze the object location frame by frame.  This step may take a
% significant amount of time, depending on the length of the videos being
% analyzed.  Easy Track will update the user as it processes by printing 
% to the command window.  When Easy Track has completed running, a video
% demonstrating the location of the tracked object will be saved in the
% Saved Video folder.  Additionally, the workspace will contain matrix 
% variables containing the number of frames analyzed and the location of
% the object in each frame.  There is also a "status" cell structure
% detailing the status of each video analyzed - this is intended to allow
% users to keep track of videos that have been successfully analyzed.  When
% MATLAB has finished running, the Easy Track analysis is complete.  All
% outputs are summarized along with the corresponding variable names below.

% OUTPUTS:
% - A saved film of the analysis with an overlaid ROI and tracking position
% for each frame.  This is available in the Saved Films directory.
% - rat_locations: a structure including a two column matrix of rat x+y
% positions
% - status: a matrix detailing whether or not a data film was processed
% - frames: a structure detailing the number of frames analyzed

%% About:
% Below, each portion Easy Track is briefly described.  This section is
% intended to assist users in troubleshooting possible errors or modifying
% Easy Track for a specific purpose. 

% For order of operation, see Script Flow below.

%run_easytrack_single.m + run_easytrack_batch (script)
% Operating script is run_easytrack.m - it is designed to run easy track and
% prompt the user through the analysis steps.  The script is delineated into
% three segments: Preprocessing, User Processing, and Object Processing.
% User input is required for User Processing; however, this is not the case 
% for Preprocessing and Object Processing, which may be run in the parallel 
% pool workspace in the batch processing version of Easy Track.

%generate_background.m (function)
% This function is responsible for the generation of the background image
% used in the Easy Track analysis.  The function takes in a video name,
% start frame, and end frame and uses these to produce a saved background
% image which is saved to the containing folder with the prefix
% "Generated". 

%verify_background.m (function)
% After the background has been generated, the user must verify that it has
% been properly generated.  This function also gives the user the ability
% to retry background generated with an increased number of frames as well
% as the ability to remove a particular video from analysis.  

%generate_roi.m (function)
% This function is responsible for guiding the user through setting the
% region of interest (ROI) as appropriate for the purposes of analysis.

%verify_location.m (function) 
% After the background and ROI have been created, this function is called
% to create an initial guess for the position of the object in question.
% The user will then be displayed this initial guess with the option to
% override it.  

%location_movie.m (function)
% This function iniates the process of object tracking analysis.
% Additionally, this function incorporates all of the remaining functions
% listed below.  Notably, location_movie.m both calls the function
% responsible for individual frame processing while keeping track of the
% saved locations.  It also writes analyzed frames to video.

%location_frame_trunc.m (function)
% location_frame_trunc.m is the function that allows for frame by frame
% analysis.  This function is called in location movie, and locates the
% object by subtracting the background image from the current data frame.
% It then locates the largest "blob" as the object in question.  


%% Script Flow
%
%run_easytrack.m -->    generate_background.m
%                       verify_background.m (requires user interaction)
%                       generate_roi.m (requires user interaction)
%                       verify_location.m (requires user interaction)
%                       location_movie.m --> location_frame_trunc.m
%             
%                               
%% Additional Notes

% Code by Eric Thomson (thomson dot eric : gmail)
% Adapted from Code by Per Petersen, Romulo Fuentes and Amol Yadav: Nicolelis Lab

% Extra Notes on Features
% 
% ROI: Functionality producing a binary mask has been added to select a
% region of interest.  This is particularly important during socialization 
% analysis as two rats are captured on video, but only one should be tracked.
% ROI shapes include an ellipse, rectangle, and an annulus.  Users are promted
% to select a shape upon running the program.  An ROI outline appears on the 
% saved version of the film.
% 
% Occluded Case: Previously, total occlusion of the rat would cause the
% code to stall.  As a result, code has been added such that if there is no 
% detected differences between the reference frame (background) and the 
% current frame the program will use the last known position of the animal
% and move to the next frame.
% 
% Filtering: A filter option has been added that prompts the user to input a
% filter size.  The filter is applied to every frame in the video prior to 
% % processing.
% 
% Background Generation:  Easy Track is capable of generating a background image
% from a trial video in which the tracking object exists. In order to utilize this
% feature, run this program separately using the trial video as an input.  The 
% script will output an MPEG-4 file containing the background which can then be
% used in Easy Track as one would ordinarily use it. Background Generation
% is optional for single video processing, but mandatory for batch
% processing. 
%
% Batch Processing: Easy Track can now be used to process multiple videos
% in parallel.  This feature was designed as such to take advantage of
% multiple core CPUs.  User verification is still required to run Easy
% Track, however.