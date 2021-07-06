# 패키지 
library() # 설치된 패키지 보기 
search() # 메모리에 로드된 패키지 보기 
install.packages("dplyr") # 새로운 패키지 설치하기 
library(dplyr) # 메모리에 로드하기
remove.packages("dplyr") # 디스크에서 패키지 지우기
detach(package:dplyr) # 메모리에서 언로드하기 
help(package=dplyr) # 패키지 도움말 이용하기 
library(help=dplyr)

data() # dataset 
data(package="dplyr") # 패키지 내의 dataset
data(iris) # 데이터 로드
summary(iris)
help(iris)

# 기본 데이터 분석 
var(iris$Sepal.Length) # 분산
hist(iris$Sepal.Length) # histogram
plot(iris$Sepal.Length,iris$Sepal.Width) # scatter plot
table(iris$Species)

# 회귀분석
example(lm)
