% video processing - here we will simply process an ultrasound video 
% to remove background clutter that isn't the actual image

% open the video - this returns a movie handler
mh = VideoReader('images/us_video.avi');
nFrames = get(mh,'numberOfFrames');
% get an image sequence made of the movie frames.  
% The first two dimensions of the img_data array are the x and y 
% dimensions of the images, and the third dimension is time (frame number)
for ii = 1:nFrames
    img_data(:,:,ii) = double(rgb2gray(read(mh,ii)));
    imshow(img_data(:,:,ii),[]);    
end    


% find image mask by looking at parts where there is variation from one 
% image to the next (the background should be 99% the same between all
% images since they come from the same machine
var_img = var(img_data, 0, 3);

figure;
title('Variance image');
imshow(log(var_img+0.0001),[]);
pause;

mask = var_img > 10;

figure;
title('Binarized variance image');
imshow(mask, []);
pause;

% label connected components in the binary image (the largest will be the
% image)
[cc_labels, nlabels] = bwlabel(mask);

% compute the area of each connected component
max_area = 0;
largest = 0;
for ii = 1:nlabels
    area(ii) = numel(find(cc_labels==ii));
    if area(ii) > max_area
        max_area = area(ii);
        largest = ii;
    end
end

% output the mask with only the largest connected component shown
mask = zeros(size(mask));
mask(find(cc_labels==largest)) = 1;

figure;
title('The largest connected component of the binarized variance image is the image mask');
imshow(mask,[]);

pause;

% use this to mask out anything we don't want to see in the video
figure;
for i=1:nFrames
    imshow(img_data(:,:,i).*mask, []);
    pause(1/25);
end

   