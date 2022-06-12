# Unsupervised machine learning-based profiling in nutrition, exercise and health sciences: An STROBE study example on  anthropometry data from undergraduate students
- CLUSTERING ANALYSIS

Profiling aims to identify a given group (cluster) of participants where more phenotypic similarities can be found compared to those in other clusters. Here, anthropometric data were obtained from 319 freshman students (277F, 42M; 19.9±3.2 years; 58.8±12.2 kg; 162.1±7.9 cm). The aim of this study was twofold: i) to profile body composition and morphological features in freshman students of the Nutrition and Dietetics major at Universidad CES based on anthropometry-based (raw and derived) indices using clustering-based methods, and ii) to establish a practical workflow analysis of unsupervised machine learning-based profiling using different developed clustering methods that can be performed by researchers in different fields. The advantages of this unsupervised machine learning-based workflow analysis can be reproduced in any other characterization or research project using different data. Thus, the following step-by-step practical recommendations are given to perform a clustering-based profiling:
 
1.	Explore the data and import the database. It is important to clean the data for NA. 

2.	Standardize the data (scaling). It is recommended to change the range of the data (e.g., between zero to one) since variables frequently are in different magnitudes. 

3.	Create the distance or (dis)similarity matrix. In order to classify the data into clusters, it is necessary to calculate the distance between each pair of observations. Almost all clustering algorithms use the Euclidean distance as default distance measure; how-ever, one should consider other methods for measuring distances (e.g., Kendall, Manhattan, Canberra, Binary, Minkowski, Pearson, among others) depending on the type of data and research problem.

4.	Reduce dimensionality (when necessary). Most clustering algorithms cannot perform well on high-dimensional data (i.e., very high number of variables). In nutrition, ex-ercise and health sciences, this might occur often when large sets of variables have been collected. For instance, wearable technologies including physical activity monitors (e.g., ActiGraph monitors) or performance tracking systems (e.g., Wimu, Cata-pult, STATSports, etc.) generally record massive positioning-derived variables. To solve this problem a dimensionality reduction method (e.g., principal component analysis) might be executed as pre-process.

5.	Estimate the number of clusters (k value). Generally, this number is unknown. To calculate the optimal number of clusters in the data, it is recommended to use several validity indices to find the appropriate number. In our working example, a loop to test 16 algorithms with the function ‘NbClust’ was used.  

6.	Identify the most suitable clustering algorithm for your data. The best clustering method does not exist; therefore, evaluating the clustering performance with several algorithms increase the internal validity and robustness of the analysis. Remember: although k-means is the most known algorithm other methodologies such as k-medoids (PAM), hierarchical clustering, CLARA, CLARANS and Fuzzy Clustering might be suitable in certain situations. We used the ‘clValid’ package for doing this.

7.	Evaluate the optimal parameters for the clustering process. Once one has identified the algorithm, it is necessary to check the clustering parameters such as distance, method and iterations. For this practical STROBE-based study example we used the ‘Purrr’ package for internal evaluation of the agglomerative coefficient during the hi-erarchical clustering.

8.	Run the clustering algorithm by setting parameters based on the findings in previous steps. Plot the clusters using the corresponding visual for the clustering method.

9.	Paste the cluster groups (profiles) in the original data frame for further analyses.


Correspondence: 
RESEARCH DIVISION, DYNAMICAL BUSINESS & SCIENCE SOCIETY - DBSS INTERNATIONAL SAS, BOGOTÁ, COLOMBIA dabonilla@dbss.pro | jlpetro@dbss.pro | 
#EvolveWithScience | @TeamDBSS | 
www.DBSS.pro
