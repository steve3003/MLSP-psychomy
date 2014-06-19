data = read.csv("train.csv")

class = data$Class
data$Class = NULL

s = svd(data)

x = 1:length(s$d)
plot(x, y=s$d, main="singular values of D", cex=0.5, pch=18, col="blue", xlab="D dimension", ylab="Evaluation")
lines(x, s$d, col="blue")

x = 1:length(diff(s$d))
plot(x, y=diff(s$d), main="derivative of singular values of D", cex=0.5, pch=18, col="blue", xlab="D dimension", ylab="Evaluation")
lines(x, diff(s$d), col="blue")

nTake = 15
s$d[-(1:nTake)] = 0
svd_data = data.frame(s$u %*% diag(s$d) %*% t(s$v))
names(svd_data) = names(data)
svd_data$Class = class
svd_data$Class = as.factor(svd_data$Class)

write.csv(svd_data, "svd_train.csv", row.names=FALSE)
library(foreign)
write.arff(svd_data, "svd_train.arff")
