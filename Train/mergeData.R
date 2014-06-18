library(RWeka)

fnc = read.csv("train_FNC.csv")
sbm = read.csv("train_SBM.csv")
labels = read.csv("train_labels.csv")

data = merge(fnc, sbm, by="Id")
data = merge(data, labels, by="Id")

data$Id = NULL
data$Class = as.factor(data$Class)

write.csv(data, "train.csv", row.names=FALSE)
write.arff(data, "train.arff")
