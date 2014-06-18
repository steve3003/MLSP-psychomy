data = read.csv("train.csv")

s = svd(data)
#s$u %*% diag(s$d) %*% t(s$v)

x = 1:length(s$d)
plot(x, y=s$d, main="singular values of D", cex=0.5, pch=18, col="blue", xlab="D dimension", ylab="Evaluation")
lines(x, s$d, col="blue")

x = 1:length(diff(s$d))
plot(x, y=diff(s$d), main="derivative of singular values of D", cex=0.5, pch=18, col="blue", xlab="D dimension", ylab="Evaluation")
lines(x, diff(s$d), col="blue")
