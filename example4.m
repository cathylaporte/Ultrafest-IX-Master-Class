% phase symmetry filtering and frangi filtering applied to vocal tract US
% images

% read the images using rgb2gray when appropriate to convert color images
% to gray scale images
us1 = rgb2gray(imread('images/us1.jpg')); % two ultrasound images from different scanners
us2 = rgb2gray(imread('images/us2.png'));

% we will need to convert our images to doubles to get the Frangi filter
% working
us1 = double(us1);
us2 = double(us2);

% maybe crop the interesting parts of the image before you start
%us1 = imcrop(us1, []);
%us2 = imcrop(us2, []);

% compute phase symmetry image using Peter Kovesi's implementation
us1_ps = phasesymmono(us1);
us2_ps = phasesymmono(us2);

% after a bit of parameter optimization...
% Only two relatively simple things were adjusted here, compared to default parameterization:
% 1. minWaveLength is set to 10 instead of 3 - larger wavelengths pick up
% features at larger scales, which will prevent some noise from being
% picked up here
% 2. polarity is set to 1 instead of 0 - we want to find only bright
% features, not both bright and dark
us1_ps_opt = phasesymmono(us1, 5, 10, 2.1, 0.55, 2.0, 1, -1);
us2_ps_opt = phasesymmono(us2, 5, 10, 2.1, 0.55, 2.0, 1, -1);

% compute frangi filtered image using Marc Schrijver and D.Kroon's
% implementation
addpath('frangi_filter_version2a');
% default option is to detect black ridges on white background.  To reverse
% this, we will pass in the reverse of the image
us1_frangi = FrangiFilter2D(-us1);
us2_frangi = FrangiFilter2D(-us2);

% what happens if we combine the two results by multiplication?
us1_ps_frangi = us1_ps_opt .* us1_frangi;
us2_ps_frangi = us2_ps_opt .* us2_frangi;

% and then look for the brightest bright parts (threshold) ?
us1_ridges = imbinarize(us1_ps_frangi);
us2_ridges = imbinarize(us2_ps_frangi);

% display the images for comparison
subplot(2,6,1);
imshow(us1,[]);
title('original images');
subplot(2,6,2);
imshow(us1_ps, []);
title('phase symmetry, no tuning');
subplot(2,6,3);
imshow(us1_ps_opt, []);
title('phase symmetry, a bit of tuning');
subplot(2,6,4);
imshow(us1_frangi, []);
title('frangi filtered');
subplot(2,6,5);
imshow(us1_ps_frangi, []);
title('phase symmetry (tuned)+ frangi');
subplot(2,6,6);
imshow(us1_ridges,[]);
title('phase symmetry, frangi + otsu');
subplot(2,6,7);
imshow(us2,[]);
subplot(2,6,8);
imshow(us2_ps,[]);
subplot(2,6,9);
imshow(us2_ps_opt, []);
subplot(2,6,10);
imshow(us2_frangi, []);
subplot(2,6,11);
imshow(us2_ps_frangi,[]);
subplot(2,6,12);
imshow(us2_ridges,[]);

% save the ridge images for future use
imwrite(us1_ridges, 'images/us1_ridges.jpg');
imwrite(us2_ridges, 'images/us2_ridges.jpg');

