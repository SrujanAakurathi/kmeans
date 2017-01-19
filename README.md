# kmeans
k-means clustering algorithm

First type in:

``>> initialize``

to load in the data set. Then set your desired number of clusters, say:

``>> k = 2;``

Run k-means clustering algorithm to clusterize data set:

``>> [centroids, clusters] = kmeans( data, k );``

so that we get centroids:

``>> centroids``

and row indices of samples that live in the same cluster:

``>> clusters``

You can also use visualization version of the kmeans function to obtain more intuitive perspective. For instance, if you want to see the outcome of iterating 2 times in k-means clustering, type in:

``>> kmeansVisualize(data,2);``

The output pictures can be found in the main directory (although your output may be different from them because the centroids are randomly chosen).
