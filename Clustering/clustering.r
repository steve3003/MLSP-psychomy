# foreign provides methods to read arff format
library(foreign)

# clustering evaluation functions
library(GMD)

# read the iris file in arff format
iris = read.arff("../Train/data_continuos_complete-noFNC105.arff")
iris$Class = NULL

dm <- dist(iris)
#dm <- dist(iris,method="manhattan")

#cl <- hclust(dm, method="single")
#cl <- hclust(dm, method="complete")
#cl <- hclust(dm, method="average")
cl <- hclust(dm, method="centroid")

plot(cl)

# init two vectors that will contain the evaluation
# in terms of within and between sum of squares
nClusters = 84
plot_wss = rep(0,nClusters)
plot_bss = rep(0,nClusters)

# evaluate every clustering
for(i in 1:nClusters) 
{
    clusters <- kmeans(iris,i)
    plot_wss[i] <- clusters$tot.withinss
    plot_bss[i] <- clusters$betweenss
  
    #clusters <- cutree(cl,i)
    #eval <- css(dm,clusters);
    #plot_wss[i] <- eval$totwss
    #plot_bss[i] <- eval$totbss
}

# plot the results
x = 1:nClusters

plot(x, y=plot_bss, main="Kmeans SSE", cex=1, pch=18, col="blue", xlab="Number of Clusters", ylab="Evaluation")
lines(x, plot_bss, col="blue")

par(new=TRUE)
plot(x, y=plot_wss, cex=1, pch=19, col="red", ylab="", xlab="", axes=FALSE)
lines(x,plot_wss, col="red");


