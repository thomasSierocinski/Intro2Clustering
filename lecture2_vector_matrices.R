### VECTORS
# vector opposite
v1 <- c(2,3)
-v1
# parallel
v1+1
# addition
v2 <- rev(v1)
v1+v2
# substraction
v1-v2
# scalar product
2*v1
## norm
sqrt((v1[1]^2+v1[2]^2))
norm(c(2,3), type="2")
# dot product
v1 %*% v2
# projection
v2 <- c(3,0)

pv1v2 <- as.vector((v1 %*% v2)/(v2 %*% v2)) * v2
plot(NULL, xlim=c(-6,6), ylim=c(-6,6), xlab="X", ylab="Y")
arrows(x0=0, y0=0, x1=v1[1], y1=v1[2], col="red")
arrows(x0=0, y0=0, x1=v2[1], y1=v2[2], col="green")
arrows(x0=0, y0=0, x1=pv1v2[1], y1=pv1v2[2], col="orange")






#### VECTOR SPACE

u <- c(2,3,4)
v <- c(3,5,7)
w <- c(6,3,1)
# Associativity of vector addition
all(u+(v+w)==(u+v)+w)
# Commutativity of vector addition
all(u+v==v+u)
#Identity element of vector addition
all(v+0==v)
#Inverse elements of vector addition
v+(-v)
#Compatibility of scalar multiplication with field multiplication
a=3
b=8
all(a*(b*v)==(a*b)*v)
#Identity element of scalar multiplication
all(1*v==v)
#Distributivity of scalar multiplication with respect to vector addition
all(a*(u+v)==a*u+a*v)
#Distributivity of scalar multiplication with respect to field addition
all((a+b)*v==a*v+b*v)



### LINEAR MAPS

f <- function(v){
  result <- NA
  if (length(v==2)){
    result <- c(2*v[1], v[2])
  }
  else{
    print("length(v) must equal 2")
  }
  return(result)
}

a <- c(-3,2)
b <- c(2,2)
f(a)
f(b)
all(f(a+b)==(f(a)+f(b)))
all(6*f(a)==f(6*a))

linMap <- function(v, m){
  result <- NA
  res <- m %*% v
  return(res)
}
vlist=vector(mode = "list", length = 10)
vlist[[1]]<-a
# rotation
# 90 degrees counterclockwise
vlist[[2]] <- linMap(a, matrix(c(0,-1,1,0), nrow=2, ncol=2, byrow=TRUE))
# using d degree angle counterclockwise
d=pi / 3
vlist[[3]] <- linMap(a, matrix(c(cos(d),-sin(d),sin(d),cos(d)), nrow=2, ncol=2, byrow=TRUE))
# reflection
# x axis
vlist[[4]] <- linMap(a, matrix(c(1,0,0,-1), nrow=2, ncol=2, byrow=TRUE))
# y axis
vlist[[5]] <- linMap(a, matrix(c(-1,0,0,1), nrow=2, ncol=2, byrow=TRUE))
# line of d degrees with x axis
vlist[[6]] <- linMap(a, matrix(c(cos(2*d),sin(2*d),sin(2*d),-cos(2*d)), nrow=2, ncol=2, byrow=TRUE))
# scaling
s=2
vlist[[7]] <- linMap(a, matrix(c(s,0,0,s), nrow=2, ncol=2, byrow=TRUE))
# horizontal sheer
m=2.5
vlist[[8]] <- linMap(a, matrix(c(1,m,0,1), nrow=2, ncol=2, byrow=TRUE))
# squeeze
k=2
vlist[[9]] <- linMap(a, matrix(c(k,0,0,1/k), nrow=2, ncol=2, byrow=TRUE))
# projection onto the y axis
vlist[[10]] <- linMap(a, matrix(c(0,0,0,1), nrow=2, ncol=2, byrow=TRUE))


library(RColorBrewer)
labls <- c("a", "counterclockwise", "30 degrees", "refl x", "refl y", "refl 30 d", "scaling", "sheer", "squeeze", "projection")
col <- brewer.pal(n = 10, name = "Paired")
plot(NULL, xlim=c(-6,6), ylim=c(-6,6), xlab="X", ylab="Y")
sapply(1:10, function(i,v=vlist,c=col,l=labls){
  arrows(x0=0, y0=0, x1=v[[i]][1], y1=v[[i]][2], col=c[i])
  text(v[[i]][1], v[[i]][2], l[i], col=c[i])
}, vlist, col, labls)
abline(a=0, b=0.3)
dev.off()





### MATRICES


rm(list=ls())
# matrices
# matrix creation
munif <- function(x, y){
  print(x)
  print(y)
  mres <- matrix(nrow=x, ncol=y)
  for(i in 1:x){
    mres[i,] <- runif(y)
  }
  return(mres)
}

mdat <- munif(10, 5)
#Row vector
mdat[1,]
#Column vectors
mdat[,1]
#Submatrix
mdat[1:9, 1:4]
#Addition
mdat[1:2,]
mdat[1:2,]+mdat[1,]
mdat[1:2,]+mdat[1:2,]
#Scalar multiplication
10*mdat[1:2,]
#Transposition
t(mdat[1:2,])
#Matrix multiplication
mdat %*% mdat[2,] 





### LINEAR EQUATION

rm(list=ls())

m <- matrix(c(2,3,5,-1), nrow=2, ncol=2, byrow = TRUE)
o <- c(8,-2)

v <- solve(m, o)
v

m %*% v 




### EIGEN DECOMPOSITION

rm(list=ls())
m <- matrix(c(-5,2,2,4), nrow=2, ncol=2, byrow = TRUE)
m

e <- eigen(m)
e

# verification
# first eigenvector
m %*% e$vectors[,1]
e$values[1]*e$vectors[,1]
# second eigenvector
m %*% e$vectors[,2]
e$values[2]*e$vectors[,2]



### VECTOR SPACE MODEL

rm(list=ls())

m <- matrix(c(4,1,1,3), nrow=2, ncol=2, byrow = TRUE)
row.names(m) <- c("d1", "d2")
colnames(m) <- c("T1", "T2")
m


cosineDist <- function(v1, v2){
  return(sum(v1*v2)/(sqrt(sum(v1^2))*sqrt(sum(v2^2))))
}


query <- c(1,1)

similarity <- apply(m, 1, function(x, q=query){
  cosineDist(x, q)
}, query)

sort(similarity, decreasing = TRUE)

plot(NULL, xlim=c(-6,6), ylim=c(-6,6), xlab="T1", ylab="T2")
arrows(x0=0, y0=0, x1=m[1,1], y1=m[1,2], col="blue")
text(m[1,1], m[1,2], "d1", col="blue")
arrows(x0=0, y0=0, x1=m[2,1], y1=m[2,2], col="green")
text(m[2,1], m[2,2], "d2", col="green")
arrows(x0=0, y0=0, x1=query[1], y1=query[2], col="orange")
text(query[1], query[2], "query", col="orange")




### DISTANCES

rm(list=ls())
# functions
munif <- function(x, y){
  print(x)
  print(y)
  mres <- matrix(nrow=x, ncol=y)
  for(i in 1:length(mres[,1])){
    mres[i,] <- runif(y)
  }
  return(mres)
}

mdat <- munif(10, 5)
#euclidean
dist(mdat, method = "euclidean")
# manhattan
dist(mdat, method = "manhattan")
# cosine
# for loop
dm <- matrix(nrow=length(mdat[,1]), ncol=length(mdat[,1]))


for (i in 1:(length(mdat[,1]))){
  for (j in (i):length(mdat[,1])){
    #print(paste("i=", i , ", j=", j, sep=""))
    dm[i,j] <- cor(mdat[i,], mdat[j,], method = "pearson")
    dm[j,i] <- dm[i,j]
  }
  dm[i,i]<-1
}

# sapply
dms <- sapply(seq(1:length(mdat[,1])), function(i, m=mdat){
  sapply(seq(1:length(mdat[,1])), function(j, mm=m){
    #print(paste("i=", i, ", j=", j, sep=""))
    return(cor(mm[i,], mm[j,], method="pearson"))
  },m)
}, mdat)




### DISTANCE MATRIX

rm(list=ls())
#install.packages(c("Hmisc", "corrplot"))
library("Hmisc")
library("corrplot")

D1 <- "Text mining is to find useful information from text"
D2 <- "Useful information is mined from text"
D3 <- "dark came"
D4 <- "mining in the dark is hard"
D5 <- "a dark text on mining"

H <- tolower(c(D1, D2, D3, D4, D5))
H <- unlist(strsplit(H, " "))
H <- H[!duplicated(H)]
H <- H[-which(H %in% c("a", "is", "to", "the", "in", "from", "on"))]

TD <- matrix(nrow=5, ncol=length(H))
TD[1,] <- c(1,1,1,1,1,0,0,0,0)
TD[2,] <- c(1,0,0,1,1,1,0,0,0)
TD[3,] <- c(0,0,0,0,0,0,1,1,0)
TD[4,] <- c(0,1,0,0,0,0,1,0,1)
TD[5,] <- c(1,1,0,0,0,0,1,0,0)
colnames(TD) <- H
row.names(TD) <- c("D1", "D2", "D3", "D4", "D5")

mydata.rcorr = rcorr(as.matrix(t(TD)))
mydata.coeff = mydata.rcorr$r
mydata.p = mydata.rcorr$P
corrplot(mydata.coeff)
#corrplot(mydata.coeff, p.mat=mydata.p, sig.level = 0.5)


### HOW MUCH RAM DO I NEED?

howMuchRam <- function(l, c){
  return(l*c*8/(10^9))
}

v <- c(1, 10, 100, 1000, 10000, 50000, 100000, 250000, 500000, 750000, 1000000)
res <- matrix(nrow=length(v), ncol=length(v))

for (i in 1:length(v)){
  for (j in 1:length(v)){
    res[i, j] <- howMuchRam(v[i], v[j])
  }
}

row.names(res) <- v
colnames(res) <- v
res


### PARALLELIZATION AND TIMING

rm(list=ls())
library(parallel)

munif <- function(x, y){
  mres <- matrix(nrow=x, ncol=y)
  for(i in 1:length(mres[,1])){
    mres[i,] <- runif(10)
  }
  return(mres)
}
mdat <- munif(1000000, 10)

system.time(test1 <- apply(mdat, 1, mean))

no_cores <- detectCores()
clust <- makeCluster(no_cores)
system.time(test2 <- parApply(clust, mdat, function(x){mean(x)}))
stopCluster(clust)



