# clean environment
rm(list=ls())

# load required libraries
library(GEOquery)


# load GEO dataset of interest
GSEID <- 'GSE77952'
mygse <- getGEO(GSEID,GSEMatrix=TRUE, AnnotGPL = TRUE)

# Check out the structure of the dataset
str(mygse)


# extract annotation and expression data
annotation <- pData(phenoData(mygse[[1]]))
expressionLevels <- exprs(mygse[[1]])
arrayDesign <- fData(mygse[[1]])


#save the three tables as R objects, text tables or csv files
saveRDS(annotation, file="annotation.RDS")
saveRDS(expressionLevels, file="expression.RDS")
saveRDS(arrayDesign, file="design.RDS")


# Exercise 1: Vectors and Matrices
# Extract the expression values for a specific gene and sample
# inspect expression levels for a given probe and sample
# Extract the vector for the chosen one
# hint: exp_value <- expressionLevels[probe_name,sample_name]
colnames(expressionLevels)[1:10]
row.names(expressionLevels)[1:10]
genExp <- expressionLevels["A_23_P100011",]
sampleExp <- expressionLevels[,"GSM2062278"]
expressionLevels["A_23_P100011","GSM2062278"]
expressionLevels[2,2]

# inspect data 
summary(annotation)

# Extract the matrix for a subset of samples (using metadata for instance select female samples only)
colnames(annotation)
annotation$`tumor stage:ch1`
t1Samples <- row.names(annotation[which(annotation$`tumor stage:ch1`=="t1"),])

# check the expression matrix for NA's
# remove any row containing NA's or NULL data
anyNA(expressionLevels)
# if there were NA's
expressionLevels <- expressionLevels[complete.cases(expressionLevels), ]

# exercise 2: apply
# compute the mean expression for every probe/gene
mean_expression <- apply(expressionLevels, 1, mean)
# or explicit function notation
mean_expression <- apply(expressionLevels, 1, function(x){mean(x)})
# compute the standard deviation for every probe/gene
sd_expression <- apply(expressionLevels, 1, sd)
# compute coefficient of variation for every probe/gene
cv_expression <- sd_expression / mean_expression
# plot a histogram of the cv
hist(cv_expression, main="Histogram of Coefficient of Variation")
# remove all probes having a cv < 0.3
selected_probes <- names(cv_expression[cv_expression >= 0.3])
expressionLevelsLite <- expressionLevels[selected_probes, ]


# Exercise 3: Distances
# using the selected expression data (cv < 0.3)
# Calculate cosine distance between two samples
cosine <- cor(expressionLevelsLite[,1], expressionLevelsLite[,2], method="pearson")
# Calculate Euclidean distance between two samples
euclid <- sqrt(sum((expressionLevelsLite[,1]-expressionLevelsLite[,2])^2))
# Calculate Spearman correlation between two samples
rankCor<- cor(expressionLevelsLite[,1], expressionLevelsLite[,2], method="spearman")


# Exercise 3: Ranking by Similarity
# Rank samples based on cosine similarity to a reference sample
refSample <- "GSM2062278"
refExp <- expressionLevelsLite[, refSample]
cosDistz <- apply(expressionLevelsLite, 2, function(x, r=refExp){cor(r, x, method="pearson")}, refExp)
sort(cosDistz)

# compute cosine similarity distance matrix between samples
samplesCor <- cor(expressionLevelsLite, method="pearson")
# compute the disimilarity distance matrix between samples
samplesDis <- 1-samplesCor

# Exercise 4: correlation matrix plotting
# plot the whole set of correlation using corrplot
library(corrplot)
corrplot(samplesCor, method="circle")

# Exercise 5: Eigen Decomposition
# Perform eigen decomposition on the similatity matrix
# Perform eigen decomposition
eigen_result <- eigen(samplesCor)

# Extract eigenvalues and eigenvectors
eigenvalues <- eigen_result$values
eigenvectors <- eigen_result$vectors


# histogram of eigenvalues
hist(eigenvalues, main="Histogram of Eigenvalues")
#ERRATUM: barplot actually preffered
barplot(eigenvalues, main="eigenvalues")

# project samples on eigenvectors
# compute the product of sample expression with the two first eigenvectors
projected_data <- samplesCor %*% eigenvectors[, 1:2]
colnames(projected_data) <- c("projX", "projY")

# Exercise 6: scatterplot
# make a scatterplot of projected data on eigenvector 1 and 2
# color the dots according to a factor of interest in metadata
library(ggplot2)
toPlot <- cbind(projected_data, annotation)
toPlot <- as.data.frame(toPlot)
# visualizing "tumor stage"
ggplot(toPlot, aes(x=projX, y=projY, color=characteristics_ch1.3))+geom_point(size=6)
# visualizing "by age"
ggplot(toPlot, aes(x=projX, y=projY, color=characteristics_ch1.2))+geom_point(size=6)
# visualizing "by gender"
ggplot(toPlot, aes(x=projX, y=projY, color=characteristics_ch1.1))+geom_point(size=6)







# 
