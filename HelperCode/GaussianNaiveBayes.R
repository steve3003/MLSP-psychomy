# This is an example of how to load and access the functional network
# connectivity (FNC) and source-based morphometry (SBM) features, provided
# for the 2014 MLSP Competition, using R 3.1.0.
#
# It also includes an example of how to compute the five number summary of
# each feature, as well as group-specific means and standard deviations.
#

## Load test files
# Assumes the file 'test_FNC.csv' is in the current folder.
# Load test FNC features from file into a data frame variable
# To change the current working directory use setwd()
setwd("~/Documenti/poli/data-mining/MLSP-psychomy/")
test = read.csv(file='Test/test_FNC.csv',head=TRUE,sep=",")

# Assumes the file 'test_SBM.csv' is in the current folder.
# Load test SBM features from file into a data frame variable
# To change the current working directory use setwd()
SBM_test = read.csv(file='Test/test_SBM.csv',head=TRUE,sep=",")

## Generate new submission file

# Assumes the file 'submission_example.csv' is in the current folder.
# Load example submission from file into a data frame variable
# To change the current working directory use setwd()
example = read.csv(file='submission_example.csv',head=TRUE,sep=";")

# Compute your scores here: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
library(class)
library(e1071)
library(foreign)

selected = read.arff("Train/data_continuos.arff")
labels = read.csv("Train/train_labels.csv")
trainSet = merge(trainSet, labels)
trainSet = trainSet[-1]

testSet = merge(FNC_test, SBM_test)
testSet = testSet[names(trainSet[-17])]

#Creating naive bayes classifier
NBclass = naiveBayes(trainSet[-17], factor(trainSet$Class))

# Running classifier
s = predict(NBclass, testSet, type = "raw")


# SCORES MUST BE VALUES BETWEEN 0 AND 1. Do not submit labels!
#scores = rep(1,dim(example)[1])

# Enter your scored into the example dataset
example$Probability = s[,2]

# Save your scores in a new submission file.
# This assumes you have write permission to the current folder.
write.csv(example,file='GNbayes_submission.csv',row.names=FALSE)