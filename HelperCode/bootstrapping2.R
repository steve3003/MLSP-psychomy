setwd("~/Documenti/poli/data-mining/MLSP-psychomy/")
library(class)
library(e1071)
library(foreign)
library(pROC)

set = read.arff("Train/data_continuos_ultraselected.arff")
z <- vector()

x <- 1:100

for(i in seq(along=x)) {
  #bootstrap sampling
  sub <- sample(nrow(set), floor(nrow(set)),replace = TRUE)
  testing <- set[sub, ]
  training <- set[-sub, ]
  #testing inflating
  t <- sample(nrow(testing), 10*nrow(testing),replace = TRUE)
  testing <- testing[t,]
  #evaluation
  NBclass = naiveBayes(training[-ncol(set)], factor(training$Class))
  s = predict(NBclass,testing[-ncol(set)], type = "raw")
  z[i]<-auc(testing$Class,s[,2])
}

mean(z)