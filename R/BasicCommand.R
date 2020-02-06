# read file
iris <- read.table("iris.csv", sep=',', header=T)
head(iris)

# ㅋㅓㄹㄹㅓㅁ
iris2 <- read.table("iris.csv", sep=',' , header=T, col.names=c('sl', 'sw', 'pl', 'pw', 'target'))
head(iris2)
                    