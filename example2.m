% instensity thresholding

% read the images using rgb2gray when appropriate to convert color images
% to gray scale images
im1 = imread('cameraman.tif'); % an image that comes packaged with MATLAB's image processing toolbox
us1 = rgb2gray(imread('images/us1.jpg')); % two ultrasound images from different scanners
us2 = rgb2gray(imread('images/us2.png'));

% thresholding with user-defined thresholds
% with imbinarize, manually defined thresholds should lie on the [0,1]
% interval, where 0 is black and 1 is white.
im1_t100 = imbinarize(im1, 0.5); 
us1_t100 = imbinarize(us1, 0.5);
us2_t100 = imbinarize(us2, 0.5);

% thresholding with automatically determined 'optimal' Otsu threshold
im1_otsu = imbinarize(im1);
us1_otsu = imbinarize(us1);
us2_otsu = imbinarize(us2);

% display the images for comparison
subplot(3,3,1);
imshow(im1,[]);
ylabel('original images');
subplot(3,3,2);
imshow(us1,[]);
subplot(3,3,3);
imshow(us2,[]);

subplot(3,3,4);
imshow(im1_t100, []);
ylabel('manually thresholded images');
subplot(3,3,5);
imshow(us1_t100, []);
subplot(3,3,6);
imshow(us2_t100,[]);
subplot(3,3,7);
imshow(im1_otsu, []);
ylabel('otsu thresholded images');
subplot(3,3,8);
imshow(us1_otsu, []);
subplot(3,3,9);
imshow(us2_otsu, []);
