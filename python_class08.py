#Clustering e.g k-mean,Hierachy,DBscan,Spectral clustering。
import matplotlib.pyplot as plt
from sklearn.datasets import *

#/*Setting data set
#x, y = make_blobs( n_samples = 200 , centers = 3 , cluster_std = 0.8 , random_state = 1 )
#x , y = make_moons( n_samples = 200 , noise = 0.05)
#x , y = make_circles( n_samples = 200 , noise = 0.03)
#iris
iris = load_iris()
x = iris.data[:,2:]
y = iris.target
print(x)
print(y) 
#*/

plt.scatter( x[:,0] , x[:,1] )

#k-mean
from sklearn.cluster import KMeans

model_kmean = KMeans( n_clusters = 3 )
result_kmean = model_kmean.fit_predict(x)
#print(result_kmean)
plt.scatter(x[:,0] , x[:,1] , c = result_kmean )
cc = model_kmean.cluster_centers_
plt.scatter( cc[:,0] , cc[:,1] , c = 'red' , s = 200)
#plt.show()

#agglomerative clusting
from sklearn.cluster import AgglomerativeClustering

model_Aggl = AgglomerativeClustering(n_clusters = 3 , affinity = "l1" , linkage = "complete")
result_Aggl = model_Aggl.fit_predict(x)
plt.scatter( x[:,0] , x[:,1] , c = result_Aggl )
#plt.show()

#hierachy
from scipy.cluster.hierarchy import *
Hx, Hy = make_blobs( n_samples = 15 )
#dendrogram(complete(Hx))
#plt.show()

#DBSCAN
from sklearn.cluster import DBSCAN

model_dbscan = DBSCAN(eps = 0.25 , min_samples = 6)
result_dbscan = model_dbscan.fit_predict(x)
plt.scatter( x[:,0] , x[:,1] , c = result_dbscan )
plt.show()


#spectral clustering
from sklearn.cluster import SpectralClustering

model_Spect = SpectralClustering(n_clusters = 2)
result_Spect = model_Spect.fit_predict(x)
plt.scatter( x[:,0] , x[:,1] , c = result_Spect )
#plt.show()


#iris
iris = load_iris()
x = iris.data[:,]
y = iris.target








