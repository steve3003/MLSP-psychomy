setwd("~/Documenti/poli/data-mining/MLSP-psychomy/")
library(class)
library(e1071)
library(foreign)
library(pROC)
library(tcltk)
set = read.arff("Train/data_continuos_complete-noFNC105-noOut.arff")
z <- vector()
x <- 1:10000
total <- 10000
# create progress bar
pb <- tkProgressBar(title = "progress bar", min = 0,max = total, width = 300)
for(i in seq(along=x)) {
  #bootstrap sampling
  sub <- sample(nrow(set), floor(nrow(set)),replace = TRUE)
  testing <- set[sub, ]
  training <- set[-sub, ]
  #evaluation
  NBclass = naiveBayes(training[-ncol(set)], factor(training$Class))
  s1 = predict(NBclass,testing[-ncol(set)], type = "raw")
  s2 = predict(NBclass,training[-ncol(set)], type = "raw")
  z[i]<-0.632*auc(testing$Class,s1[,2])+0.368*auc(training$Class,s2[,2])
  setTkProgressBar(pb, i, label=paste( round(i/total*100, 0),"% done"))
}
close(pb)
mean(z)