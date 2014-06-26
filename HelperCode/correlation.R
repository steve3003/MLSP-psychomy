setwd("~/Documenti/poli/data-mining/MLSP-psychomy/")
library(class)
library(e1071)
library(foreign)

set <- read.arff("Train/data_continuos_complete-noFNC105.arff")
for(i in 1:(ncol(set)-2)){
  for(j in (i+1):(ncol(set)-1)){
    c=cor(set[,i],set[,j])
    if(c>0.5)
      print(str(i)+str(j)+str(c))
  }
}