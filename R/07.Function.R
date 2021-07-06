f = function() x
f()
x = 15
f()
x = 20
f()

codetools::findGlobals(f)


f = function() {
  i = 10
  x
  cat(paste0(i,",",x))
  
}

codetools::findGlobals(f)


chatty <- function(f) {
  function(x, ...) {
    res <- f(x, ...)
    cat("Processing ", x, "\n", sep = "")
    res
  }
}

codetools::findGlobals(chatty)

f <- function(abcdef, bcde1, bcde2) {
  list(a = abcdef, b1 = bcde1, b2 = bcde2)
}
str(f(1, 2, 3))
str(f(2, 3, abcdef = 1))
str(f(2, 3, a = 1))
str(f(1, 3, b = 1))


mean(1:10, na.rm = TRUE)
args = list(1:10, na.rm = TRUE)
mean(args)
do.call(mean, args)

f <- function(a = 1, b = a * 2) {
  c(a, b)
}

f()
f(3)
f(3,5)

f <- function(x) {
  10
}
f()

f <- function(x) {
  force(x)
  10
}
f()

factory = function (K) {
       function (x) print(K + x)
}
funcs<-list()
for(i in 1:5)
   funcs[[i]]<-factory({cat("evaluating K:",i,"\n"); i})
funcs[[1]](10)

factory = function (K) {
  force(K)
  function (x) print(K + x)
}
funcs<-list()
for(i in 1:5)
  funcs[[i]]<-factory({cat("evaluating K:",i,"\n"); i})
funcs[[1]](10)


second <- function(x, value) {
  x[2] <- value
  x
}
x = 1:10
second(x) = 5L

`second<-`<- function(x, value) {
  x[2] <- value
  x
}
x <- 1:10
second(x) <- 5L;x


in_dir <- function(dir, code) {
  old <- setwd(dir)
  on.exit(setwd(old))
  
  force(code)
}
getwd()
in_dir("c:/", getwd())
getwd()