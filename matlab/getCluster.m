function [ cluster_data ] = getCluster( data, cluster_pos, id )
%GETCLUSTER 此处显示有关此函数的摘要
% Retrieve data of samples that live in the same cluster
% id: specify which cluster you want to retrieve

% k: number of clusters
% m: number of samples
% n: number of features
[k,~] = size(cluster_pos);
[m,n] = size(data);

[~,cluster_size] = size(find(cluster_pos(id,:))); % Record the size of cluster

cluster_data = zeros(cluster_size,n);

for i = 1:cluster_size
    cluster_data(i,:) = data(cluster_pos(id,i),:);
end
end

