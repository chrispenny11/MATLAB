%% This script contains code necessary to run easy track.
%See Readme for additional detail.

%Clear Workspace
clear

%% Preprocessing
video_file = uigetfile('.mp4', 'Select Video File', 'MultiSelect', 'on')%GUI for video file selection.

parfor i=1:length(video_file)
    filledMovie = VideoReader(video_file{i}); %Read movie into MATLAB.
    num_frames = filledMovie.NumberOfFrames %Number of frames in movie.
    
    %% Generate background image:
    %If a background image has previously been generated, then a new image will not be generated.
    background_file = ['Generated_' video_file{i}]
    
    %Check if background image already exists
    if exist(background_file, 'file') == 0
        startFrame_background=50;
        endFrame_background=100;
        [generated_background] = generate_background(video_file{i}, startFrame_background, endFrame_background); %If no image exists, generate one
        background_file = generated_background;
    end
    
    %% Load in background video.
    blankMovie=VideoReader(background_file); %doc VideoReader if not sure
    blankData=read(blankMovie,1);
    blankData=rgb2gray(blankData);
    
    %Place Data into Cell Format
    ratMovie{i}=filledMovie;
    blankFrame{i}=blankData;
end

%% User Processing

for k=1:length(video_file);
    %Verify Background
    [yes_no{k}] = verify_background(['Generated_' video_file{k}]);
    while yes_no{k} == 0;
        endFrame_background = inputdlg('Enter New End Frame');
        [generated_background] = generate_background(video_file{i}, startFrame_background, endFrame_background); %If no image exists, generate one
        background_file = generated_background;
        [yes_no{k}] = verify_background(['Generated_' video_file{k}]);
        blankMovie=VideoReader(background_file); %doc VideoReader if not sure
        blankData=read(blankMovie,1);
        blankData=rgb2gray(blankData);
        blankFrame{k}=blankData;
    end
    
    if yes_no{k} == 1;
        % Generate ROIs: Call function to process ROIs before running.
        [roi_mask{k}, pos_x{k}, pos_y{k}] = generate_roi(blankFrame, k);
        
        % Set Analysis start and end frame and verify object's intial
        % position
        startFrame=1;
        endFrame=200;
        searchWindow=40;%Sets a truncated search area for object tracking. If this value is too small, tracking will be inadequate.
        [bbox{k}, bbsearch{k}, rat_locations{k}] = verify_location(video_file{k}, blankFrame{k}, searchWindow, 0, roi_mask{k}, startFrame);
    end
    
    if yes_no{k} == 2;
        status{k} = [video_file{k} ' : Removed from Analysis'];
    end
end

%% Object Processing
parfor z = 1:length(video_file);
    if yes_no{z} == 1;
        skipFrames=1;%Sets interval to sample frames - an adequate search window variable should be multiplied by this value.
        movieName= ['Data_Movie_' video_file{z}]; %Movie file name. Set equal to 0 to not save movie.
        movieShow=0; %Toggle to watch or not watch movie. Movie will not show in parfor.
        filtersize=0; %Select a median filter size - a size of 0 will turn off the filter.
        %Call location_movie function to initiate tracking.
        [rat_locations{z}, frames{z}, videos_analyzed{z}]=location_movie(video_file{z}, ratMovie{z}, blankFrame{z}, startFrame, endFrame, skipFrames, searchWindow, movieShow, movieName, filtersize, roi_mask{z}, pos_x{z}, pos_y{z}, bbsearch{z}, rat_locations{z});
        status{z} =[video_file{z} ': Analyzed'];
    else 
        status{z} =[video_file{z} ': Not Analyzed'];
    end
end
