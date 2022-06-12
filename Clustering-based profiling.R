###UNSUPERVISED MACHINE LEARNING-BASED PROFILING
##CLUSTERING ANALYSIS

#1. Importing data and normalization
database <- read.csv("database_CES_nutrition.csv", header = TRUE)
df <- scale(database)
head(df)

#2. Distance Matrix Calculation (exploration)
#Consider there are other methods such as "maximum", "manhattan", "canberra", 
#"binary", "minkowski", "pearson", or "spearman". Here an example with "kendall":
m.distancia <- get_dist(df, method = "kendall")
fviz_dist(m.distancia, gradient = list(low = "blue", mid = "white", high = "red"))

#3. Finding the optimal number of clusters
#This is a loop to test 16 algorithms with the function NbClust():
list.methods = c("kl", "ch", "hartigan","mcclain", "gamma", "gplus",
                 "tau", "dunn", "sdindex", "sdbw", "cindex", "silhouette",
                 "ball","ptbiserial", "gap","frey")
list.distance = c("method","euclidean", "maximum", "manhattan", "canberra")

table = as.data.frame(matrix(ncol = length(list.distance), nrow = length(list.methods)))
names(table) = list.distance

for (j in 2:length(list.distance)){
  for(i in 1:length(list.methods)){
    
    nb = NbClust(df, distance = list.distance[j],
                 min.nc = 2, max.nc = 10, 
                 method = "complete", index =list.methods[i])
    table[i,j] = nb$Best.nc[1]
    table[i,1] = list.methods[i]
    
  }}

table


#4. Testing clustering performance using different methods for internal validation
library("clValid")
intern <- clValid(df, nClust = 2:10, 
                  clMethods = c("hierarchical","kmeans","pam",'clara'),
                  validation = "internal")
summary(intern)
plot(intern)


#5. Running Hierarchical Clustering (HC)
#5.1. Evaluate HC methods - This helps to identify stronger clustering structures:
m <- c( "average", "single", "complete", "ward")
names(m) <- c( "average", "single", "complete", "ward")

#Computing agglomerative coefficient
ac <- function(x) {
  agnes(df, method = x)$ac
}

library(purrr)
map_dbl(m, ac)

#5.2. Running the HC algorithm
res2 <- hcut(df, k = 2, stand = TRUE, method = "median")
print(res2)
HC_groups = cutree(res2, k = 2)
HC_groups
table(HC_groups)

#5.3. Plotting the Dendogram
fviz_dend(res2, rect = TRUE, cex = 0.5,
          k_colors = "lancet")

#5.4. Pasting the cluster groups in the original dataframe
library(dplyr)
HC_cluster_results <- database %>%
  mutate(Cluster = HC_groups)

df1 <- read.csv("database.csv", header = TRUE)
df1 <- as.data.frame(df1)
df1$cluster<-as.factor(res2$cluster)
library(openxlsx)
write.xlsx(df1,"HC_results.xlsx")


#6.Matching analysis against categorical variables
database_HC <- read.csv("database_CES_nutrition.csv", header = TRUE)
table(database_HC$AÑO, database_HC$Cluster)
table(database_HC$ACTIVIDAD.FÍSICA, database_HC$Cluster)
table(database_HC$SEXO, database_HC$Cluster)


#7. 3D Plot of relevant variables (higher effect size or easy-to-measure)
library(plotly)
library(dplyr)
plot_ly(df1, x=~V2, y=~V24, z=~V20, color=~cluster, colors = c("blue","red")) %>%
  add_markers(size=1.5)



#####
#APENDIX
#A1. Calculating clusters with PAM
pam2 <- pam(df, 2)
print(pam2)
pam2$clusinfo

#A2. Plotting PAM clusters
fviz_cluster(pam2, data = df, ellipse.type = "euclid",repel = TRUE,star.plot = TRUE, 
             palette = "Set1", ggtheme = theme_classic())

#A3. Dimensionality reduction
#Principal Component Analysis (PCA)
library(FactoMineR)
res.pca <- PCA(df, ncp = 3, graph = FALSE)
print(res.pca)

#A4. Computing HC on PC (HCPC)
res.hcpc <- HCPC(res.pca, nb.clust = 2, graph = FALSE)
print(res.hcpc)
df1$HCPC<-as.factor(res.hcpc$data.clust$clust)
write.xlsx(df1,"HCPC_results.xlsx")
plot(res.hcpc, choice = "3D.map", ind.names=FALSE, title="Hierarchical Classification on 
     Principle Components", angle=60)

database_HCPC <- read.csv("database_CES_nutrition.csv", header = TRUE)
table(database_HCPC$AÑO, database_HCPC$HCPC)
table(database_HCPC$ACTIVIDAD.FÍSICA, database_HCPC$HCPC)
table(database_HCPC$SEXO, database_HCPC$HCPC)



### Correspondence ###
#RESEARCH DIVISION, DYNAMICAL BUSINESS & SCIENCE SOCIETY - DBSS INTERNATIONAL SAS
#BOGOTÁ, COLOMBIA - dabonilla@dbss.pro | jlpetro@dbss.pro
#EvolveWithScience | @TeamDBSS