## Load test files
# Assumes the file 'test_FNC.csv' is in the current folder.
# Load test FNC features from file into a data frame variable
# To change the current working directory use setwd()
FNC_test = read.csv(file='Test/test_FNC.csv',head=TRUE,sep=",")

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

myFNC = read.csv("MLSP-psychomy//Train/train_FNC.csv")
mySBM = read.csv("MLSP-psychomy//Train/train_SBM.csv")
labels = read.csv("MLSP-psychomy//Train/train_labels.csv")
trainSet = merge(myFNC, mySBM)
trainSet = merge(trainSet, labels)
trainSet = trainSet[-1]

testSet = merge(FNC_test, SBM_test)

library(e1071)
tuned = tune.svm(Class~., data=trainSet, gamma = 10^(-6:-1), cost = 10^(-1:1))

model = svm(Class~., data=trainSet, kernel="radial", gamma=tuned$best.parameters$gamma, 
            cost=tuned$best.parameters$cost, probability=TRUE)

scores = predict(model, testSet, probability=TRUE)

# Enter your scored into the example dataset
example$Probability = scores

# Save your scores in a new submission file.
# This assumes you have write permission to the current folder.
write.csv(example,file='new_submission.csv',row.names=FALSE)
