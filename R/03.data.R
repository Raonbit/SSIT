# data type
a <- c(1,2,3); typeof(a)
b <- c(1L,2L,3L); typeof(b)
c <- c(1+2i,2,3); typeof(c)
d <- c("1","2","3"); typeof(d)
e <- c(TRUE,FALSE); typeof(e)
f <- c(1+2i,2,'3')
f
typeof(f)

## Vector
c(1,2,3,4,5)
c(1:10)                       # 1에서 10까지
(vec01 <- c(1:10))            # 1에서 10까지 벡터 vec01 만들기
-5:5                          # -5에서 5까지
5:-5                          # 5에서 -5까지
c(1:5,7:10)                   # 1에서 5, 7에서 10까지
c('one','two','three')        # 문자형 벡터만들기
c("'one","two","three")       # 문자형 벡터만들기
c(1,2,'one','two','three')    # 숫자형과 문자형을 합치면
(vec02 <- c(10,20,30,vec01))  # 벡터를 연결하면

seq(1,6)
seq(from=1,to=6)              # seq(from=1,to=6,by=1)   
seq(from=3,to=-3,by=-1)       # 3부터 -3 까지
seq(0.5,4.6)
seq(from=1,to=10,by=2)        # 1,3,5,7,9 만들기
seq(from=1,to=2,by=0.3)       # 1.0 부터 1.9 까지
seq(from=1,to=10,length=4)    # 1부터 10까지 4개의 원소, 1,4,7,10  (10-1)/3 간격
seq(from=1,to=19,length=5)

rep(3,6)
rep(c(1,2),6)
rep(3,times=6)                # 3,3,3,3,3,3   3을 6번 반복하여 만들기
rep(c(1,2),times=6)

vec01 <- c(1:10) ; vec01 # 벡터 v1 을 만들기
class(vec01)          # integer
length(vec01)         # 10
str(vec01)            # 벡터의 구조를 출력
head(vec01)           # 앞 6개 요소를 출력
is.vector(vec01)      # TRUE
mode(vec01)           # "numeric"
is.list(vec01)        # FALSE
vec01_c <- c('one','two','three') # 문자로 구성된 벡터만들기
mode(vec01_c)         # "character"
class(vec01_c)        # "character“ 

# vector 결합
vec01 <- c(1,2,3,4,5) # concatenate
vec100 <- c(100,200,300,400,500)
(vec101 <- c(vec01,vec100))

(vec01 <- c(1,2,3,4,5))
(cvec01 <- c("one","two","three","four","five"))
(cnvec1 <- c(vec01,cvec01))

# 위치 접근 
vec01 <- c(10,20,30,40,50,60,70)
vec01[3]           # 3 번째 요소
vec01[c(3,5)]      # 3 번째 요소

vec01[3:5]         # 3~5 째 요소
vec01[c(3:5)]      # 3~5 째 요소

vec01[-3]          # 3 번째 요소 제외하기
vec01[-c(3,5)]     # 3 번째, 5번째 요소 제외하기
vec01[-(2:3)]      # 2~3 번째 요소 제외하기

vec01 <- c(10,20,30,40,50,60,70)
vec01[3] <- 5;vec01        # 벡터 3번째 요소에 3을 할당
vec01[7] <- 77;vec01  

# 이름 접근
vec01 <- c(10,20,30,40,50,60,70); vec01
names(vec01) <- c("sun","mon","tue","wed","thu","fri","sat")
vec01
vec01["wed"]
vec01[c("tue","thu")]

# vector 연산
vec01 <- c(1,2,3,4,5) 
vec100 <- c(100,200,300,400,500)
vec01+3    
vec01*3    
vec100+vec01  
vec100-vec01  
vec100*vec01  
vec01/vec100  

# 벡터의 차수가 다른 경우
vec01 <- c(1,2,3,4,5,6) 
v200 <- c(100,200,300)
v201 <- vec01+v200 ; v201

# 기초 통계량
vec01 <- c(1:10)       # 벡터 v1 을 만들기
sum(vec01)             # 합계구하기
mean(vec01)            # 평균구하기
vec01-mean(vec01)         # 평균과의 차이구하기
median(vec01)          # 중앙값 구하기
min(vec01)             # 최소값 구하기
max(vec01)             # 최대값 구하기
sd(vec01)              # 표준편차 구하기
var(vec01)             # 분산 구하기
range(vec01)           # 최소값과 최대값 구하기
diff(range(vec01))     # 범위구하기
quantile(vec01)        # 4분위수 구하기
IQR(vec01)             # 4분위수 범위 Q3-Q1
summary(vec01) 

# NA
mean(c(1,2,3,4,5))               # 평균값 3
mean(c(1,2,NA,3,4,5))            # NA Not Available
mean(c(1,2,NA,3,4,5),na.rm=TRUE) # 평균값 3


## DataFrame
id  <- c('A001','A002','A003','A004','A005')
gender <- c('F','F','F','M','M')
wei <- c(58,60,63,68,70)
hei <- c(155,160,165,170,175)
age <- c(23,24,38,43,40)
dataf01 <- data.frame(id,gender,wei,hei,age); dataf01

mat01 <- matrix(7,2,3)
dataf02 <- as.data.frame(mat01) ; dataf02
dataf03 = read.csv("test.csv", quote = "'"); dataf03 

class(dataf03)    # data.frame           #  데이터프레임의 속성 살펴보기
length(dataf03)   # 10
dim(dataf03)
head(dataf03)


## Factor
(vec01 <- c(10,20,20,30,30,20))
fact01 <- factor(vec01); fact01

dataf01
str(dataf01)

dataf01$gender

dataf02 <- data.frame(id,gender,hei,stringsAsFactors=FALSE)
str(dataf02)
dataf02$gender

dataf02$gender <- factor(dataf02$gender)  # gender를 factor 로 지정
str(dataf02)  
dataf02$gender
