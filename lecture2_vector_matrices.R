# vectors

# inititialize

v <- c(2,3,4)
class(v)

# various ways to generate data
v <- 2:4
v

v <- seq(2, 4, by=1)
v

v <- rep(v, times=3)
v

v <- rep(v, each=3)
v

# generating data distribution
u <- runif(100, min=1, max=10)
n <- rnorm(100)
r <- rpois(100, lambda=1)
sample(10, size=100, replace=TRUE)
sample(u, size=10)

#plotting distributions
hist(u)
hist(n)
hist(r)

plot(density(u), ylim=c(0, max(density(r)$y)), main="data density", xlab="data", ylab="density")
lines(density(n), col="red")
lines(density(r), col="blue")
legend(11, 0.7, legend=c("u", "n", "r"),  fill=c("black", "red", "blue"))


# exporting figure
dev.copy(png, "dataDensity1.png")
dev.off()

png("dataDensity2.png")
plot(density(u), ylim=c(0, max(density(r)$y)), main="data density", xlab="data", ylab="density")
lines(density(n), col="red")
lines(density(r), col="blue")
legend(11, 0.7, legend=c("u", "n", "r"),  fill=c("black", "red", "blue"))
dev.off()

# testing equality
a <- 1
b <- 1
c <- 2
a==b
a==c

v1 <- c(2,3,4)
v2 <- c(2,3,4)
v3 <- c(2,3,5)
v1==v2
v1==v3
which(v1==v3)
which(v1!=v3)
all(v1==v2)
all(v1==v3)

# vector opposite
v1 <- c(2,3)
v2 <- -v1
plot(NULL, xlim=c(-5,5), ylim=c(-5,5), xlab="X", ylab="Y")
arrows(x0=0, y0=0, x1=v1[1], y1=v1[2], col="red")
arrows(x0=0, y0=0, x1=v2[1], y1=v2[2], col="blue")
# parallel vector
v3 <- v1+1
arrows(x0=1, y0=1, x1=v3[1], y1=v3[2], col="green")
v3 <- v1 + c(0,1)
arrows(x0=0, y0=1, x1=v3[1], y1=v3[2], col="green")

# vector addition
v1 <- c(2,3)
v2 <- rev(v1)
v3 <- v1+v2
plot(NULL, xlim=c(-5,5), ylim=c(-5,5), xlab="X", ylab="Y")
arrows(x0=0, y0=0, x1=v1[1], y1=v1[2], col="red")
arrows(x0=0, y0=0, x1=v2[1], y1=v2[2], col="green")
arrows(x0=0, y0=0, x1=v3[1], y1=v3[2], col="orange")
arrows(x0=v1[1], y0=v1[2], x1=v3[1], y1=v3[2], col="red", lty=2)
arrows(x0=v2[1], y0=v2[2], x1=v3[1], y1=v3[2], col="green", lty=2)

# vector substraction
v1 <- c(2,3)
v2 <- rev(v1)
v3 <- v1-v2
plot(NULL, xlim=c(-5,5), ylim=c(-5,5), xlab="X", ylab="Y")
arrows(x0=0, y0=0, x1=v1[1], y1=v1[2], col="red")
arrows(x0=0, y0=0, x1=v2[1], y1=v2[2], col="green")
arrows(x0=0, y0=0, x1=v3[1], y1=v3[2], col="orange", lty=2)
arrows(x0=v2[1], y0=v2[2], x1=v1[1], y1=v1[2], col="orange")

# scalar product
v1 <- c(2,3)
v2 <- 2*v1
plot(NULL, xlim=c(-6,6), ylim=c(-6,6), xlab="X", ylab="Y")
arrows(x0=0, y0=0, x1=v1[1], y1=v1[2], col="red")
arrows(x0=0, y0=0, x1=v2[1], y1=v2[2], col="green")


# vector multiplication
# not a cross product
v1 <- c(2,3)
v2 <- c(1,2)
v3 <- v1*v2
plot(NULL, xlim=c(-6,6), ylim=c(-6,6), xlab="X", ylab="Y")
arrows(x0=0, y0=0, x1=v1[1], y1=v1[2], col="red")
arrows(x0=0, y0=0, x1=v2[1], y1=v2[2], col="green")
arrows(x0=0, y0=0, x1=v3[1], y1=v3[2], col="orange")


#ordering vectors


# possible excercise
# test axioms of vector space
# generate 3 random vectors of identical length N





# matrices
# matrix creation
mdat <- matrix(c(1,2,3, 11,12,13), nrow = 2, ncol = 3, byrow = TRUE,
               dimnames = list(c("row1", "row2"),
                               c("C.1", "C.2", "C.3")))
mdat

# dimension
dim(mdat)
length(mdat[1,])
length(mdat[,2])


# appending matrices
mdatApp1 <- cbind(mdat, mdat)
mdatApp2 <- rbind(mdat, mdat)

mdat <- matrix(nrow = 100, ncol = 10)
  # for loop
  for(i in 1:length(mdat[,1])){
    mdat[i,] <- runif(10)
  }  

# functions
munif <- function(x, y){
  print(x)
  print(y)
  mres <- matrix(nrow=x, ncol=y)
  for(i in 1:length(mres[,1])){
    mres[i,] <- runif(10)
  }
  return(mres)
}

mdat <- munif(100, 10)



# apply
mdat2 <- apply(mdat, 1, function(x){x*runif(1)})
#same than
mdat3 <- mdat*runif(100)



# sapply
mdat <- sapply(1:100, function(x){runif(10)})
mdat <- t(mdat)

#lapply
mdat <- lapply(1:100, function(x){runif(10)})
class(mdat)
mdat2 <- do.call(rbind, mdat)



# subset matrix
mdat <- matrix(nrow = 100, ncol = 10)
# for loop
for(i in 1:length(mdat[,1])){
  mdat[i,] <- runif(10)
}

idx<-10
mdat[idx,]
mdat[,idx]
mdat[idx,idx]

mdat[10:20,]
mdat[,1:5]
mdat[10.20,1:5]


# transpose matrix
mdat <- matrix(c(1,2,3, 11,12,13), nrow = 2, ncol = 3, byrow = TRUE,
          dimnames = list(c("row1", "row2"),
                          c("C.1", "C.2", "C.3")))
mdat
t(mdat)

# reorder matrix
colOrder <- c(3,2,1)
rowOrder <- c(2,1)
mdat
mdat[,colOrder]
mdat[rowOrder,]
mdat[rowOrdfer, ColOrder]




# matrix addition
mdat1 <- munif(100, 10)
mdat2 <- munif(100, 10)
mdat1+mdat2
mdat3 <- munif(101, 10)
mdat1 + mdat3


# matrix multiplications
# by scalar
mdat <- matrix(c(1,2,3, 11,12,13), nrow = 2, ncol = 3, byrow = TRUE,
              dimnames = list(c("row1", "row2"),
                              c("C.1", "C.2", "C.3")))
mdat
mdat2 <- 2*mdat

# by vector
rowVec <- c(1,2,3)
colVec <- c(4,5)
mdat*rowVec
mdat*colVec

mdat <- matrix(c(1,2, 11,12), nrow = 2, ncol = 2, byrow = TRUE,
               dimnames = list(c("row1", "row2"),
                               c("C.1", "C.2")))
mdat
rowVec <- c(1,2)
colVec <- c(4,5)
mdat*rowVec
mdat*colVec


# mutliplication
mdat
mdat * mdat


# %*% operator
mdat
mdat %*% mdat


# matrix types
# diagonal matrix
d <- diag(3)
d

# triangular
m2 <- matrix(1:20, 4, 5)
lower.tri(m2)
m2[lower.tri(m2)] <- NA
m2

# symmetric
s<-matrix(1:25,5)
s[lower.tri(s)] <- t(s)[lower.tri(s)]

# inverse
s1 <- solve(s)
print(s1)
