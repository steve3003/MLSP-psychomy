library(foreign)

test = read.arff('../Train/svd_train.arff')
train = read.arff('../Train/data_continuos_complete-noFNC105.arff')

filtered_test = test[names(train)]

write.arff(filtered_test,'../Train/svd_data_continuos_complete-noFNC105.arff')
