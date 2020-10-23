% reading and visualizing three images, then changing the grey levels of a set of pixels in image 1

% read the images
im1 = imread('cameraman.tif'); % an image that comes packaged with MATLAB's image processing toolbox

us1 = imread('images/us1.jpg'); % two ultrasound images from different scanners
us2 = imread('images/us2.png');

% display the images
figure(1);
imshow(im1, []);  % use [] to scale range of gray levels between the 0-1 interval

figure(2);
imshow(us1, []);

figure(3);
imshow(us2, []);

pause;

im1(40, 200) = 0; % set pixel at row 40 and column 1 to black
im1(50:100, 40:60) = 128; % set pixels in a rectangle to mid-range gray

figure(1);
imshow(im1,[]);

% your ultrasound images may be read as color images and have three
% channels instead of one - uncomment these lines for the rest of the 
% code to work as intended
%us1 = rgb2gray(us1);
%us2 = rgb2gray(us2);

us1(200, 200) = 255; % set this pixel to white
us1(200:300, 40:60) = 255;

figure(2);
imshow(us1, []);

% save some results
imwrite(us1, 'painted_us1.jpg');

