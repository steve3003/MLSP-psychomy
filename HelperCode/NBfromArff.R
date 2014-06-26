example = read.csv(file='../submission_example.csv',head=TRUE,sep=",")

library(foreign)
test = read.arff('../Test/test_svd_wrapper_NB_ROC.arff')
train = read.arff('../Train/svd_wrapper_NB_ROC.arff')

library(class)
library(e1071)
NBclass = naiveBayes(train[-length(train)], factor(train$Class))
test$Class = NULL

s = predict(NBclass, test, type = "raw")
example$Probability = s[,2]

write.csv(example,file='new_submission.csv',row.names=FALSE)
