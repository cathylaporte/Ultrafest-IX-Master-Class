% basic filtering operations (from MATLAB image processing toolbox)

% read the images using rgb2gray when appropriate to convert color images
% to gray scale images
im1 = imread('cameraman.tif'); % an image that comes packaged with MATLAB's image processing toolbox
us1 = rgb2gray(imread('images/us1.jpg')); % two ultrasound images from different scanners
us2 = rgb2gray(imread('images/us2.png'));

% Gaussian smoothing
im1_gauss = imgaussfilt(im1, 3);
us1_gauss = imgaussfilt(us1, 3);
us2_gauss = imgaussfilt(us2, 3);

% Image sharpening using the 'unsharp' filter
% Different parameter settings are allowed, see documentation
im1_sharp = imsharpen(im1);
us1_sharp = imsharpen(us1);
us2_sharp = imsharpen(us2);

% Edge detection - there are a number of methods, but the default (Sobel)
% is quite good
im1_sobel = edge(im1, 'sobel');

% Play around with Sobel edge detector's optional parameters here if
% desired (see MATLAB documentation)
us1_sobel = edge(us1, 'sobel');
us2_sobel = edge(us2, 'sobel');


% display the images for comparison
subplot(4,3,1);
imshow(im1,[]);
ylabel('original images');
subplot(4,3,2);
imshow(us1,[]);
subplot(4,3,3);
imshow(us2,[]);
subplot(4,3,4);
imshow(im1_gauss, []);
ylabel('gaussian smoothed images');
subplot(4,3,5);
imshow(us1_gauss, []);
subplot(4,3,6);
imshow(us2_gauss,[]);
subplot(4,3,7);
imshow(im1_sharp, []);
ylabel('sharpened images');
subplot(4,3,8);
imshow(us1_sharp, []);
subplot(4,3,9);
imshow(us2_sharp, []);
subplot(4,3,10);
imshow(im1_sobel, []);
ylabel('sobel edge detection');
subplot(4,3,11);
imshow(us1_sobel, []);
subplot(4,3,12);
imshow(us2_sobel, []);

