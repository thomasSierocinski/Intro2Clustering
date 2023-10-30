# TUTORIAL 1


########################################
# section 1: packages installation, getting started
#########################################


# 1.1 install all required packages
# from CRAN repos
install.packages(c("parallel", "matrixcalc", "Hmisc", "corrplot", "tidyr", "ggplot2", "RColorBrewer", "readxls"))


# 1.2 from Bioconductor repo
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("GEOquery")


# 1.3 getting started
# clean environment
rm(list=ls())

# After creating workspace folder
# check current working directory
getwd()
# set it to desired location
pathToDir <- ""
setwd(pathToDir)

####################################
# Section 2: Variables and Data Types
####################################

# 2.1 Variables and assignments
# You can create variables in R using the assignment operator <-

# Numeric variable
age <- 30

# Character variable
name <- "John"

# Logical variable
is_student <- TRUE

# Print the variables
cat("Age:", age, "\n")
cat("Name:", name, "\n")
paste(name, age, sep=": ")
cat("Is student:", is_student, "\n\n")


# 2.2 Data types

# Check the data type of a variable
class(age)          # Numeric
class(name)         # Character
class(is_student)   # Logical


# 2.3 Vectors
# Vectors are one-dimensional arrays that can hold multiple values of the same data type.

# Numeric vector
grades <- c(90, 85, 78, 92, 88)
cat("Grades:", grades, "\n")

# Character vector
colors <- c("red", "blue", "green", "yellow")
cat("Colors:", colors, "\n")

# Logical vector
is_passed <- c(TRUE, FALSE, TRUE, TRUE, TRUE)
cat("Passed:", is_passed, "\n\n")

# 2.4 Missing values
# R has two special values for missing data: NA and NULL.

# NA represents missing or undefined values
missing_data <- c(1, 2, NA, 4, 5)
cat("Missing data:", missing_data, "\n")
is.na(missing_data)

# NULL is used to indicate an empty object
empty_vector <- NULL
cat("Empty vector:", empty_vector, "\n")
is.na(empty_vector)
is.null(empty_vector)



##############################
# Section 3: Data Structures
##############################

# 3.1 Lists
# Lists can hold elements of different data types.

# Creating a list
my_list <- list(
  name = "Alice",
  age = 28,
  grades = c(95, 88, 92),
  is_student = TRUE
)

# Accessing elements in a list
cat("Name:", my_list$name, "\n")
cat("Name:", my_list[[1]], "\n")
cat("Age:", my_list$age, "\n")
cat("Age:", my_list[[2]], "\n")
cat("Grades:", my_list$grades, "\n")
cat("Is student:", my_list$is_student, "\n\n")

# 3.2 Matrices
# Matrices are two-dimensional arrays with elements of the same data type.

# Creating a matrix
matrix_data <- matrix(1:9, nrow = 3, ncol = 3)
cat("Matrix Data:\n")
print(matrix_data)
cat("\n")

# Accessing elements in a matrix
cat("row 2:", matrix_data[2,], "\n\n")
cat("column 3:", matrix_data[, 3], "\n\n")
cat("Element at row 2, column 3:", matrix_data[2, 3], "\n\n")


# 3.3 Data Frames
# Data frames are used to store tabular data.

# Creating a data frame
student_data <- data.frame(
  Name = c("Bob", "Charlie", "David"),
  Age = c(22, 25, 28),
  Grade = c(88, 95, 91)
)

# Printing the data frame
cat("Student Data:\n")
print(student_data)
cat("\n")

# Accessing columns in a data frame
cat("Student Names:", student_data$Name, "\n")
cat("Student Names:", student_data[,1], "\n")
cat("Student Ages:", student_data$Age, "\n\n")
cat("Student Ages:", student_data[,2], "\n")

# 3.4 Factors
# Factors are used to represent categorical data.

# Creating a factor
gender <- factor(c("Male", "Female", "Male", "Male", "Female"))
cat("Gender Factor:\n")
print(gender)
cat("Gender levels:\n")
print(levels(gender))
# access elements just like for vectors
cat("first element:\n")
print(gender[1])


####################################
# Section 4: Control Structures
####################################

# 4.1 If statements
# If statements are used for conditional execution.

# Example 1: Basic if statement
x <- 10

if (x > 5) {
  cat("x is greater than 5.\n")
} else {
  cat("x is not greater than 5.\n")
}

# Example 2: if-else if-else statement
y <- 3

if (y > 5) {
  cat("y is greater than 5.\n")
} else if (y == 5) {
  cat("y is equal to 5.\n")
} else {
  cat("y is less than 5.\n")
}

# 4.2 For loops
# For loops are used for repetitive tasks.

# Example: Loop through a numeric vector
numbers <- c(1, 2, 3, 4, 5)

cat("Numbers:")
for (num in numbers) {
  cat(" ", num)
}
cat("\n")

# 4.3 While loops
# While loops continue execution as long as a condition is TRUE.

# Example: Count from 1 to 5 using a while loop
count <- 1

cat("Count:")
while (count <= 5) {
  cat(" ", count)
  count <- count + 1
}
cat("\n")

# 4.4 Functions
# Functions are blocks of code that can be reused.

# Example: Creating a simple function
square <- function(x) {
  return(x^2)
}

result <- square(4)
cat("Square of 4:", result, "\n")



#############################
# write bubble sort function
#############################





###########################################
# Section 5: Data Manipulation with Base R
###########################################
# 5.1 Subsetting data
# Subsetting allows you to extract specific elements or parts of a data object.

# Example: Subsetting a numeric vector
numbers <- 1:10
subset1 <- numbers[3:7]
cat("Subset 1:", subset1, "\n")

subset2 <- numbers[numbers %% 2 == 0]
cat("Subset 2 (even numbers):", subset2, "\n\n")

# 5.2 Filtering data
# You can filter data based on specific conditions.

# Example: Filter a data frame
students <- data.frame(
  Name = c("Alice", "Bob", "Charlie", "David"),
  Age = c(22, 25, 28, 22),
  Grade = c(88, 95, 91, 89)
)

filtered_students <- students[students$Age > 23, ]
cat("Filtered Students:\n")
print(filtered_students)
cat("\n")

filtered_students <- students[students$Age %in% 23:26, ]
cat("Filtered Students:\n")
print(filtered_students)
cat("\n")


# 5.3 Sorting data
# Sorting data helps in organizing it in a specific order.

# Example: Sort a vector in ascending order
unsorted <- c(3, 1, 4, 1, 5, 9, 2, 6, 5, 3)
sorted <- sort(unsorted)
cat("Sorted Vector (Ascending):", sorted, "\n")


# Example: Sort a data frame by a specific column
sorted_students <- students[order(students$Grade), ]
cat("Students Sorted by Grade:\n")
print(sorted_students)
cat("\n")

# 5.4 Merging and combining data
# You can combine data from different sources.

# Example: Merging two data frames
students1 <- data.frame(
  ID = c(1, 2, 3),
  Name = c("Alice", "Bob", "Charlie")
)

students2 <- data.frame(
  ID = c(2, 3, 4),
  Grade = c(88, 95, 91)
)

# concatenate
# by rows
studentz <- rbind(students1, students2)
# by columns
studentz <- cbind(students1, students2)

merged_students <- merge(students1, students2, by = "ID", all = TRUE)
cat("Merged Students:\n")
print(merged_students)
cat("\n")

# Example: Combining vectors
vec1 <- c(1, 2, 3)
vec2 <- c(4, 5, 6)
combined_vec <- c(vec1, vec2)
cat("Combined Vector:", combined_vec, "\n\n")

# 5.5 Aggregating data
# Aggregating data involves summarizing it.

# Example: Calculate mean and sum of a numeric vector
grades <- c(88, 95, 91, 89, 78, 92)
mean_grade <- mean(grades)
sum_grades <- sum(grades)
cat("Mean Grade:", mean_grade, "\n")
cat("Sum of Grades:", sum_grades, "\n")

################################
# Section 6: Data Visualization
################################


# 6.1 Introduction to base plotting
# R offers a wide range of functions for creating various types of plots.

# 6.2 Creating scatter plots, bar plots, and histograms

# Scatter Plot
x <- c(1, 2, 3, 4, 5)
y <- c(3, 4, 1, 7, 2)
plot(x, y, main = "Scatter Plot", xlab = "X-Axis", ylab = "Y-Axis")

# Bar Plot
categories <- c("A", "B", "C", "D")
values <- c(12, 8, 15, 10)
barplot(values, names.arg = categories, main = "Bar Plot", xlab = "Categories", ylab = "Values")

# Histogram
data <- c(2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5)
hist(data, main = "Histogram", xlab = "Values", ylab = "Frequency")

# 6.3 Customizing plots
# You can customize plot appearance using various options.

# Example: Customize a scatter plot
plot(x, y, main = "Customized Scatter Plot", xlab = "X-Axis", ylab = "Y-Axis", pch = 19, col = "blue")

# Example: Customize a bar plot
barplot(values, names.arg = categories, main = "Customized Bar Plot", xlab = "Categories", ylab = "Values", col = "green")

# Example: Customize a histogram
hist(data, main = "Customized Histogram", xlab = "Values", ylab = "Frequency", col = "red")

# 6.4 Exporting plots
# You can save plots to files.

# Save the scatter plot as a PNG image
png("scatter_plot.png")
plot(x, y, main = "Scatter Plot", xlab = "X-Axis", ylab = "Y-Axis")
dev.off()

# Save the bar plot as a PDF
pdf("bar_plot.pdf")
barplot(values, names.arg = categories, main = "Bar Plot", xlab = "Categories", ylab = "Values")
dev.off()

# Save the histogram as a JPEG
jpeg("histogram.jpg")
hist(data, main = "Histogram", xlab = "Values", ylab = "Frequency")
dev.off()

#########################Plotting ressource
# https://r-graph-gallery.com/



########################################
# Section 7: Data Import and Export
########################################

# 7.1 Exporting data to CSV and other formats

student_data <- data.frame(
  Name = c("Bob", "Charlie", "David"),
  Age = c(22, 25, 28),
  Grade = c(88, 95, 91)
)

# Export data to a CSV file
write.csv(student_data, file = "exported_data.csv", row.names = FALSE)

# Export data to an Excel file (requires the 'writexl' package)
# Install the package if not already installed: install.packages("writexl")
library(writexl)
write_xlsx(student_data, path = "exported_data.xlsx")

# Export data to a text file
write.table(student_data, file = "exported_data.txt", sep = "\t", row.names = FALSE)

# Export data to R's binary format
saveRDS(student_data, file = "exported_data.rds")

# Export data to an R script
dump("student_data", file = "exported_data.R")

# 7.2 Importing data from CSV and Excel

# Import data from a CSV file
csv_data <- read.csv("exported_data.csv")

# Import data from an Excel file (requires the 'readxl' package)
# Install the package if not already installed: install.packages("readxl")
library(readxl)
excel_data <- read_excel("exported_data.xlsx")

# Display the imported data
cat("Data from CSV file:\n")
print(csv_data)
cat("\nData from Excel file:\n")
print(excel_data)

# 7.3 Data cleaning and preprocessing

# Remove missing values (NA) from a data frame
cleaned_data <- na.omit(csv_data)

cat("Cleaned Data:\n")
print(cleaned_data)

###################################################
# Section 8: Functions and Functional Programming
###################################################

# 8.1 Writing custom functions
# You can create your own functions in R.

# Example: Define a function to calculate the square of a number
square <- function(x) {
  return(x^2)
}

# Use the function
result <- square(5)
cat("Square of 5:", result, "\n")

# Example: Define a function to find the sum of two numbers
add <- function(a, b) {
  return(a + b)
}

# Use the function
sum_result <- add(3, 7)
cat("Sum of 3 and 7:", sum_result, "\n\n")

# 8.2 Function arguments and return values
# Functions can have arguments and return values.

# Example: Function with default argument
greet <- function(name = "Guest") {
show(pData(phenoData(gse2553[[1]]))[1:5,c(1,6,8)])  return(paste("Hello,", name, "!"))
}

greeting1 <- greet()
greeting2 <- greet("Alice")
cat(greeting1, "\n")
cat(greeting2, "\n\n")

# 8.3 Functional programming (apply, lapply, sapply)
# R provides functions for functional programming.

# Example: Using lapply to apply a function to a list
numbers <- list(1:3, 4:6, 7:9)
squared_numbers <- lapply(numbers, function(x) x^2)
cat("List of Squared Numbers:")
print(squared_numbers)

# Example: Using sapply to simplify the result
squared_numbers_simplified <- sapply(numbers, function(x) x^2)
cat("Simplified Squared Numbers:")
print(squared_numbers_simplified)

# Example: Using apply on matrices
matrix_data <- matrix(1:9, nrow = 3, ncol = 3)
row_sums <- apply(matrix_data, 1, sum)
cat("Row Sums:")
print(row_sums)

column_sums <- apply(matrix_data, 2, sum)
cat("Column Sums:")
print(column_sums)

#################################################
# Section 9: Basic Statistics and Data Analysis
#################################################


# 9.1 Descriptive statistics
# You can calculate common descriptive statistics in R.

# Example: Calculate mean, median, and standard deviation of a numeric vector
grades <- c(88, 95, 91, 89, 78, 92)

mean_grade <- mean(grades)
median_grade <- median(grades)
sd_grade <- sd(grades)

cat("Mean Grade:", mean_grade, "\n")
cat("Median Grade:", median_grade, "\n")
cat("Standard Deviation of Grades:", sd_grade, "\n\n")

# 9.2 Hypothesis testing
# R provides functions for hypothesis testing.

# Example: Perform a t-test to compare two sets of data
set1 <- c(12, 15, 14, 17, 20)
set2 <- c(18, 21, 19, 23, 24)

t_test_result <- t.test(set1, set2)
cat("T-test Result:\n")
print(t_test_result)
cat("\n")

# 9.3 Linear regression
# You can perform linear regression to model relationships between variables.

# Example: Linear regression model
x <- c(1, 2, 3, 4, 5)
y <- c(3, 4, 2, 7, 5)

# Fit a linear regression model
linear_model <- lm(y ~ x)

# Summary of the model
cat("Linear Regression Model Summary:\n")
print(summary(linear_model))
cat("\n")

# 9.4 Exploratory data analysis (EDA)
# EDA involves visualizing and understanding the data.

# Example: Box plot for visualizing data distribution
data <- c(45, 50, 52, 56, 58, 60, 62, 66, 70, 75, 80)

boxplot(data, main = "Box Plot", ylab = "Values")

# Example: Scatter plot for examining relationships
x <- c(2, 4, 6, 8, 10)
y <- c(3, 7, 5, 9, 12)

plot(x, y, main = "Scatter Plot", xlab = "X", ylab = "Y")

# Example: Histogram for data distribution
grades <- c(78, 84, 92, 88, 76, 85, 91, 89, 83, 80)

hist(grades, main = "Histogram of Grades", xlab = "Grades", ylab = "Frequency")




####################################
# Microarrays
####################################

# explain microarrays principles

###############################
# GEO datasets
###############################
rm(list=ls())


library(GEOquery)
GSEID <- 'GSE77952'
mygse <- getGEO(GSEID,GSEMatrix=TRUE)[[1]]
annotation <- pData(phenoData(mygse))
expressionLevels <- exprs(mygse)
write.table(annotation, "annotation.txt", col.names = TRUE, row.names = TRUE, sep="\t")
write.table(expressionLevels, "expression.txt", col.names = TRUE, row.names = TRUE, sep="\t")

