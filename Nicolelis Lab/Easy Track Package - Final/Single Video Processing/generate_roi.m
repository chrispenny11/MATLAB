function [roi_mask, pos_x, pos_y] = generate_roi(video_file)
%generate_roi.m
%   Function to generate an ROI mask based on user input
%   Chris Penny 2/11/16

%Initialize
blankFrame = video_file;
%% ROI Code
% Limits analysis to specific region of interest.
% Currently uses ellipse shape, but a switch structure will allow for
% annulus and rectange as well.
Shape = input('Enter ROI Shape (ellipse/rectangle/annulus): ', 's');
switch Shape;
    case 'ellipse'
    figure();
    imshow(blankFrame); % Pulls up the image
    dlgquest0=['Draw ellipse just outside the perimeter of the chamber. Double click when done.'];
    title(dlgquest0,'fontweight','b');
    outline_handle = imellipse();%Allows user to draw shape of the desired mask
    wait(outline_handle); %Line that introduces the need to double click shape
    roi_pos = getPosition(outline_handle); %Capture ROI position
    %Draw Ellipse:
    vert_x = [roi_pos(1) (roi_pos(1)+roi_pos(1)+roi_pos(3))./2 (roi_pos(1)+roi_pos(1)+roi_pos(3))./2 roi_pos(1)+roi_pos(3)];
    vert_y = [(roi_pos(2)+roi_pos(2)+roi_pos(4))./2 roi_pos(2) roi_pos(2)+roi_pos(4) (roi_pos(2)+roi_pos(2)+roi_pos(4))./2];
    h = vert_x(2); %h and k are center coordinates
    k = vert_y(1);
    a = vert_x(4) - h; % a and b are x radius and y radius
    b = vert_y(3) - k;
    theta_vals = linspace(0, 2*pi, 2000);
    pos_x = a.*cos(theta_vals) + h;
    pos_y = b.*sin(theta_vals) + k;
    roi_mask = outline_handle.createMask(); % create a binary image "mask" from the ROI object
    close(); % close the image
    roi_mask = cat(3, roi_mask, ~roi_mask, ~roi_mask);
    roi_mask=uint8(roi_mask); %Changes the binary mask to uint8 format

    case 'rectangle'
    figure();
    imshow(blankFrame); % Pulls up the image
    dlgquest0=['Draw rectangle just outside the perimeter of the chamber. Double click when done.'];
    title(dlgquest0,'fontweight','b');
    outline_handle = imrect();%Allows user to draw shape of the desired mask
    wait(outline_handle); %Line that introduces the need to double click shape
    roi_pos = getPosition(outline_handle); %Capture ROI position
    vert_x = [roi_pos(1) roi_pos(1) roi_pos(1)+roi_pos(3) roi_pos(1)+roi_pos(3)];
    vert_y = [roi_pos(2) roi_pos(2)+roi_pos(4) roi_pos(2) roi_pos(2)+roi_pos(4)];
    horiz_x = [linspace(vert_x(1), vert_x(3), 1000) linspace(vert_x(1), vert_x(3), 1000)];
    horiz_y = [ones(1,length(horiz_x)./2).* vert_y(1) ones(1,length(horiz_x)./2).* vert_y(2)];
    vertical_y = [linspace(vert_y(1), vert_y(2), 1000) linspace(vert_y(1), vert_y(2), 1000)];
    vertical_x = [ones(1,length(vertical_y)./2).*vert_x(1) ones(1,length(vertical_y)./2).*vert_x(3)]; 
    pos_x = [horiz_x vertical_x];
    pos_y = [horiz_y vertical_y];
    roi_mask = outline_handle.createMask(); % create a binary image "mask" from the ROI object
    close(); % close the image
    roi_mask = cat(3, roi_mask, ~roi_mask, ~roi_mask);
    roi_mask=uint8(roi_mask); %Changes the binary mask to uint8 format

    case 'annulus'
    figure();
    imshow(blankFrame); % Pulls up the image
    dlgquest0=['Draw outer ring just outside the perimeter of the chamber. Double click when done.'];
    title(dlgquest0,'fontweight','b');
    outline_handle1 = imellipse();%Allows user to draw shape of the desired mask
    wait(outline_handle1); %Line that introduces the need to double click shape
    roi_pos = getPosition(outline_handle1); %Capture ROI position
    vert_x = [roi_pos(1) (roi_pos(1)+roi_pos(1)+roi_pos(3))./2 (roi_pos(1)+roi_pos(1)+roi_pos(3))./2 roi_pos(1)+roi_pos(3)];
    vert_y = [(roi_pos(2)+roi_pos(2)+roi_pos(4))./2 roi_pos(2) roi_pos(2)+roi_pos(4) (roi_pos(2)+roi_pos(2)+roi_pos(4))./2];
    h = vert_x(2);
    k = vert_y(1);
    a = vert_x(4) - h;
    b = vert_y(3) - k;
    theta_vals = linspace(0, 2*pi, 2000);
    pos_x_1 = a.*cos(theta_vals) + h;
    pos_y_1 = b.*sin(theta_vals) + k;
    figure();
    imshow(blankFrame); % Pulls up the image
    dlgquest0=['Draw inner ring just inside the perimeter of the chamber. Double click when done.'];
    title(dlgquest0,'fontweight','b');
    outline_handle2 = imellipse();%Allows user to draw shape of the desired mask
    wait(outline_handle2); %Line that introduces the need to double click shape
    roi_mask1 = outline_handle1.createMask();% create a binary image "mask" from the ROI object
    roi_pos = getPosition(outline_handle2); %Capture ROI position
    vert_x = [roi_pos(1) (roi_pos(1)+roi_pos(1)+roi_pos(3))./2 (roi_pos(1)+roi_pos(1)+roi_pos(3))./2 roi_pos(1)+roi_pos(3)];
    vert_y = [(roi_pos(2)+roi_pos(2)+roi_pos(4))./2 roi_pos(2) roi_pos(2)+roi_pos(4) (roi_pos(2)+roi_pos(2)+roi_pos(4))./2];
    h = vert_x(2);
    k = vert_y(1);
    a = vert_x(4) - h;
    b = vert_y(3) - k;
    theta_vals = linspace(0, 2*pi, 2000);
    pos_x_2 = a.*cos(theta_vals) + h;
    pos_y_2 = b.*sin(theta_vals) + k;
    roi_mask2 = outline_handle2.createMask();
    pos_x = [pos_x_1 pos_x_2];
    pos_y = [pos_y_1 pos_y_2];
    close(); % close the image
    roi_mask1=cat(3, roi_mask1, ~roi_mask1, ~roi_mask1);
    roi_mask1=uint8(roi_mask1); %Changes the binary mask to uint8 format
    roi_mask2=cat(3, roi_mask2, ~roi_mask2, ~roi_mask2);
    roi_mask2=uint8(roi_mask2); 
    roi_mask = roi_mask1-roi_mask2; %Creates annulus by subtracting ellipse mask.
end 



end

