# TUTORIAL 1


########################################
# section 1: packages installation, getting started
#########################################


# 1.1 install all required packages
# CRAN
install.packages(c("parallel", "matrixcalc", "Hmisc", "corrplot", "tidyr", "ggplot2", "RColorBrewer", "readxl")) # note: package is 'readxl'


# 1.2 Bioconductor
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("GEOquery")


# 1.3 getting started
rm(list = ls()) # clean environment
getwd() # check working directory
pathToDir <- "" # set your path if needed
setwd(pathToDir)


# 1.4 Load GEO dataset (GSE77952)
library(GEOquery)
GSEID <- "GSE77952"
mygse <- getGEO(GSEID, GSEMatrix = TRUE)[[1]]
annotation <- pData(phenoData(mygse))
expressionLevels <- exprs(mygse)
write.table(annotation, "annotation.txt", sep = "\t", quote = FALSE)
write.table(expressionLevels, "expression.txt", sep = "\t", quote = FALSE)


####################################
# Section 2: R objects & indexing using GEO pheno data (15 min)
####################################

# Concepts: 
# vector, factor, list, data.frame, class(), str(), length(), indexing [ , ], $, names(), rownames(), colnames(), as.factor(), as.numeric().

#Tasks:
  
#  1 - Inspect the objects: what are mygse, annotation, expressionLevels? Use class(), str(), dim().
#  2 - Examine the sample annotation table: Print anntations first rows , view column names.
#  3 - Turn a relevant sample descriptor into a factor (choose a column, e.g. a ‘group’/‘status’ like variable). Store into variable "annotation$group"
#  4 - Do basic indexing:
#    a - Select first 5 samples (columns) from expressionLevels and first 100 genes (rows). get the dimensions
#    b - Extract expression of a single gene/probe (row) across all samples.



####################################
# Section 3: Summaries, tables, missing values
####################################

# Concepts: summary(), table(), prop.table(), is.na(), any(), all(), which(), complete.cases(), colSums(), rowSums().

# Tasks:
# 1 - Summarize the group factor: frequency and proportions.
# 2 - Check for missing values in annotation and expressionLevels.
# 3 - Compute per‑sample missing counts (if any) and per‑geen/probe missing counts.
# Create a filtered expression matrix keeping only complete genes (no missing values).

# Hints:
#complete.cases(expressionLevels) returns a logical vector for rows;
#wrap with rowSums(is.na(...)) == 0 for clarity.

# Deliverables:
# Console outputs (tables, counts), and an object expr_complete saved in memory.



####################################
# Section 4: Transform, filter, and visualize distributions
####################################

# Concepts: arithmetic on vectors/matrices, 
# apply(), quantile(), hist(), boxplot(), par(mfrow=), log2() transform.

# Tasks:
# 1 - Log transform the expression (if it is not already on log scale)
# 2 - Compute per‑sample medians (use) apply())
# 3 - Plot a histogram of one sample’s expression values and a multi‑sample boxplot of the first 10 samples.
# 4 - Filter low‑variance genes: keep genes with variance above the 50th percentile of row variances.


# Deliverables:
# A expr_filt matrix, a histogram, and a boxplot (base graphics).


####################################
# Section 5: Reshaping, aggregation, and joins (base R)
####################################

# Concepts:
# merge(), aggregate(), tapply(), by(), rowMeans(), colMeans(), reshape() (wide↔long), stack()/unstack().

# Tasks:
# 1 - Per‑sample QC metrics: compute columns means, and per‑sample SD;
# bind these as new columns into annotation using merge() on sample IDs.
# 2 - Group‑wise summaries: using the group factor, compute per‑group mean
# and SDs of the per‑sample medians with tapply() or aggregate().


# Deliverables:
# An extended annotation2 data.frame with QC columns.
# A by_median or aggregate result summarizing medians by group.

####################################
# Section 6: Base graphics
####################################

#Concepts:
# par(), layout(), plot(), points(), lines(), abline(), boxplot(), hist(),
# density(), stripchart(), barplot(), legend(), title(), saving figures with png()/pdf().

# Tasks:
# 1 - Panel A (distribution): pick one sample vector and draw hist() with an overlaid lines(density(x))
# 2 - Panel B (boxplot): boxplot the first 10 samples of expr_filt.
# 3 - Panel C (sample–sample scatter): scatter two samples (e.g., sample 1 vs sample 2) with abline(0,1, lty=2); add mtext() to annotate.
# 4 - Panel D (group sizes): barplot of sample counts per group using table(annotation2$group); add a legend if needed.
# 5 - set a Multi‑panel layout and replot all panels: set a 2×2 grid with par(mfrow = c(2,2)).
# 6 - Export: wrap the plotting code with png().

####################################
# Section 7: Functions
####################################

# Concepts: function(), stopifnot(), isTRUE(), anyNA(),
# apply()/lapply()/sapply()/tapply(), quantile(), IQR(), scale(),
# set.seed(), sample(), saveRDS()/readRDS(), sessionInfo().

# Tasks:
# 1 - Row scaling utility:
#     row_z(expr): center and scale each gene (row) to mean 0, sd 1 using apply() + scale();
#     return a matrix of the same shape. Compare the first 3 rows of expr_qc vs row_z(expr_qc).
# 2 - write reusable QC utilities:
#  a- qc_stats(expr): given a numeric matrix with genes in rows, samples in columns,
#     return a per‑sample data.frame with mean, median, sd, mad, and %low where %low 
#     is the fraction of values below the 5th percentile of that sample.
#  b - flag_outliers(x, z) using z-scoring:
#      for a numeric vector (e.g., per‑sample medians)
#      return a logical vector of outliers using either IQR rule or |z|>3.
#  c - Apply to our data:
#      Compute qc_tbl <- qc_stats(expr_filt) and merge into annotation2 by sample.
#      Compute med_out <- flag_outliers(qc_tbl$median, z) 
#      and create expr_qc <- expr_filt[, !med_out]
# 3 - Group summaries with apply:
#     Using tapply() (or by()), compute n, mean, and sd of sample medians by group from the updated annotation;
# 4 - Print sessionInfo() at the end of your script.



