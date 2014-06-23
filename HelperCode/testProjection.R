library(foreign)

test = read.arff('../Test/test.arff')
train = read.arff('../Train/svd_wrapper_NB_ROC.arff')

filtered_test = test[names(train)]

write.arff(filtered_test,'../Test/test_svd_wrapper_NB_ROC.arff')
