function [generated_background] = generate_background(vid_name, startFrame, endFrame)

%% generate_background 
% Based on Background Extraction by Patel TP, Gullotti DM, et al (2014)
% function pulls mode pixel intensity and generates a background estimation

filledMovie=VideoReader(vid_name);
%num_frames=filledMovie.NumberOfFrames;
ratMovie=filledMovie;
framerate = ratMovie.framerate;
%filledMovie 

%Get the first good frame
%datFrame=read(ratMovie, startFrame);
%datFrame=rgb2gray(datFrame);


% Determine Indices for Reading     
indices = [startFrame, endFrame];
% Generating Mode of Pixel Intensity
% Creating Matrix of Pixel intensities  
i = 1;
    while (hasFrame(ratMovie) && i<1000)
            vidFrame = readFrame(ratMovie);
           %for i=1:length(V,3)
             A(:,:,i) = rgb2gray(vidFrame);
             i = i+1;
    end
    
 % Creating Background image
 backgroundImage = uint8(mode(double(A),3));
 
%Save as a five frame mp4
generated_background = ['Generated_' vid_name];
outputVideo = VideoWriter(generated_background, 'MPEG-4');
open(outputVideo);
writeVideo(outputVideo, backgroundImage);
end 
 