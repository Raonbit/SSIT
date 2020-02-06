m <- matrix(data=cbind(rnorm(10, 0), rnorm(10, 2), rnorm(10, 5)), nrow=10, ncol=3)
m

rmean1 = c()
cmean1 = c()

## for loop
for (i in 1:10){
  rmean1[i] = mean(m[i,])
}

rmean1

for (i in 1:3){
  cmean1[i] = mean(m[,i])
}

cmean1


## apply
rmean2 = apply(m, 1, mean);rmean2
cmean2 = apply(m, 2, mean);cmean2

#sapply, lapply : traverse
mean3 = sapply(m, mean);mean3 # vector
mean4 = lapply(m, mean);mean4 # list

mean3[1]
mean4[1]
mean4[[1]]

#user defined function
apply(m, 1, function(x) x*-1)
apply(m, 2, function(x) x*-1)



rmean3 = sapply(1:10, function(x) mean(m[x,]));rmean3
cmean3 = sapply(1:3, function(x) mean(m[,x]));cmean3
cmean4 = sapply(1:3, function(x, y) mean(y[,x]), y=m); cmean4

x = runif(10)
la = lapply(x, sqrt);la
sa = sapply(x, sqrt);sa
va = vapply(x, sqrt);va

is.list(la);is.list(sa)
is.vector(la);is.vector(sa)

va = vapply(x, sqrt, double(1));va
is.list(va);is.vector(va)


# for 

xs = runif(1e5)
res <- c()
system.time(for (x in xs) {
  res <- c(res, sqrt(x))
})

res <- c()
system.time(for (i in seq_along(xs)) {
  res[i] <- sqrt(xs[i])
})


# data frame
df = data.frame(x = 1:10, y = letters[1:10]);df
sapply(df, class)
vapply(df, class, character(1))

df2 = data.frame(x = 1:10, y = Sys.time() + 1:10);df2
sapply(df2, class)
vapply(df2, class, character(1))

# mapply
xs = replicate(5, runif(10), simplify = FALSE);xs
ws = replicate(5, rpois(10, 5) + 1, simplify = FALSE);ws
unlist(lapply(xs, mean))

## two argument
unlist(lapply(seq_along(xs), function(i) {
  weighted.mean(xs[[i]], ws[[i]])
}))
unlist(Map(weighted.mean, xs, ws))
unlist(mapply(weighted.mean, xs, ws))


# rollapply
x = seq(1, 3, length = 1e2)
library(zoo)
rollapply(x, 5, median)


# apply

m <- matrix(data=cbind(rnorm(10, 0), rnorm(10, 2), rnorm(10, 5)), nrow=10, ncol=3)
m

rmean1 = c()
cmean1 = c()

## for loop
for (i in 1:10){
  rmean1[i] = mean(m[i,])
}

rmean1

for (i in 1:3){
  cmean1[i] = mean(m[,i])
}

cmean1


## apply
rmean2 = apply(m, 1, mean);rmean2
cmean2 = apply(m, 2, mean);cmean2

#sapply, lapply : traverse
mean3 = sapply(m, mean);mean3 # vector
mean4 = lapply(m, mean);mean4 # list

mean3[1]
mean4[1]
mean4[[1]]

#user defined function
apply(m, 1, function(x) x*-1)
apply(m, 2, function(x) x*-1)



rmean3 = sapply(1:10, function(x) mean(m[x,]));rmean3
cmean3 = sapply(1:3, function(x) mean(m[,x]));cmean3
cmean4 = sapply(1:3, function(x, y) mean(y[,x]), y=m); cmean4

# group apply
pulse = round(rnorm(22, 70, 10 / 3)) + rep(c(0, 5), c(10, 12)); pulse
group = rep(c("A", "B"), c(10, 12)); group

tapply(pulse, group, length)
tapply(pulse, group, mean)

