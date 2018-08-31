%% Screen Grab

for i = 1:19;
cd '/Users/ChrisPenny/Documents/MATLAB/Nicolelis Analysis/Cascade Model Generator V2/Zero Maze Videos';
A = i;
videoFile = ['Video_' num2str(A) '.mp4'];
filledMovie = VideoReader(videoFile); %Read movie into MATLAB.
num_frames = filledMovie.NumberOfFrames %Number of frames in movie.

cd '/Users/ChrisPenny/Documents/MATLAB/Nicolelis Analysis/Cascade Model Generator V2/Positive Image Bank';
sample_interval = 110; %Sets sampling interval
    % Select a frame every 100 frames and save as jpg
    for j = 1:round(num_frames./sample_interval):num_frames
        frame = read(filledMovie, j);
        figure(1);
        imagesc(frame);
        B = j;
        filename = ['Video_' num2str(A) '_Frame_' num2str(B) '.jpg'];
        imwrite(frame, filename);
    end
end
