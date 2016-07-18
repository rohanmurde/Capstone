
import csv
import numpy as np
import matplotlib.pyplot as plt

from sklearn.ensemble import ExtraTreesClassifier

file_path = '/Users/rohanmurde/Desktop/Capstone/Datasets/fromPEMM_after_mean_addDX.csv'

def read_csv(file_path):
    with open(file_path,'r') as csvFile:
     data = [row for row in csv.reader(csvFile.read().splitlines())]
     return data
     
#fetch data from csv by calling function.
data = read_csv(file_path)

#Using '[1:]' to ignore the first line of the returned array
temp = np.array(data)[1:]

#To convert temp from string to float
#X = np.array(temp)[:,1:-1] #includes cognitive markers.
X = np.array(temp)[:,4:-1] #excludes cognitive markers.
X = np.float_(X)

# Selecting DX column as target attributes. Slice last column.
y = temp[:,-1]

# Build a forest and compute the feature importances
forest = ExtraTreesClassifier(n_estimators=250,
                              random_state=0,
                              bootstrap=0)
                              
forest.fit(X,y)
importances = forest.feature_importances_
std = np.std([tree.feature_importances_ for tree in forest.estimators_],
             axis=0)
indices = np.argsort(importances)[::-1]

# Print the feature ranking
print("Feature ranking:")
for f in range(X.shape[1]):
    print("%d. feature %d (%f)" % (f + 1, indices[f], importances[indices[f]]))
    
# Plot the feature importances of the forest
plt.figure()
plt.title("Feature importances")
plt.bar(range(X.shape[1]), importances[indices],
       color="y", yerr=std[indices], align="center")
plt.xticks(range(X.shape[1]), indices)
plt.xlim([-1, X.shape[1]])
plt.show()


