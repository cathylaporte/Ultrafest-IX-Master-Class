% using morphological operations to get at relevant parts of a processed and
% binarized ultrasound image

% read in the ridge images
us1_ridges = imread('images/us1_ridges.jpg');

% even though they are strictly black and white, these have been saved as 
% gray scale images in JPG format. So we need to binarize them first:
us1_ridges = imbinarize(us1_ridges);

% Find the connected components and pick the largest

% label connected components in the binary image
[cc_labels, nlabels] = bwlabel(us1_ridges);

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

% output image with only the largest connected component shown
us1_important_ridge = zeros(size(us1_ridges));
us1_important_ridge(find(cc_labels==largest)) = 1;

figure;
imshow(us1_ridges,[]);
figure;
imshow(us1_important_ridge,[]);


