A = matrix(
  data = matrixa <- c(0.589, 0.202, 0.033, 0.869), 
  nrow = 2
)

# Load matrixcalc library
#install.packages("matrixcalc")
library("matrixcalc")

# PLU decomposition
lu_decomp = lu.decomposition(A)

# View results
lu_decomp$L %*% lu_decomp$U

# eigen decomposition in R
eA <- eigen(A)
eA

eA$vectors %*% diag(eA$values) %*% solve(eA$vectors)

y <- c(2,3)
yA <- A %*% y
yeA <- A %*%  eA$vectors[,1]

plot(NULL, xlim=c(-6,6), ylim=c(-6,6), xlab="X", ylab="Y")
arrows(x0=0, y0=0, x1=y[1], y1=y[2], col="red", lty = 2)
arrows(x0=0, y0=0, x1=yA[1], y1=yA[2], col="red")
arrows(x0=0, y0=0, x1=eA$vectors[1,1], y1=eA$vectors[2,1], col="green", lty=2)
arrows(x0=0, y0=0, x1=yeA[1], y1=yeA[2], col="green")


# principal component analysis
rm(list=ls())
library(tidyr)
library(ggplot2)

mnorm <- function(x, y, m, s){
  mres <- matrix(nrow=x, ncol=y)
  for(i in 1:length(mres[,1])){
    mres[i,] <- rnorm(y, mean = m, sd = s)
  }
  return(mres)
}

d1 <- as.data.frame(mnorm(100, 10, runif(10, min=7, max=10), runif(10, min=1, max=2)))
d2 <- as.data.frame(mnorm(100, 10, runif(10, min=1, max=4), runif(10, min=1, max=2)))
d <- cbind(d1, d2)
d3 <- as.data.frame(mnorm(1000, 20, runif(20, min=1, max=4), runif(20, min=1, max=2)))
colnames(d3) <- colnames(d)
d <- rbind(d, d3)
colnames(d) <- sapply(seq(1, length(d[1,]), by=1), function(x){paste("sample", x, sep="")})
row.names(d) <- sapply(seq(1, length(d[,1]), by=1), function(x){paste("transcript", x, sep="")})

# PCA
data.scaled <- scale(d, center = TRUE, scale = TRUE)
e.scaled = eigen(cov(data.scaled))

# variances
e.scaled$values
# proportion variances
e.scaled$values/sum(e.scaled$values)
# cumulative
cumsum(e.scaled$values/sum(e.scaled$values))

data.pc  = as.matrix(data.scaled) %*% e.scaled$vectors 
head(data.pc)

require(stats)
pc <- prcomp(x = d, center = TRUE, scale. = TRUE)
head(pc$x)
summary(pc)

par(mfrow=c(1, 3))

plot(e.scaled$values, xlab = "Index", ylab = "Lambda", 
     main = "Scree plot", 
     cex.lab = 1.2, cex.axis = 1.2, cex.main = 1.8)

screeplot(x= pc, type = "line", main = "Scree plot", cex.main = 1.8)

plot(pc, main = "Variance bar plot", cex.main = 1.8)

# correlation with original variables
mean.dev <- scale(d, center = TRUE, scale = FALSE)
head(mean.dev)

mean.dev.pc <- mean.dev %*% e.scaled$vectors

r.cor <- cor(cbind(mean.dev.pc, d))
head(r.cor)
r1 = r.cor[21:40, 1:2]

par(pty = "s")

ucircle = cbind(cos((0:360)/180*pi), sin((0:360)/180*pi))

plot(ucircle, 
     type= "l", lty= "solid", col = "blue", lwd = 2, 
     xlab = "First PC", ylab = "Second PC", main = "Unit variance circle")
abline(h = 0.0, v = 0.0, lty = 2)

text(x = r1, 
     label = colnames(r.cor)[21:41], 
     cex = 1.2)

# plotting
par(pty = "s")
plot(x = data.pc[, 1], y = data.pc[, 2], 
     xlab = "PC1", ylab = "PC2", main = "First vs. Second PC",
     cex.lab = 1.2, cex.axis = 1.2)

require(stats)
biplot(pc, choices = 1:2)


# validation/correlation

f <- as.factor(c(rep("cond1", 10), rep("cond2", 10)))
wilcox.test(e.scaled$vectors[,1] ~ f) 
wilcox.test(e.scaled$vectors[,2] ~ f) 


f2 <- seq(1, 20, by=1)
cor.test(e.scaled$vectors[,1], f2)
cor.test(e.scaled$vectors[,2], f2)
cor.test(e.scaled$vectors[,3], f2)




# SVD
svdData <- t(data.scaled) %*% data.scaled
s <- svd(svdData)

# variances
s$d
# proportion variances
s$d/sum(s$d)
# cumulative
cumsum(s$d/sum(s$d))
par(pty = "s")
plot(x = s$v[, 1], y = s$v[, 2], 
     xlab = "PC1", ylab = "PC2", main = "First vs. Second PC",
     cex.lab = 1.2, cex.axis = 1.2)
dev.off()




# MDS

library(magrittr)
library(dplyr)
library(ggpubr)


# Cmpute MDS
mds <- d %>%
  dist() %>%          
  cmdscale()
#%>%
#  as_tibble()
colnames(mds) <- c("Dim.1", "Dim.2")

# Plot MDS
ggplot(as.data.frame(mds), aes(x=Dim.1, y=Dim.2)) + 
  geom_point()

# transposed
td <- as.data.frame(t(d))

tmds <- td %>%
  dist() %>%          
  cmdscale()

#%>%
#  as_tibble()
colnames(tmds) <- c("Dim.1", "Dim.2")

# Plot MDS
ggplot(as.data.frame(tmds), aes(x=Dim.1, y=Dim.2)) +
  geom_point() +
  geom_text(
    label=rownames(tmds), 
    nudge_x = 0.1, nudge_y = 0.1, 
    check_overlap = T
  )


