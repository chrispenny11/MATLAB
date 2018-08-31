%This can be trained.

%Create Object
faceDetector = vision.CascadeObjectDetector;

%Read Image
I = imread('visionteam.jpg');

%Detect Faces
bboxes = step(faceDetector, I);

%Annotate and display figure
IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Face');
figure, imshow(IFaces), title('Detected faces');
