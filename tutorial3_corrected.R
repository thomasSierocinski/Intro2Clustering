# TUTORIAL 3


# clean environment
rm(list=ls())

# load required libraries
library(GEOquery)
library(tidyr)
library(ggplot2)
library(clValid)
library(parallel)

# dataset
# using GeoQuery
# or
# loading the data saved as tables during tutorial 2
GSEID <- 'GSE77952'
mygse <- getGEO(GSEID,GSEMatrix=TRUE, AnnotGPL = TRUE)

# Check out the structure of the dataset
str(mygse)


# extract annotation and expression data
annotation <- pData(phenoData(mygse[[1]]))
expressionLevels <- exprs(mygse[[1]])
arrayDesign <- fData(mygse[[1]])




# get familiar with the data again
# check what data is available as sample information
# with colnames(), row.names(), summary()
# the dimensions of each object dim()
# check for NAs

colnames(annotation)
dim(expressionLevels)


# EXERCISE 1: Normalization


# 1.1 Perform Z-score normalization on the gene expression data, by genes (row) using the function scale()
# store the resulting matrix as another variable ("zcoredData" for instance)
zcoredData <- t(scale(t(expressionLevels), center=TRUE, scale=TRUE))


# 1.2 Apply quantile normalization to the same dataset in the same fashion (by rows)
# install the preprocessCore package and use the normalize.quantiles() function

#if (!require("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")

#BiocManager::install("preprocessCore")

library("preprocessCore")
qnormData <- normalize.quantiles(expressionLevels)
detach("package:preprocessCore", unload=TRUE)


# 1.3 Compare the distribution of expression values before and after normalization using boxplots.
# using sample.int(), select 1000 rows in each data table (before, after normalization), the same rows should be selected across data tables
# as in lecture #3, slide #6
# use the boxplot() function from the base plotting and make a plot per table for each data matrix

rows_to_select <- sample.int(nrow(expressionLevels), 1000)
before_norm <- as.data.frame(expressionLevels[rows_to_select, ])
bnData <- gather(before_norm, key="key", value="value")
ggplot(bnData, aes(x=key, y=value))+
  geom_boxplot()+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

after_zscore_norm <- as.data.frame(zcoredData[rows_to_select, ])
anData <- gather(after_zscore_norm, key="key", value="value")
ggplot(anData, aes(x=key, y=value))+
  geom_boxplot()+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

after_quantile_norm <- as.data.frame(qnormData[rows_to_select, ])
qData <- gather(after_quantile_norm, key="key", value="value")
ggplot(qData, aes(x=key, y=value))+
  geom_boxplot()+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))


# EXERCISE 2: Feature Selection
# working with the raw data hereafter
# 2.1 remove invariants by
# computing the standard deviation for each row
# plot the distribution - comment on threshold to pick in order to remove uninformative data
sd_values <- apply(expressionLevels, 1, sd)
hist(sd_values)
threshold <- 0.3  # Set your threshold
selected_rows <- sd_values > threshold
informative_data <- expressionLevels[selected_rows, ]
hist(sd_values[selected_rows])
dim(informative_data)
dim(expressionLevels)


# 2.2 after normalization of informative data, Implement fold-change filtering to identify differentially expressed genes.
# pick a binary categorical endpoint in the samples information (gender, normal vs tumor...)
# using all(), row.names(), colnames(), make sure the samples are ordered the same way in both table (samples information and expression values)
# for each row, compute the fold change between the averages of your endpoint categories
# plot the histogram of computed fold changes 

#zcoredData <- t(scale(t(informative_data), center=TRUE, scale=TRUE))
#library("preprocessCore")
#normData <- normalize.quantiles(informative_data)
#detach("package:preprocessCore", unload=TRUE)


endpoint_category <- as.factor(annotation$`gender:ch1`)
control_group <- levels(endpoint_category)[1]  
treatment_group <- levels(endpoint_category)[2]

all(row.names(annotation)==colnames(informative_data))

control_avg <- apply(informative_data[, endpoint_category == control_group], 1, mean)
treatment_avg <- apply(informative_data[, endpoint_category == treatment_group], 1, mean)

fold_changes <- treatment_avg/control_avg

hist(fold_changes, main = "Fold Changes", xlab = "Fold Change", breaks=100)



# 2.3 Use ANOVA to select genes with significant differences across multiple groups.
# pick a categorical endpoint with strictly more that 2 categories in the samples information (tumor stage...)
# compute the ANOVA for each row
# plot a distribution of the pvalues. what can you say about it?
# if relevant, use the bonferroni multiple testing correction of you pvalues, plot the distribution. comment.

foi <- as.factor(annotation$`tumor stage:ch1`)

aov_test <- apply(informative_data, 1, function(x, f=foi){
  return(aov(x~f))
},foi)

pvalues <- unlist(lapply(aov_test, function(x){
  summary_result <- summary(x)
  return(summary_result[[1]]$"Pr(>F)"[1])
}))

hist(pvalues, main = "ANOVA p-values", xlab = "p-value")


bonferroni_p_values <- p.adjust(pvalues, method = "bonferroni")
hist(bonferroni_p_values, main = "Bonferroni Corrected p-values", xlab = "p-value")


# 2.3 Apply linear regression to identify genes associated with a continuous variable (e.g., disease severity).
# using lm(), apply(), run your regression test on each row
# plot the p-value distribution, comment.
# use the bonferroni p-value correction method - plot the distribution of corrected p-values - comment.
cvar <- as.numeric(annotation$`age (years):ch1`)

lmTest <- apply(normData, 1, function(x, f=cvar){
  return(lm(x~f))
}, cvar)

lmPval <- as.numeric(unlist(lapply(lmTest, function(x){
  #print(x[[1]])
  s <- as.data.frame(summary(x)$coefficients)
  return(s["f","Pr(>|t|)"])
})))

hist(lmPval, main = "linear model p-values", xlab = "p-value")


# Exercise 3: Clustering
# Using the results from your feature selection - pick one
# from the original expression data, zscore the data matrix per sample (column)
# from the resulting matrix, select only the relevant features (as per your feature selection above), use a reasonable number of features (~1000 rows max)
# use the resulting matrix for the following two questions
 



# 3.1 Perform hierarchical clustering on the normalized gene expression data.
# compute the euclidean distance matrix between samples using dist()
# run the hierarchical clustering function hclust(), using the "complete" method
# plot the clustering with a number of boxes corresponding to the number of category in your selected endpoint (if relevant)
dist_matrix <- as.dist((1-cor(informative_data)))
hc <- hclust(dist_matrix, method="complete")
plot(hc)
rect.hclust(hc, k = 3, border = 2:6)

cutree(hc, k = 3)

annotation$`gender:ch1`
annotation$`tumor stage:ch1`
annotation$`age (years):ch1`

# 3.2 Apply k-means clustering to group samples.
# run the k-means clustering, start by setting a k correponding to the number of categories in your sample endpoint of interest
# plot the clustering, as seen in lecture 3
# modify the value of k, observe the change
k <- length(levels(as.factor(annotation$`tumor stage:ch1`)))
kmeans_result <- kmeans(t(informative_data), centers = k)
library(factoextra)
fviz_cluster(kmeans_result, data = t(informative_data))

kmeans_result$cluster
annotation$`gender:ch1`
annotation$`tumor stage:ch1`
annotation$`age (years):ch1`


# 3.3 get the sample/cluster association from the two clustering above and compute the dunn's index for both
# comment on the results. Visually, are there any distinct clusters? any of them enriched for any given level of your selected endpoint?
# Describe, in your own words, how would you test the clustering's statistical relevance.
dunn(clusters=kmeans_result$cluster, Data=informative_data)
dunn(clusters=cutree(hc, k = 3), Data=informative_data)



test <- as.data.frame(cbind(annotation$`tumor stage:ch1`, kmeans_result$cluster))
colnames(test) <- c("tumor_stage", "cluster")
test$tumor_stage <- as.factor(test$tumor_stage) 
test$cluster <- as.factor(test$cluster)
tabtest <- table(test)
chisq <- chisq.test(tabtest)
# there might be something there, should be digging deeper:
chisq


# Exercise 4: Heatmap Plotting


# 4.1 Create a heatmap using the original gene expression data.
# using the original data, select the relevant features (as in exercise 3)
# using the function heatmap(), make a heatmap of the expression data
# the heatmap should be set to order rows and columns hierarchically, using dendrograms

sd_values <- apply(expressionLevels, 1, sd)
hist(sd_values)
threshold <- 0.7  # Set your threshold
selected_rows <- sd_values > threshold
informative_data <- expressionLevels[selected_rows, ]

heatmap(informative_data, main = "Original Gene Expression Heatmap")

# 4.2 Similarly, generate a heatmap of the normalized data to observe changes in expression patterns.

Zinformative_data <- zcoredData[selected_rows, ]
heatmap(Zinformative_data, main = "Original Gene Expression Heatmap")

# 4.3 Customize the heatmap to include clustering information and annotation.
# using the same heatmap (dendrogram on rows and columns)
# and the RowSideColors option of the heatmap() function, add a color sidebar representing endpoints of interest in the samples annotation.
# alternatively, the function heatmap.2() of the gplots package can also be used for this: https://search.r-project.org/CRAN/refmans/gplots/html/heatmap.2.html
# Visually, are there any annotations clearly separated by the clustering (any clustered enriched)?
# Describe, in your own words, how would you test the clustering's statistical relevance.
library(gplots)
colnames(annotation)[38]<-"tumor_stage"
color.tumor <- data.frame(tumor_stage=levels(as.factor(annotation$tumor_stage)),
                           color=c("#66C2A5", "#FC8D62", "#8DA0CB", "yellow", "brown"))
df <- merge(annotation, color.tumor, by="tumor_stage")

heatmap.2(t(informative_data), main = "Original Gene Expression Heatmap", RowSideColor=df$color, trace='none')


# Exercise 5: Parallelization

# 5.1 Using the parapply() function of the parallel package
# parallelize one of the feature selection method used for exercise 2
no_cores <- detectCores()
clust <- makeCluster(no_cores)
foi <- as.factor(annotation$`tumor stage:ch1`)
clusterExport(clust, "foi")
aov_test <- parApply(clust, expressionLevels, 1, function(x, foi){aov(x~foi)}, foi)
stopCluster(clust)


# 5.2 time the feature selction process with and without parallelization
no_cores <- detectCores()
clust <- makeCluster(no_cores)
foi <- as.factor(annotation$`tumor stage:ch1`)
clusterExport(clust, "foi")
system.time(aov_test <- parApply(clust, expressionLevels, 1, function(x, foi){aov(x~foi)}, foi))
stopCluster(clust)


foi <- as.factor(annotation$`tumor stage:ch1`)
system.time(aov_test <- apply(expressionLevels, 1, function(x, f=foi){
  return(aov(x~f))
},foi))



# 5.3 Comment on the results


# Exercise 6: Integration of Concepts
# 6.1 Combine normalization, feature selection, and clustering to identify and visualize gene signatures associated with specific conditions.
# 6.2 Discuss the implications of different normalization and feature selection methods on downstream analysis.



# Exercise 7: Additional Challenges (Optional)
# 7.1 Explore other normalization methods (e.g., robust multi-array average, log transformation).
# 7.2 Implement alternative feature selection techniques (e.g., t-tests, LASSO regression).
# 7.3 Experiment with different clustering algorithms or distance metrics.
