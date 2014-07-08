library(foreign)

test = read.arff('../Test/test.arff')
train = read.arff('../Train/bagging_RF_train.arff')

filtered_test = test[names(train)]

write.arff(filtered_test,'../Test/testBRF.arff')
