import csv
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import ListedColormap
from sklearn.cross_validation import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.utils import shuffle

#list of classifiers
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, AdaBoostClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.lda import LDA
from sklearn.qda import QDA

h = .02  # step size in the mesh
names = ["Nearest Neighbors", "Linear SVM", "RBF SVM", "Decision Tree",
         "Random Forest", "AdaBoost", "Naive Bayes", "LDA", "QDA"]
         
classifiers = [
    KNeighborsClassifier(5),
    SVC(kernel="linear", C=0.025),
    SVC(gamma=2, C=1),
    DecisionTreeClassifier(max_depth=5),
    RandomForestClassifier(max_depth=5, n_estimators=10, max_features=1),
    AdaBoostClassifier(),
    GaussianNB(),
    LDA(),
    QDA()]

file_path = '/Users/rohanmurde/Desktop/Capstone/Datasets/selectedAttsExcludesCogMarkers.csv'

def read_csv(file_path):
    with open(file_path,'rU') as csvFile:
     data = [row for row in csv.reader(csvFile.read().splitlines())]
     return data
     
#Using '[1:]' to ignore the first line of the returned array
data = read_csv(file_path)[1:]
#print data

temp = np.array(data)

#Deselecting DX. Selecting data for classification
A = temp[:,1:-1]    
#print A

#To convert A from string to float
X = np.float_(A)

# Selecting DX column as target attributes.
y = temp[:,-1]   

class_index, y2 = np.unique(y, return_inverse=True)
print ("This is class_index:", class_index)
X, y2 = shuffle( X, y2 )

#figure = plt.figure(figsize=(27, 9))
#i = 1

X = StandardScaler().fit_transform(X)

#80-20 split.
X_train, X_test, y2_train, y2_test = train_test_split(X, y2, test_size=.2)

x_min, x_max = X_train[:, 3].min() - .5, X_train[:, 3].max() + .5
y_min, y_max = X_train[:, 4].min() - .5, X_train[:, 4].max() + .5
xx, yy = np.meshgrid(np.arange(x_min, x_max, h),
                     np.arange(y_min, y_max, h))
plt.figure(figsize=(40,8)) #width and heigth in inches
ax = plt.subplot(1, len(classifiers) + 1, 1)
 # Plot the training points
ax.scatter(X_train[:,3],X_train[:,4],c=y2_train,marker='o')
# and testing points
#ax.scatter(X_test[:, 3], X_test[:, 4], c=y2_test, alpha=0.6)
ax.set_xlim(xx.min(), xx.max())
ax.set_ylim(yy.min(), yy.max())
#ax.set_xticks(())
#ax.set_yticks(())    


# iterate over classifiers
for name, clf in zip(names, classifiers):
    clf.fit(X_train, y2_train)
    #To print the predicted class.
    #print (clf.predict(X_test)) 
    score = clf.score(X_test, y2_test)
    print (name, ": Accuracy=",score*100, "%")