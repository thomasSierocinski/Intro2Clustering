# TUTORIAL 4



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






# EXERCISE 1: Handling missing values
# Using the expression values

# 1.1 write a function that return the percentage of missing values per line
# use that function on your data
# remove all rows with more than half of its values missing. store the resulting matrix in another variable

# if your data does not carry missing values
#FIXME

# 1.2 install the CRAN package called multiUS
# using the KNNimp function
# see documentation here: https://search.r-project.org/CRAN/refmans/multiUS/html/KNNimp.html
# impute the missing value still present in your matrix



# EXERCISE 2: PERFORMING PCA
# the following exercise assume that we want to perfom PCA on samples (columns of expression data)


# 2.1 using the imputed expression matrix
# scale and center the dataset



# 2.2 perform principal component analysis of the expression data (on samples)
# using the function of your choice
# make a barplot of the eigenvalues by decreasing order

# 2.3 project the samples onto the principal comnponents




# EXERCISE 3
# Using the projected data


# 3.1 plot the PC1 and PC2 data in a scatterplot (basic plot or ggplot)


# 3.2 using the samples annotation, color your samples according to an endpoint of interest (gender, tumor stage, age etc...)


# using the sample information (annotation), and the endpoints of interest (categorical, continuous, ordinal data)
# run the appropriate test to gauge the association between your data on the first PCs (PC1, PC2, depending on the screeplot) and the endpoint
# correlation, krushkal wallis and/or mann-withney etc


# EXERCISE 4
# denoising data using SVD


# 4.1 Starting from the raw data
# Center the data


# 4.2 Perform the Singular Values Decomposition of the  matrix


# 4.3 Using the singular (eigen) values
# compute the amount of variance carried by each component
# make a barplot
# looking at the plot, select the number of component to keep (not noise)



# 4.4 For the matrix decomposition and the selected components
# reconstitute the dataset as a "cleaned" rectangular matrix


# 4.5 In your won words, how would you gauge the efficiency of this denoising approach?



# EXERCISE 5 
# MultiDimensional Scaling

# 5.1 USing the raw data matrix
# using dist() and cmdscale()
# perform the Classical MDS

# 5.2 Run the ISO MDS
# install the MASS package
# run the isomds() function on the data

# 5.3 Run the sammon() function of the MASS package


# 5.4 compare the dimensionality reductions above by
# generating 2D scatterplot of the 3 types of MDS performed
# comment
