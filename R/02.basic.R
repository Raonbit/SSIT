# operator
1+3
2^3
8/3
(4-2)*3; 12-2*5
sqrt(2)
log(10)
exp(2)
pi
date()
max(1,3,4,7)

# variable assign 
x <-3
x
print(x)
y <- 3; y <- y+2
y
x = 3; y = 5
x

# compare 
x <- 1
y <- 2
if (x > y) c <- 1 else  c<-2
c
x <- 1
y <- 2
if (x == 1 | y== 1) c <- "둘중 하나가 1" else c <- "모두 1이 아님"
c
if (x == 1 & y== 1) c <- "둘중 하나가 1" else c <- "모두 1이 아님"
c

# basic statistics
x <- c(3,4,5,7)
mean(x)
sum(x) 
length(x)
sum(x)/length(x)
min(x)
range(x)
cumsum(x)

# Etc.
ls()
rm(list=ls())
ls()
getwd()
setwd("C:/Users/iwannab1/Downloads"); getwd()

## data structure
# Vector - 같은 type의 데이터 저장
vec <- c(1,2,3,4,5); vec
vec[3]      # 3번째 요소
vec[-3]     # 3번째 요소만 빼고 출력
vec[2:4]     # 2부터 4번째 까지 출력
vec[2]<-6; vec
append(vec,10,after=3)     # 벡터에 새로운 요소 추가
append(vec,11,after=3)
append(vec,12,after=0)
vec
vec2<-append(vec,13,after=3)
vec2

# Matrix - 같은 type의 데이터 저장
mat1 <- matrix(c(1,2,3,4)); mat1
mat2 <- matrix(c(1,2,3,4),nrow=2); mat2     # nrow를 사용해 2행으로 만들기
mat3 <- matrix(c(1,2,3,4),nrow=2,byrow=T); mat3     # 가로로 입력
mat4 <- matrix(c(1,2,3,4,5,6,7,8,9),nrow=3,byrow=T); mat4
mat4 <- rbind(mat4,c(11,12,13)); mat4     # 행추가
mat4 <- cbind(mat4, c(100,200,300)); mat4     # 길이가 다를 경우 에러 발생
mat4 <- cbind(mat4, c(100,200,300,400)); mat4     # 열 추가
mat4 <-mat4[,-4]; mat4     # 열 삭제 

# array : 다차원, 같은 type의 데이터 저장
array1 <- array(c(1:12),dim=c(4,3)); array1
array2 <- array(c(1:12),dim=c(2,2,3)); array2 # 삼차원 배열
array2[1,1,3]    # x:1, y:1, z:3 인 데이터 조회

# list - 다른 type 데이터 저장
list1 <- list(name = 'Yeonjae', address='Seoul',
              tel='010-1234-1234', pay=1000); list1

list1$name
list1$birth <- '1996-04-07'     # 새로운 요소 추가
list1


## DataFrame
# 벡터로 부터 데이터 프레임 생성하기 
no <- c(1,2,3,4)
name <- c ('Apple','Peach','Banana','Grape')
price <- c(500,200,100,50)
qty <- c(5,2,4,7)
sales <-data.frame(NO=no,NAME=name,PRICE=price,QTY=qty); sales

# 행렬로 부터 데이터 프레임 생성하기 
sales2 <- matrix(c(1,'Apple',500,5, 2,'Peach',200,2) ,nrow=2,byrow=T)
df1 <- data.frame(sales2); df1
names(df1) <- c('NO','NAME','PRICE','QTY')    # 라벨명 저장
df1
sales$NAME
subset(sales,price==200)
df1<-data.frame(name=c('apple','banana','cherry'),price=c(300,200,100))
df2<-data.frame(name=c('apple','cherry','berry'),qty=c(10,20,30))
df1
df2
merge(df1,df2)     #공통으로 있는 name 컬럼 데이터 출력
merge(df1,df2,all=T)    #데이터가 없는 것도 모두 나옴

cbind(df1,df2)     #df1과 df2를 합쳐 하나의 데이터 프레임으로 만듦
rbind(df1,df2)
