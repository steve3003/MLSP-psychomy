data = read.csv("train.csv")

class = data$Class
data$Class = NULL

s = svd(data)

x = 1:length(s$d)

plot(x, y=s$d, main="Singular value of D", cex=1, pch=18, col="blue", xlab="nth singular value", ylab="value")
lines(x, s$d, col="blue")

energy = rep(0,length(s$d))
for(i in x) 
{
  energy[i] = s$d[1:i] %*% s$d[1:i]
}
energy = 100 * energy / energy[length(energy)]
plot(x, y=energy, main="Energy of singular values of D", cex=1, pch=18, col="blue", xlab="D dimension", ylab="% Energy")
lines(x, energy, col="blue")

nTake = Position(function(x) x >= 90, energy)
u = as.matrix(s$u[, 1:nTake])
v = as.matrix(s$v[, 1:nTake])
d = as.matrix(diag(s$d)[1:nTake, 1:nTake])
svd_data = data.frame(u %*% d %*% t(v))
names(svd_data) = names(data)
svd_data$Class = class
svd_data$Class = as.factor(svd_data$Class)

write.csv(svd_data, "svd_train.csv", row.names=FALSE)
library(foreign)
write.arff(svd_data, "svd_train.arff")
