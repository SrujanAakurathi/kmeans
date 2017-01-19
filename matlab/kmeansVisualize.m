function [centroids, clusters] = kmeansVisualize( data, max_step )
% Author: Zheng Rockman
% Last Modified: 2017-1-19
%%   K-Means Cluster Algorithm - For Visualization
%   This program receives a bunch of samples and groups them into
%   k clusters.
%
%   Input: 
%       data:       data set, one colomn per feature.
%       max_step:	max iterate step
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

k = 2;

%% Randomly pick initial centroids
centroids = rand(k,n);
for i = 1:n
   centroids(:,i) = (upper(i)-lower(i))*centroids(:,i)+lower(i); 
end

%% Use the first 3 features to visualize spatial distribution of the raw data
figure
scatter3(data(:,1),data(:,2),data(:,3),'g','o');    
hold on;
scatter3(centroids(1,1),centroids(1,2),centroids(1,3),'b','filled'); % Add centroids
scatter3(centroids(2,1),centroids(2,2),centroids(2,3),'r','filled'); % Add centroids

%% Repeat until convergence
step = 0;
while step < max_step
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

% Retrieve clusters
cluster1 = getCluster(data,clusters,1);
cluster2 = getCluster(data,clusters,2);

figure
scatter3(cluster1(:,1),cluster1(:,2),cluster1(:,3),'b','o');    % Use the first 3 features to visualize spatial distribution of the raw data
hold on;
scatter3(cluster2(:,1),cluster2(:,2),cluster2(:,3),'r','o');    % Use the first 3 features to visualize spatial distribution of the raw data
scatter3(centroids(1,1),centroids(1,2),centroids(1,3),'b','filled'); % Add centroids
scatter3(centroids(2,1),centroids(2,2),centroids(2,3),'r','filled'); % Add centroids
hold off;

%   Update centroid of each cluster by mean position of
%   samples currently inhabit in the same cluster

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
% Finish one step
step = step + 1;

figure
scatter3(cluster1(:,1),cluster1(:,2),cluster1(:,3),'b','o');    % Use the first 3 features to visualize spatial distribution of the raw data
hold on;
scatter3(cluster2(:,1),cluster2(:,2),cluster2(:,3),'r','o');    % Use the first 3 features to visualize spatial distribution of the raw data
scatter3(centroids(1,1),centroids(1,2),centroids(1,3),'b','filled'); % Add centroids
scatter3(centroids(2,1),centroids(2,2),centroids(2,3),'r','filled'); % Add centroids
hold off;

end
end

