# TUTORIAL 3



# prelims

# clean environment


# load required libraries and dataset
# requirements for the tutorial:
# ggplot2
# tidyr
# GeoQuery


# dataset
# using GeoQuery
# or
# loading the data saved as tables during tutorial 2

# get familiar with the data again
# check what data is available as sample information
# with colnames(), row.names(), summary()
# the dimensions of each object dim()
# check for NAs





# EXERCISE 1: Normalization

# 1.1 Perform Z-score normalization on the gene expression data, by genes (row) using the function scale()
# store the resulting matrix as another variable ("zcoredData" for instance)



# 1.2 Apply quantile normalization to the same dataset in the same fashion (by rows)
# install the preprocessCore package and use the normalize.quantiles() function



# 1.3 Compare the distribution of expression values before and after normalization using boxplots.
# using sample.int(), select 1000 rows in each data table (before, after normalization), the same rows should be selected across data tables
# as in lecture #3, slide #6
# use the boxplot() function from the base plotting and make a plot per table for each data matrix











# EXERCISE 2: Feature Selection
# working with the z-scored normalized data hereafter
# 2.1 remove invariants by
# computing the standard deviation for each row
# plot the distribution - comment on threshold to pick in order to remove uninformative data



# 2.2 Implement fold-change filtering to identify differentially expressed genes.
# pick a binary categorical endpoint in the samples information (gender, normal vs tumor...)
# using all(), row.names(), colnames(), make sure the samples are ordered the same way in both table (samples information and expression values)
# for each row, compute the fold change between the averages of your endpoint categories
# plot the histogram of computed fold changes 



# 2.3 Use ANOVA to select genes with significant differences across multiple groups.
# pick a categorical endpoint with strictly more that 2 categories in the samples information (tumor stage...)
# compute the ANOVA for each row
# plot a distribution of the pvalues. what can you say about it?
# if relevant, use the bonferroni multiple testing correction of you pvalues, plot the distribution. comment.



# 2.3 Apply linear regression to identify genes associated with a continuous variable (e.g., disease severity).
# using lm(), apply(), run your regression test on each row
# plot the p-value distribution, comment.
# use the bonferroni p-value correction method - plot the distribution of corrected p-values - comment.









# Exercise 3: Clustering
# Using the results from your feature selection - pick one
# from the original expression data, zscore the data matrix per sample (column)
# from the resulting matrix, select only the relevant features (as per your feature selection above), use a reasonable number of features (~1000 rows max)
# use the resulting matrix for the following two questions
 
 
 
# 3.1 Perform hierarchical clustering on the normalized gene expression data.
# compute the cosine/correlation distance matrix between samples using dist()
# run the hierarchical clustering function hclust(), using the "complete" method
# plot the clustering with a number of boxes corresponding to the number of category in your selected endpoint (if relevant)



# 3.2 Apply k-means clustering to group samples.
# run the k-means clustering, start by setting a k correponding to the number of categories in your sample endpoint of interest
# plot the clustering, as seen in lecture 3
# modify the value of k, observe the change



# 3.3 get the sample/cluster association from the two clustering above and compute the dunn's index for both
# comment on the results. Visually, are there any distinct clusters? any of them enriched for any given level of your selected endpoint?
# Describe, in your own words, how would you test the clustering's statistical relevance.





# Exercise 4: Heatmap Plotting


# 4.1 Create a heatmap using the original gene expression data.
# using the original data, select the relevant features (as in exercise 3)
# using the function heatmap(), make a heatmap of the expression data
# the heatmap should be set to order rows and columns hierarchically, using dendrograms


# 4.2 Similarly, generate a heatmap of the normalized data to observe changes in expression patterns.


# 4.3 Customize the heatmap to include clustering information and annotation.
# using the same heatmap (dendrogram on rows and columns)
# and the RowSideColors option of the heatmap() function, add a color sidebar representing endpoints of interest in the samples annotation.
# alternatively, the function heatmap.2() of the gplots package can also be used for this: https://search.r-project.org/CRAN/refmans/gplots/html/heatmap.2.html
# Visually, are there any annotations clearly separated by the clustering (any clustered enriched)?
# Describe, in your own words, how would you test the clustering's statistical relevance.





# Exercise 5: Parallelization

# 5.1 Using the parapply() function of the parallel package
# parallelize one of the feature selection method used for exercise 2


# 5.2 time the feature selction process with and without parallelization


# 5.3 Comment on the results




# Exercise 6: Integration of Concepts


# 6.1 Combine normalization, feature selection, and clustering to identify and visualize gene signatures associated with specific conditions.

# 6.2 Discuss the implications of different normalization and feature selection methods on downstream analysis.



# Exercise 7: Additional Challenges (Optional)

# 7.1 Explore other normalization methods (e.g., robust multi-array average, log transformation).

# 7.2 Implement alternative feature selection techniques (e.g., t-tests, LASSO regression).

# 7.3 Experiment with different clustering algorithms or distance metrics.

