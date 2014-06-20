from sklearn.naive_bayes import GaussianNB
from numpy import genfromtxt, savetxt
from scipy.io.arff import loadarff
def main():
    #create the training & test sets, skipping the header row with [1:]
    fnc = loadarff(open('Train/train_FNC_attrSelected.arff','r'))
    sbm = loadarff(open('Train/train_SBM_attrSelected.arff','r'))
    testf = genfromtxt(open('Test/test_FNC.csv','r'), delimiter=',', dtype='f8')[1:]
    tests = genfromtxt(open('Test/test_SMB.csv','r'), delimiter=',', dtype='f8')[1:]

    
    gnb = GaussianNB()
    y_pred = gnb.fit(iris.data, iris.target).predict(iris.data)
    predicted_probs = [[index + 1, x[1]] for index, x in enumerate(gnb.predict_proba(test))]

    savetxt('Data/submission.csv', predicted_probs, delimiter=',', fmt='%d,%f', 
            header='MoleculeId,PredictedProbability', comments = '')

if __name__=="__main__":
    main()
