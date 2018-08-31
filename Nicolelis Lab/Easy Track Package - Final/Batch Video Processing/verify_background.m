function [yes_no] = verify_background(background_file)
%background_verify
%   Written by Chris Penny 2/23/16
%   Allows user to verify generated background images for batch processing

%% Open Background Video File and Take First Frame:
background=VideoReader(background_file); %doc VideoReader if not sure
background=read(background,1);
background=rgb2gray(background);
    
%% Display Background and Ask For User Verification:
figure(1);
clf
imshow(background);
title('Was the background image properly generated?');
button = questdlg('Was the background image properly generated?', 'Background Verification', 'Yes', 'No - Try Again', 'No - Remove from Analysis', 'No - Remove from Analysis')

switch button;
    case 'Yes'
        yes_no = 1;
        close(figure(1));
    case 'No - Try Again'
        yes_no = 0;
        close(figure(1));
    case 'No - Remove from Analysis'
        yes_no = 2;
        close(figure(1));
end
