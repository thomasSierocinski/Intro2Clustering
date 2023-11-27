#lecture 3: feature selection an clustering


# NORMALISATION

rm(list=ls())
library(tidyr)

mnorm <- function(x, y, m, s){
  mres <- matrix(nrow=x, ncol=y)
  for(i in 1:length(mres[,1])){
    mres[i,] <- rnorm(y, mean = m, sd = s)
  }
  return(mres)
}

center <- function(x){
  return(as.numeric(x)-mean(as.numeric(x)))
}

zscore<-function(x){
  return((as.numeric(x)-mean(as.numeric(x)))/sd(as.numeric(x)))
}

range01 <- function(x){(x-min(x))/(max(x)-min(x))}

mdat <- as.data.frame(mnorm(1000, 10, seq(1, 10, by=1), seq(1, 10, by=1)))
gdat <- gather(mdat, key="key", value="value")
ggplot(gdat, aes(x=key, y=value))+
  geom_boxplot()

cdat <- as.data.frame(apply(mdat, 2, center))
gdat2 <- gather(cdat, key="key", value="value")
ggplot(gdat2, aes(x=key, y=value))+
  geom_boxplot()

zdat <- as.data.frame(apply(mdat, 2, zscore))
gdat3 <- gather(zdat, key="key", value="value")
ggplot(gdat3, aes(x=key, y=value))+
  geom_boxplot()

rdat <- as.data.frame(apply(mdat, 2, range01))
gdat4 <- gather(rdat, key="key", value="value")
ggplot(gdat4, aes(x=key, y=value))+
  geom_boxplot()



# MISSING VALUES

rm(list=ls())

mnorm <- function(x, y, m, s){
  mres <- matrix(nrow=x, ncol=y)
  for(i in 1:length(mres[,1])){
    mres[i,] <- rnorm(y, mean = m, sd = s)
  }
  return(mres)
}



y <- c(1,2,3,NA)
is.na(y)

x <- c(1,2,NA,3)
mean(x)
mean(x, na.rm=TRUE)


myData <- mnorm(10, 10, 1, 1)
myData[myData<0]<-NA
myData[!complete.cases(myData),]
newData <- na.omit(myData)

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

zscore<-function(x){
  return((as.numeric(x)-mean(as.numeric(x)))/sd(as.numeric(x)))
}

plotDist <- function(d){
  # observation*variable dataframe
  gdat <- gather(d, key="key", value="value")
  ggplot(gdat, aes(x=key, y=value))+
    geom_violin()+
    geom_jitter(position=position_jitter(0.2), alpha=0.08)+
    labs(title="data",x="sample", y = "measure")+
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
}


d1 <- as.data.frame(mnorm(100, 10, runif(10, min=7, max=10), runif(10, min=1, max=2)))
d2 <- as.data.frame(mnorm(100, 10, runif(10, min=1, max=4), runif(10, min=1, max=2)))
d <- cbind(d1, d2)
d3 <- as.data.frame(mnorm(1000, 20, runif(20, min=1, max=4), runif(20, min=1, max=2)))
colnames(d3) <- colnames(d)
d <- rbind(d, d3)
colnames(d) <- sapply(seq(1, length(d[1,]), by=1), function(x){paste("sample", x, sep="")})
row.names(d) <- sapply(seq(1, length(d[,1]), by=1), function(x){paste("transcript", x, sep="")})
plotDist(d)

selection <- sample.int(1000, size=10, replace=FALSE)
plotDist(as.data.frame(t(d[c(1:10, selection),])))

zds <- as.data.frame(apply(d, 2, zscore))
plotDist(zds)

zdt <- as.data.frame(t(apply(d, 1, zscore)))
plotDist(as.data.frame(t(zdt[1:10,])))

condition <- as.factor(c(rep("control", 10), rep("exp", 10)))

tres <- apply(zdt, 1, function(x){t.test(x~condition, paired = TRUE)})
resT <- lapply(tres, function(x){return(x$statistic)})
resP <- lapply(tres, function(x){return(x$p.value)})

plotDist(as.data.frame(t(d[order(as.numeric(resP))[1:10],])))

hist(as.numeric(resP))

padj <- p.adjust(resP, method = "bonferroni")

hist(as.numeric(padj))

length(which(padj<0.05))

plotDist(as.data.frame(t(d[which(padj<0.05)[1:10],])))


####### HIERACHICAL CLUSTERING

distM <- dist(t(zds), method = 'euclidean')
hc <- hclust(distM, method = 'average')
plot(hc)
rect.hclust(hc, k = 4, border = 2:6)

install.packages("clValid")
library("clValid")

cut <- cutree(hc, h = 45)

## retrieve Dunn's index for given matrix and clusters
dunn(distance = distM, cut)


############ K-means
library(factoextra)
# scaling?
k4 <- kmeans(t(d), centers = 4, nstart = 25)
fviz_cluster(k4, data = t(d))


#dunn's index

dunn(clusters=k4$cluster, Data=t(d))

# biclustering/heatmap

heatmap(as.matrix(d[which(padj<0.05)[1:10],]), scale="row")
