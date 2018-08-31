%This can be trained.

% load('2000_Image_Session.mat');

trainCascadeObjectDetector('Rats_Haar.xml', positiveInstances, 'Negative_Folder', 'FalseAlarmRate',0.2,'TruePositiveRate', 0.995); %,'NumCascadeStages', 20

%Create Object
ratDetector = vision.CascadeObjectDetector('Rats_Haar.xml');

%Load video
cd '/Users/ChrisPenny/Documents/MATLAB/Nicolelis Analysis/Cascade Model Generator V2/Zero Maze Videos';
videoFReader = vision.VideoFileReader('Video_1.mp4', 'VideoOutputDataType', 'uint8');

%Create video player object
videoPlayer = vision.VideoPlayer('Position', [100, 100, 680, 520]);
videoFrame = step(videoFReader);

cd '/Users/ChrisPenny/Documents/MATLAB/Nicolelis Analysis/Cascade Model Generator V2';
%Generate ROI
[roi_mask, pos_x, pos_y] = generate_roi(videoFrame);

%% PT2
% Read the first video frame, which contains the object, define the region.

videoFrame = videoFrame.*repmat(roi_mask(:,:,1),[1,1,3]);
imagesc(videoFrame);
last_bboxes = zeros(1, 4);

while ~isDone(videoFReader)
           bboxes = step(ratDetector, videoFrame);
           size_boxes = size(bboxes);
%            if size_boxes(1) > 1;
%                for i = 1:size_bboxes(1);
%                 bboxes = bboxes(i, 1:4);
%            end
           %Annotate and display figure
           IRats = insertObjectAnnotation(videoFrame, 'rectangle', bboxes, 'Rat');
           figure(1), imshow(IRats), title('Detected Rat');
           step(videoPlayer, videoFrame);
           videoFrame = step(videoFReader);
           videoFrame = videoFrame.*repmat(roi_mask(:,:,1),[1,1,3]);
           last_bboxes = bboxes;
end

%Release objects
release(videoPlayer);
release(videoFReader);