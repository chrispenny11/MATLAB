htm=vision.TemplateMatcher;
 hmi = vision.MarkerInserter('Size', 10, ...
    'Fill', true, 'FillColor', 'White', 'Opacity', 0.75); I = imread('board.tif');

% Input image
  I = I(1:200,1:200,:); 

% Use grayscale data for the search
  Igray = rgb2gray(I);     

% Use a second similar chip as the template
  T = Igray(20:75,90:135); 

% Find the [x y] coordinates of the chip's center
  Loc=step(htm,Igray,T);  

% Mark the location on the image using white disc
  J = step(hmi, I, Loc);

imshow(T); title('Template');
figure; imshow(J); title('Marked target');