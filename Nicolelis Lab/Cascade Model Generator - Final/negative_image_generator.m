clear 

% Load labeling session
load('2000_Image_Session.mat');


labelStructure = labelingSession.ImageSet.ROIBoundingBoxes;
sizeVal = size(labelStructure);
    
for i=1:sizeVal(2);
    cd '/Users/ChrisPenny/Documents/MATLAB/Nicolelis Analysis/Cascade Model Generator V2';
    bboxes(i, 1:4) = labelingSession.ImageSet.ROIBoundingBoxes(i).objectBoundingBoxes;
    fileNames{i} = labelingSession.ImageSet.ROIBoundingBoxes(i).imageFilename;
    image = imread(fileNames{i});
    bb = bboxes(i, :);
    % Size is hard coded here...Fix
    roi_mask_old = poly2mask([bb(1) bb(1)+bb(3) bb(1)+bb(3) bb(1)], [bb(2) bb(2) bb(2)+bb(4) bb(2)+bb(4)], 480, 640);
    % Invert the ROI_Mask
    for x = 1:480;
        for y = 1:640;
            if roi_mask_old(x,y) == 0
                roi_mask(x,y) = 1;
            elseif roi_mask_old(x,y) == 1;
                roi_mask(x,y) = 0;
            end 
        end
    end
    % Change to uint8
    roi_mask = uint8(roi_mask);
    adj_roi_mask = repmat(roi_mask(:,:,1),[1,1,3]);
    % Apply Mask to generate Negative Image
    negative_image = image.*adj_roi_mask;
    A = i;
    filename = ['Negative_Image_' num2str(A) '.jpg'];
    cd '/Users/ChrisPenny/Documents/MATLAB/Nicolelis Analysis/Cascade Model Generator V2/Negative_Folder';
    imwrite(negative_image, filename);
end


