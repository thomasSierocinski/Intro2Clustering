# TUTORIAL 4

# prelims

# clean environment
rm(list = ls())

# load required libraries and dataset
# requirements for the tutorial:
# ggplot2
# tidyr
# GeoQuery
library(ggplot2)
library(tidyr)
library(GEOquery)

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
row.names(annotation)
summary(annotation)
dim(expressionLevels)
any(is.na(expressionLevels))

# EXERCISE 1: Handling missing values
# Using the expression values

# 1.1 write a function that returns the percentage of missing values per line
percentage_missing <- function(row) {
  sum(is.na(row)) / length(row) * 100
}

# use that function on your data
missing_percentages <- apply(expressionLevels, 1, percentage_missing)

# remove all rows with more than half of its values missing.
# store the resulting matrix in another variable
data_filtered <- expressionLevels[missing_percentages <= 50, ]

# if your data does not carry missing values
# skip this step or replace randomly some data by NAs

# 1.2 install the CRAN package called multiUS
# using the KNNimp function
# see documentation here: https://search.r-project.org/CRAN/refmans/multiUS/html/KNNimp.html
# impute the missing value still present in your matrix
install.packages("multiUS")
library(multiUS)

data_imputed <- KNNimp(data_filtered)

# EXERCISE 2: PERFORMING PCA
# the following exercise assumes that we want to perform PCA on samples (columns of expression data)

# 2.1 using the imputed expression matrix
# scale and center the dataset
scaled_centered_data <- scale(t(data_filtered), center = TRUE, scale = TRUE)

# 2.2 perform principal component analysis of the expression data (on samples)
# using the function of your choice
pca_result <- prcomp(scaled_centered_data)

# make a barplot of the eigenvalues by decreasing order
barplot(pca_result$sdev, main = "Scree Plot", xlab = "Principal Components", ylab = "Eigenvalues")

# 2.3 project the samples onto the principal components
projected_data <- as.data.frame(pca_result$x[, 1:2])

# EXERCISE 3
# Using the projected data

# 3.1 plot the PC1 and PC2 data in a scatterplot (basic plot or ggplot)
plot(projected_data$PC1, projected_data$PC2, main = "PCA: PC1 vs PC2", xlab = "PC1", ylab = "PC2")

annotated_data <- NA
all(row.names(annotation)==colnames(expressionLevels))
annotated_data <- cbind(projected_data, annotation)

# 3.2 using the samples annotation, color your samples according to an endpoint of interest
# (gender, tumor stage, age etc...)

# gender
ggplot(annotated_data, aes(x = PC1, y = PC2, color = characteristics_ch1.1)) +
  geom_point() +
  labs(title = "PCA: PC1 vs PC2", x = "PC1", y = "PC2")

# age
ggplot(annotated_data, aes(x = PC1, y = PC2, color = characteristics_ch1.2)) +
  geom_point() +
  labs(title = "PCA: PC1 vs PC2", x = "PC1", y = "PC2")

# tumor stage
ggplot(annotated_data, aes(x = PC1, y = PC2, color = characteristics_ch1.3)) +
  geom_point() +
  labs(title = "PCA: PC1 vs PC2", x = "PC1", y = "PC2")



# using the sample information (annotation), and the endpoints of interest
# (categorical, continuous, ordinal data)
# run the appropriate test to gauge the association between your data on the first PCs
# (PC1, PC2, depending on the screeplot) and the endpoint
# correlation, Kruskal-Wallis and/or Mann-Whitney etc.


# age - spearman rank correlation
age_pc1 <- cor.test(annotated_data$PC1, as.numeric(annotated_data$`age (years):ch1`), method="spearman")
age_pc2 <- cor.test(annotated_data$PC2, as.numeric(annotated_data$`age (years):ch1`), method="spearman")

ggplot(annotated_data, aes(x = PC1, y = PC2, color = characteristics_ch1.2)) +
  geom_point() +
  labs(title = "PCA: PC1 vs PC2", x = paste("PC1", "\n", "rho = ", signif(age_pc1$estimate, 4), ", p = ", signif(age_pc1$p.value, 4) , sep=""),
       y = paste("PC2", "\n", "rho = ", signif(age_pc2$estimate, 4), ", p = ", signif(age_pc2$p.value, 4) , sep=""))


# tumor stage
ts_pc1 <- kruskal.test(annotated_data$PC1, as.factor(annotated_data$characteristics_ch1.3))
ts_pc2 <- kruskal.test(annotated_data$PC2, as.factor(annotated_data$characteristics_ch1.3))

ggplot(annotated_data, aes(x = PC1, y = PC2, color = characteristics_ch1.3)) +
  geom_point() +
  labs(title = "PCA: PC1 vs PC2", x = paste("PC1", "\n", "KW chi sq = ", signif(ts_pc1$statistic, 4), ", p = ", signif(ts_pc1$p.value, 4) , sep=""),
       y = paste("PC2", "\n", "KW chi sq = ", signif(ts_pc2$statistic, 4), ", p = ", signif(ts_pc2$p.value, 4) , sep=""))

# EXERCISE 4
# denoising data using SVD

# 4.1 Starting from the raw imputed data
# Center the data
centered_data <- scale(data_imputed, center = TRUE, scale = FALSE)

# 4.2 Perform the Singular Values Decomposition of the matrix
svd_result <- svd(centered_data)

# 4.3 Using the singular (eigen) values
# compute the amount of variance carried by each component
# make a barplot
variance_explained <- (svd_result$d) / sum(svd_result$d)
barplot(variance_explained, main = "Variance Explained by Components", xlab = "Components", ylab = "Variance Explained")

# looking at the plot, select the number of components to keep (not noise)

# 4.4 For the matrix decomposition and the selected components
# reconstitute the dataset as a "cleaned" rectangular matrix
num_components_to_keep <- 7
cleaned_data <- svd_result$u[, 1:num_components_to_keep] %*% diag(svd_result$d[1:num_components_to_keep]) %*% t(svd_result$v[, 1:num_components_to_keep])


# 4.5 In your own words, how would you gauge the efficiency of this denoising approach?




# EXERCISE 5
# MultiDimensional Scaling

# 5.1 Using the raw imputed data matrix
# using dist() and cmdscale()
# perform the Classical MDS
classical_mds <- cmdscale(dist(t(data_imputed)))

# 5.2 Run the ISO MDS
# install the MASS package
# run the isomds() function on the data
install.packages("MASS")
library(MASS)
iso_mds <- isoMDS(dist(t(data_imputed)), k=2)

# 5.3 Run the sammon() function of the MASS package
sammon_mds <- sammon(dist(t(data_imputed)))

# 5.4 compare the dimensionality reductions above by
# generating 2D scatterplot of the 3 types of MDS performed
# comment
par(mfrow = c(1, 3))
plot(classical_mds, main = "Classical MDS", xlab = "Dimension 1", ylab = "Dimension 2")
plot(iso_mds$points, main = "ISO MDS", xlab = "Dimension 1", ylab = "Dimension 2")
plot(sammon_mds$points, main = "Sammon MDS", xlab = "Dimension 1", ylab = "Dimension 2")

