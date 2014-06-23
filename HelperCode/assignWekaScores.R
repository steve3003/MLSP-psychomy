example = read.csv(file='../submission_example.csv',head=TRUE,sep=",")

library(foreign)
scores = read.arff('../Test/scores.arff')

example$Probability = scores$distribution_1

write.csv(example,file='new_submission.csv',row.names=FALSE)
