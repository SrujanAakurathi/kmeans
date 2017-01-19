function [centroids, clusters] = kmeans( data, k )
% Author: Zheng Rockman
% Last Modified: 2017-1-19
%%   K-Means Cluster Algorithm
%   This program receives a bunch of samples and groups them into
%   k clusters.
%
%   Input: 
%       data:   data set, one colomn per feature.
%       k:      desired number of clusters
%   Output:
%       centroids:  centroids of clusters
%       clusters:   row indices of samples of the same cluster

%% Analyse data set to 
%   get its dimension
%   obtain its boundaries
[m,n] = size(data);
% Feature value boundaries of all samples
upper = max(data);    
lower = min(data);

%% Randomly pick initial centroids
centroids = rand(k,n);
for i = 1:n
   centroids(:,i) = (upper(i)-lower(i))*centroids(:,i)+lower(i); 
end

%% Repeat until convergence
error = 10;
while error > 1e-6
% Initialize clusters
clusters = zeros(k,m);
ptrs = ones(1,k);     % Pointers indicating insert positions in clusters array.
%   For each sample
for i = 1:m
    sample = data(i,:);
    distances = zeros(1,k);   % Distances from k different centroids
%   For each centroid
    for j = 1:k
        centroid = centroids(j,:);
%   Compute the distance between centroid and sample
        direction = sample - centroid;
        distances(j) = sqrt(direction*direction');
    end
%   Assign this sample to the closest cluster, which is represented by
%   the corresponding centroid
    [~,new_cluster] = min(distances);    % Find the closest clusters
    clusters(new_cluster,ptrs(new_cluster)) = i;    % Insert this sample into new cluster
    ptrs(new_cluster) = ptrs(new_cluster) + 1;  % Increase update position
end
%   Update centroid of each cluster by mean position of
%   samples currently inhabit in the same cluster

old_centroids = centroids;% Record old centroids
centroids = zeros(k,n);     % Erase centroids data to take in new values
% For each cluster, update its centroid
for i = 1:k
    [~,~,cluster] = find(clusters(i,:));  % Get the non-zero entries of cluster
    % For each sample in this cluster
    for j = 1:length(cluster)
        centroids(i,:) = centroids(i,:) + data(cluster(j),:);   % Sum up
    end
    centroids(i,:) = centroids(i,:) ./length(cluster);  % Take average
end
% Compute error
diff = centroids - old_centroids;
errors = zeros(1,k);
% Compute error for each cluster
for i = 1:k
    errors(i) = sqrt(diff(i)*diff(i)');
end
% Return the maximum error
error = max(errors);
end

