# Uniform Distribution
runif(1:100)
set.seed(100)
runif(100)

# Normal Distribution
x <- seq(-5,5,by=0.1)
plot(x,dnorm(x))
plot(x,dnorm(x),type='l')
plot(x,dnorm(x),type='l',main='제5강 정규분포 그림그리기',ylab="정규분포 확률",xlab='X 축')

# Normal Distribution Probability
# 평균 u=50 이고 표준편차 σ=10 인 정규분포가 주어졌을 때  
# X가 48와 54 사이에 있을 확률

p2 <- pnorm(54,mean=50,sd=10,lower.tail=T); p2
p1 <- pnorm(48,mean=50,sd=10,lower.tail=T); p1
p2-p1

# T Distribution
par(mfrow=c(1,3))
x <- seq(-3,3,by=0.1)
dt(x,df=5)
plot(x,dt(x,df=2),type='l')
plot(x,dt(x,df=10),type='l')
plot(x,dt(x,df=2),type='l',ylim=(c(0,0.4)))
plot(x,dt(x,df=5),type='l',ylim=(c(0,0.4)))
plot(x,dt(x,df=10),type='l',ylim=(c(0,0.4)))

