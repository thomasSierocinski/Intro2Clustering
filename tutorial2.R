# clean environment
rm(list=ls())

# load required libraries
library(GEOquery)


# load GEO dataset of interest
GSEID <- 'GSE_ID'
mygse <- getGEO(GSEID,GSEMatrix=TRUE, AnnotGPL = TRUE)

# Check out the structure of the dataset
str(mygse)


# extract annotation and expression data
annotation <- pData(phenoData(mygse[[1]]))
expressionLevels <- exprs(mygse[[1]])
arrayDesign <- fData(mygse[[1]])


#save the three tables as R objects, text tables or csv files


# Exercise 1: Vectors and Matrices
# Extract the expression values for a specific gene and sample
# inspect expression levels for a given probe/gene and sample
# hint: exp_value <- expressionLevels[probe_name,sample_name]

# inspect data 
summary(annotation)

# Extract the matrix for a subset of samples (using metadata for instance select female samples only)

# check the expression matrix for NA's
# remove any row containing NA's or NULL data


# exercise 2: apply
# compute the mean expression for every probe/gene
# compute the standard deviation for every probe/gene
# compute coefficient of variation for every probe/gene
# plot a histogram of the cv
# remove all probes having a cv < 0.5


# Exercise 3: Distances
# using the selected expression data (cv < 0.5)
# Calculate cosine distance between two samples
# Calculate Euclidean distance between two samples
# Calculate Spearman correlation between two samples


# Exercise 3: Ranking by Similarity
# Rank samples based on cosine similarity to a reference sample
# compute cosine similarity distance matrix between samples
# compute the disimilarity distance matrix between samples


# Exercise 4: correlation matrix plotting
# plot the whole set of correlation using corrplot


# Exercise 5: Eigen Decomposition
# Perform eigen decomposition on the similatity matrix
# Perform eigen decomposition


# Extract eigenvalues and eigenvectors

# histogram of eigenvalues


# project samples on eigenvectors
# compute the product of sample expression with the two first eigenvectors



# Exercise 6: scatterplot
# make a scatterplot of projected data on eigenvector 1 and 2
# color the dots according to a factor of interest in metadata





# 
