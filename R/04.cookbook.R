# install & use package
install.packages("dplyr")
library(dplyr)

?install.packages

old.packages()
new.packages()
update.packages(ask=F)

# vector index
(v = c(1,4,4,3,2,2,3))
v[c(2,3,4)]
v[2:4]
v[c(2,4,3)]
v[v>2]
v[ c(F,T,T,T,F,F,T)]
v[-1]
v[-1:-3]
v[-length(v)]

# data frame index
data = read.table(header=T, text='
                subject sex size
                   1   M    7
                   2   F    6
                   3   F    9
                   4   M   11
                   ')

data
data[1,3]
data[1,"size"]
data[1:2, ]   
data[c(1,2), ]
data[1:2, 2]
data[c(1,2), 2]
data[1:2, c("sex","size")]
data[c(1,2), c(2,3)]
data[data$subject < 3, ]
data[c(TRUE,TRUE,FALSE,FALSE), ]
which(data$subject < 3)
data[which(data$subject < 3),]
data[,which(data$subject < 3)]
data[which(data$subject < 3)]

# subset
subset(v, v<3)
v[v<3]

t = c("small", "small", "large", "medium")
subset(t, t!="small")
t[t!="small"]

v[v<3] <- 9
v
# error
subset(v, v<3) <- 9

subset(data, subject < 3)
data[data$subject < 3, ]

subset(data, subject < 3, select = -subject)
subset(data, subject < 3, select = c(sex,size))

subset(data, subject < 3, select = sex:size)
data[data$subject < 3, c("sex","size")]

subset(data, subject < 3  &  sex=="M")
data[data$subject < 3  &  data$sex=="M", ]

subset(data, subject < 3  |  sex=="M")
data[data$subject < 3  |  data$sex=="M", ]

subset(data, log2(size) > 3 )
data[log2(data$size) > 3, ]

subset(data, subject %in% c(1,3))
data[data$subject %in% c(1,3), ]

# make vector
rep(1,50)
rep(F, 20)
rep(1:5, 4)
rep(1:5, each=4)
rep(factor(LETTERS[1:3]), 5)

# variables information
rm(list=ls())
x = 6
n = 1:4
let = LETTERS[1:4]
df = data.frame(n, let)

ls()
exists("x")
exists("y")
rm(x)
ls()

str(n)
str(df)
length(n)
length(df)
nrow(df)
ncol(df)
dim(df)

# NULL, NA, NaN
x = NULL
x > 5
y = NA
y > 5
z = NaN
z > 5

is.null(x)
is.na(y)
is.nan(z)

is.null(y)
is.na(x)

vy = c(1, 2, 3, NA, 5)
mean(vy)
mean(vy, na.rm=TRUE)

vz = c(1, 2, 3, NaN, 5)
sum(vz)
sum(vz, na.rm=TRUE)

vx = c(1, 2, 3, NULL, 5)
sum(vx)
sum(vx, na.rm=TRUE)

# generate random number
runif(1)
runif(4)
runif(3, min=0, max=100)
floor(runif(3, min=0, max=101))
sample(1:100, 3, replace=TRUE)
sample(1:100, 3, replace=FALSE)

sample(1:2, 3, replace=T)
sample(1:2, 3, replace=F)

rnorm(4)
rnorm(4, mean=50, sd=10)
x = rnorm(400, mean=50, sd=10)
hist(x)

set.seed(423)
runif(3)

set.seed(423)
runif(3)

oldseed = .Random.seed
runif(3)
runif(1)
.Random.seed = oldseed
runif(3)

# rounding number
(x = seq(-2.5, 2.5, by=.5))
round(x) 
ceiling(x)
floor(x)
trunc(x)

(x = c(.001, .07, 1.2, 44.02, 738, 9927)) 

round(x, digits=1)
round(x, digits=-1)
round(x/5)
round(x/5)*5
round(x/.02)*.02

# compare floating number
0.3 == 3*.1
(0.1 + 0.1 + 0.1) - 0.3

all.equal(0.3, 3*.1)
all.equal(0.1 + 0.1 + 0.1, 0.3)
all.equal(0.3 + 0.1 + 0.1, 0.3)

# string
a = "apple"
b = "banana"

paste(a, b)
paste(a, b, sep="")
paste0(a, b)
paste(a, b, sep=", ")

d = c("fig", "grapefruit", "honeydew")

paste(d, collapse=", ")
paste(a, d)
paste(a, d, sep="-", collapse=", ")

a = "string"
sprintf("This is where a %s goes.", a)

x = 8
sprintf("Regular:%d", x)
sprintf("Leading spaces:%4d", x)
sprintf("Leading zeros:%04d", x)

sprintf("%f", pi)         
sprintf("%.3f", pi)       
sprintf("%1.0f", pi)    
sprintf("%5.1f", pi)    
sprintf("%05.1f", pi)   
sprintf("%+f", pi)      
sprintf("% f", pi)      
sprintf("%-10f", pi)    
sprintf("%e", pi)       
sprintf("%E", pi)       
sprintf("%g", pi)       
sprintf("%g",   1e6 * pi) 
sprintf("%.9g", 1e6 * pi) 
sprintf("%G", 1e-6 * pi)  

x = "string"
sprintf("Substitute in multiple strings: %s %s", x, "xxxx")
sprintf("A single percent sign here %%")


grep("a+", "defa", value=F)
grep("a+", "defa", value=T)

grep("^a+", "defa", value=F)
grep("^a+", "defa", value=T)

grep("a+", c("abc", "def", "cba a", "aa"), value=FALSE)
grep("a+", c("abc", "def", "cba a", "aa"), value=TRUE)

grepl("a+", c("abc", "def", "cba a", "aa"))

regexpr("a+", c("abc", "def", "cba a", "aa"))
attr(regexpr("a+", c("abc", "def", "cba a", "aa")),"match.length")

gregexpr("a+", c("abc", "def", "cba a", "aa"))
attr(gregexpr("a+", c("abc", "def", "cba a", "aa")),"match.length")
gregexpr("a+", c("abc", "def", "cba a", "aa"))[[1]]
attr(gregexpr("a+", c("abc", "def", "cba a", "aa"))[[1]],"match.length")
gregexpr("a+", c("abc", "def", "cba a", "aa"))[[3]]
attr(gregexpr("a+", c("abc", "def", "cba a", "aa"))[[3]],"match.length")

x = c("abc", "def", "cba a", "aa")
(m = regexpr("a+", x))
regmatches(x, m)
(m = gregexpr("a+", x))
regmatches(x, m)

# Loading data from file
setwd("D:/kodb/R source/dataSets")
data = read.csv("CPIdata.csv")
head(data)
data = read.csv("CPIdata.csv", header=FALSE)
head(data)
data = read.table("CPIdata.csv", header=TRUE, sep=",", quote="")

data = read.csv(file.choose())
summary(data)

data = read.csv("CPIdata.csv", stringsAsFactors=FALSE)
summary(data)
data$Region <- as.factor(data$Region)
summary(data)
data$Region <- as.character(data$Region)
summary(data)

data = read.csv("http://www.stats.ox.ac.uk/pub/datasets/csb/ch11b.dat", header=F, sep=" ")
head(data)
names(data) = c("First","Second","Third","Forth", "Fifth")
head(data)


# data from keyboard & clipboard
data = read.table(stdin(), header=TRUE)
data
data = read.table('clipboard', header=TRUE)
data

print(data, row.names=FALSE)
write.csv(data, stdout(), row.names=FALSE)
write.csv(data, 'clipboard', row.names=FALSE)
write.csv(data, "data.csv", row.names=FALSE)
write.csv(data, "data.csv", row.names=FALSE, na="")
write.table(data, "data.csv", sep="\t", row.names=FALSE, col.names=FALSE) 

dump("data", "data.Rdmpd")
rm(data)
head(data)
source("data.Rdmpd")
head(data)
dump(c("data", "data1"), "data.Rdmpd")

saveRDS(data, "data.rds")
rm(data)
head(data)
data = readRDS("data.rds")
head(data)

save(data, data1, file="data.RData")
load("data.RData")

# write R output to file instead of console 
sink('analysis-output.txt')

set.seed(12345)
x = rnorm(10,10,1)
y = rnorm(10,11,1)
cat(sprintf("x has %d elements:\n", length(x)))
print(x)
cat("y =", y, "\n")

cat("=============================\n")
cat("T-test between x and y\n")
cat("=============================\n")
t.test(x,y)
sink()


# Append to the file
sink('analysis-output.txt', append=TRUE)
cat("Some more stuff here...\n")
sink()

## manipulating data
# sort
(v = sample(101:110))
sort(v)
sort(v, decreasing=TRUE)

(df = data.frame (id=1:4,
                  weight=c(20,27,24,22),
                  size=c("small", "large", "medium", "large")))
df[ order(df$weight), ]
df[ order(df$weight, decreasing=TRUE), ]

df[ order(df$size, df$weight), ]
df[ order(df$size, -df$weight), ]

df[ do.call(order, as.list(df)), ] 
df[ order(-xtfrm(df$size), df$weight), ]

# randomize order
(v = 11:20)
(v = sample(v))

(data <- data.frame(label=letters[1:5], number=11:15))
(data <- data[sample(1:nrow(data)), ])

# converting type
(n = 10:14)
(c = as.character(n))
(f = as.factor(n))

as.numeric(c)
as.factor(c)
as.numeric(as.character(f))
as.numeric(f)

# duplicate records
set.seed(158)
(x = round(rnorm(20, 10, 5)))
duplicated(x)
x[duplicated(x)]
unique(x[duplicated(x)])
unique(x)
x[!duplicated(x)]

df = read.table(header=TRUE, text='
 label value
                 A     4
                 B     3
                 C     6
                 B     3
                 B     1
                 A     2
                 A     4
                 A     4
                 ')


df
duplicated(df)
df[duplicated(df),]
unique(df[duplicated(df),])
unique(df)
df[!duplicated(df),]

# comparing with NA
(df = data.frame( a=c(TRUE,TRUE,TRUE,FALSE,FALSE,FALSE,NA,NA,NA),
                  b=c(TRUE,FALSE,NA,TRUE,FALSE,NA,TRUE,FALSE,NA)))
df$a == df$b
data.frame(df, isSame = (df$a==df$b))


compareNA = function(v1,v2) {
  same = (v1 == v2) | (is.na(v1) & is.na(v2))
  same[is.na(same)] = FALSE
  return(same)
}

compareNA(df$a, df$b)
data.frame(df, isSame = compareNA(df$a, df$b))

# factor type
(x = factor(c("alpha","beta","gamma","alpha","beta")))
levels(x)
levels(x)[levels(x)=="beta"] = "two"
x
levels(x)[3] = "three"
x
levels(x) = c("one","two","three")
x

(x = factor(c("alpha","beta","gamma","alpha","beta")))
levels(x) <- list(A="alpha", B="beta", C="gamma")
x

(x = factor(c("alpha","beta","gamma","alpha","beta")))
levels(x) <- sub("^alpha$", "one", levels(x))
x
levels(x) <- gsub("a", "X", levels(x))
x

(x = factor(c("alpha","beta","alpha"), levels=c("alpha","beta","gamma")))
(x <- factor(x))

(df = data.frame(
  x = factor(c("alpha","beta","alpha"), levels=c("alpha","beta","gamma")),
  y = c(5,8,2),
  z = factor(c("red","green","green"), levels=c("red","green","blue"))
))

df$x
df$z

(df = droplevels(df))
df$x
df$z

(sizes = factor(c("small", "large", "large", "small", "medium")))
(sizes = factor(sizes, levels = c("small", "medium", "large")))

(sizes = ordered(c("small", "large", "large", "small", "medium")))
(sizes = ordered(sizes, levels = c("small", "medium", "large")))

(sizes = factor(c("small", "large", "large", "small", "medium")))
(sizes = relevel(sizes, "medium"))
(sizes = relevel(sizes, "small"))

(sizes = factor(sizes, levels=rev(levels(sizes))))


# data frame
(d = data.frame(alpha=1:3, beta=4:6, gamma=7:9))
names(d)
names(d)[names(d)=="beta"] = "two"
names(d)
names(d)[3] = "three"
names(d)
names(d) = sub("^alpha$", "one", names(d))
names(d)
names(d) = gsub("t", "X", names(d))
names(d)


data = read.table(header=TRUE, text='
                   id weight
                   1     20
                   2     27
                   3     24
                   ')

data
data$size      = c("small", "large", "medium")
data[["size"]] = c("small", "large", "medium")
data[,"size"]  = c("small", "large", "medium")
data$size      = 0   
data

data$size      = NULL
data[["size"]] = NULL
data[,"size"]  = NULL
data[[3]]      = NULL
data[,3]       = NULL
data           = subset(data, select=-size)
data

data = read.table(header=TRUE, text='
                   id weight   size
                   1     20  small
                   2     27  large
                   3     24 medium
                   ')
data
data[c(1,3,2)]
data[c("size", "id", "weight")]
data[, c(1,3,2)]
data[2]
data[,2]
data[, 2, drop=FALSE]

stories = read.table(header=TRUE, text='
                      storyid  title
                      1       lions
                      2      tigers
                      3       bears
                      ')

data = read.table(header=TRUE, text='
                   subject storyid rating
                   1       1    6.7
                   1       2    4.5
                   1       3    3.7
                   2       2    3.3
                   2       3    4.1
                   2       1    5.2
                   ')

merge(stories, data, "storyid")

stories2 = read.table(header=TRUE, text='
                       id       title
                       1       lions
                       2      tigers
                       3       bears
                       ')

merge(x=stories2, y=data, by.x="id", by.y="storyid")

animals = read.table(header=T, text='
                      size type         name
                      small  cat         lynx
                      big  cat        tiger
                      small  dog    chihuahua
                      big  dog "great dane"
                      ')

observations = read.table(header=T, text='
                           number  size type
                           1   big  cat
                           2 small  dog
                           3 small  dog
                           4   big  dog
                           ')

merge(observations, animals, c("size","type"))


(dfA = data.frame(Subject=c(1,1,2,2), Response=c("X","X","X","X")))
(dfB = data.frame(Subject=c(1,2,3), Response=c("X","Y","X")))
(dfC = data.frame(Subject=c(1,2,3), Response=c("Z","Y","Z")))

dfA$Coder = "A"
dfB$Coder = "B"
dfC$Coder = "C"
dfA;dfB;dfC

(df = rbind(dfA, dfB, dfC))                  
(df = df[,c("Coder", "Subject", "Response")])
dim(df)
(mark = sample(c(TRUE,FALSE),nrow(df), replace=TRUE))
cbind(df, mark=mark)
cbind(df, unmark=!mark)

(newDF = cbind(df, mark=mark))
(dfA = subset(newDF, Coder=="A", select=-Coder))
(dfB = subset(newDF, Coder=="B", select=-Coder))
(dfC = subset(newDF, Coder=="C", select=-Coder))

d = read.csv(header = TRUE, text='
              x,y,value
              a,one,1
              ,,5
              b,two,4
              c,three,10
              ')

d
str(d)
d = d[-2,]
d
str(d)

d1 = droplevels(d)
str(d1)

cases = data.frame(
  Sex=c("M", "M", "F", "F", "F"), 
  Color=c("brown", "blue", "brown", "brown", "brown")
)
cases

ctable = table(cases)
ctable

table(cases$Sex, cases$Color)
table(cases$Sex, cases$Color, dnn=c("Sex","Color"))
table(cases[,c("Sex","Color")])

(countdf = as.data.frame(table(cases)))

xtabs(Freq ~ Sex+Color, data=countdf)

# sequencial data
(v = c("A","A","A", "B","B","B","B", NA,NA, "C","C", "B", "C","C","C"))
(vr = rle(v))
inverse.rle(vr)

w = v
w[is.na(w)] = "ZZZ"
w
(wr = rle(w))
wr$values[ wr$values=="ZZZ" ] = NA
wr

(w2 = inverse.rle(wr))

(f = factor(v))
(f_levels = levels(f))
(fc = as.character(f))
fc[ is.na(fc) ] = "ZZZ"
fc
(fr = rle(fc))
fr$values[ fr$values=="ZZZ" ] = NA
fr
(f2 = inverse.rle(fr))
(f2 = factor(f, levels=f_levels))