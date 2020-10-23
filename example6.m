% using clustering methods to get at relevant parts of a processed and
% binarized ultrasound image

% read in the ridge images
us1_ridges = imread('images/us1_ridges.jpg');

% even though they are strictly black and white, these have been saved as 
% gray scale images in JPG format. So we need to binarize them first:
us1_ridges = imbinarize(us1_ridges);

% retrieve the (row, column) coordinates of the pixels that are lit
[on_row, on_col] = find(us1_ridges);

% use the k-means algorithm to cluster the lit pixels into a given number
% of groups based on their position in the image
% this requires some trial and error on the number of clusters, and does
% not always work (most of the time it doesn't)
for k = 2:8
    [idx_kmeans, cluster_centers] = kmeans([on_row,on_col], k);

    % color an output image according to cluster label
    cluster_img = zeros(size(us1_ridges));
    for ii = 1:k
        idx = find(idx_kmeans==ii);
        cluster_img(sub2ind(size(cluster_img), on_row(idx), on_col(idx))) = ii;
    end
    figure;
    imshow(cluster_img, []);
end

% use the DBSCAN algorithm to cluster the lit pixels into a number of
% clusters to be determined automatically by the algorithm.  Instead of
% specifying a number of clusters, we must specify:
% 1. a maximum distance between neighbouring points in a cluster
% 2. a minimum number of points (pixels, in our case) required to constitute a cluster
% Peter Kovesi's implementation is a bit slow but works very well for this
% A bit of trial and error may be needed to set the parameters to taste
[cluster_content, cluster_id, cluster_centers] = dbscan([on_row,on_col]', 30, 20);
cluster_img = zeros(size(us1_ridges));
n_dbscan_clusters = max(size(cluster_centers));
for ii = 1:n_dbscan_clusters
    idx = find(cluster_id==ii);
    cluster_img(sub2ind(size(cluster_img), on_row(idx), on_col(idx)))=ii;    
end
figure;
imshow(cluster_img,[]);

% keep only the largest cluster
largest = 0;
max_size = 0;
for ii = 1:n_dbscan_clusters
    s = numel(find(cluster_id ==ii));
    if s > max_size
        max_size = s;
        largest = ii;
    end
end

largest_clust_img = zeros(size(us1_ridges));
idx = find(cluster_id == largest);
largest_clust_img(sub2ind(size(largest_clust_img), on_row(idx), on_col(idx))) = 1;
figure;
imshow(largest_clust_img, []);