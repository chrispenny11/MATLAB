%% This script contains code necessary to run easy track.
%See Readme for additional detail.

%Clear Workspace
clear

%% Preprocessing
video_file = uigetfile('.mp4', 'Select Video File')%GUI for video file selection.

filledMovie = VideoReader(video_file); %Read movie into MATLAB.
num_frames = filledMovie.NumberOfFrames %Number of frames in movie.

%% Generate background image:
%If a background image has previously been generated, then a new image will not be generated.
background_file = ['Generated_' video_file]

%Check if background image already exists
if exist(background_file, 'file') == 0
    startFrame_background=50;
    endFrame_background=100;
    [generated_background] = generate_background(video_file, startFrame_background, endFrame_background); %If no image exists, generate one
    background_file = generated_background;
end

%% Load in background video.
blankMovie=VideoReader(background_file); %doc VideoReader if not sure
blankData=read(blankMovie,1);
blankData=rgb2gray(blankData);

%Place Data into Cell Format
ratMovie=filledMovie;
blankFrame=blankData;


%% User Processing


%Verify Background
[yes_no] = verify_background(['Generated_' video_file]);
while yes_no == 0;
    endFrame_background = inputdlg('Enter New End Frame');
    [generated_background] = generate_background(video_file, startFrame_background, endFrame_background); %If no image exists, generate one
    background_file = generated_background;
    [yes_no] = verify_background(['Generated_' video_file]);
    blankMovie=VideoReader(background_file); %doc VideoReader if not sure
    blankData=read(blankMovie,1);
    blankData=rgb2gray(blankData);
    blankFrame=blankData;
end

if yes_no == 1;
    % Generate ROIs: Call function to process ROIs before running.
    [roi_mask, pos_x, pos_y] = generate_roi(blankFrame);
    
    % Set Analysis start and end frame and verify object's intial
    % position
    startFrame=1;
    endFrame=200;
    searchWindow=40;%Sets a truncated search area for object tracking. If this value is too small, tracking will be inadequate.
    [bbox, bbsearch, rat_locations] = verify_location(video_file, blankFrame, searchWindow, 0, roi_mask, startFrame);
end

if yes_no == 2;
    status = [video_file ' : Removed from Analysis'];
end


%% Object Processing

if yes_no == 1;
    skipFrames=1;%Sets interval to sample frames - an adequate search window variable should be multiplied by this value.
    movieName= ['Data_Movie_' video_file]; %Movie file name. Set equal to 0 to not save movie.
    movieShow=1; %Toggle to watch or not watch movie. Movie will not show in parfor.
    filtersize=0; %Select a median filter size - a size of 0 will turn off the filter.
    %Call location_movie function to initiate tracking.
    [rat_locations, frames, videos_analyzed]=location_movie(video_file, ratMovie, blankFrame, startFrame, endFrame, skipFrames, searchWindow, movieShow, movieName, filtersize, roi_mask, pos_x, pos_y, bbsearch, rat_locations);
    status =[video_file ': Analyzed'];
else
    status =[video_file ': Not Analyzed'];
end

