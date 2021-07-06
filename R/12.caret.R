#install.packages("caret", dependencies = c("Depends", "Suggests"))
library(caret)
library(kernlab)
library(ggplot2)
data(spam)
data = spam

## EDA

dim(data)
str(data)
sapply(data, class)
summary(data)

head(data,10)
levels(data$type)

percentage <- prop.table(table(data$type)) * 100
cbind(freq=table(data$type), percentage=percentage)

# visualization 
features <- data[,1:57]
target <- data[,58]

par(mfrow=c(1,4))

for(i in 1:57) {
  boxplot(features[,i], main=names(data)[i])
}

plot(target)

partFeatures = data[,1:4]
featurePlot(x=partFeatures, y=target, plot="ellipse")
featurePlot(x=partFeatures, y=target, plot="box")
scales = list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=partFeatures, y=target, plot="density", scales=scales)

x <- matrix(rnorm(50*5),ncol=5)
y <- factor(rep(c("A", "B"),  25))

featurePlot(x, y, "ellipse")
featurePlot(x, y, "strip", jitter = TRUE)
featurePlot(x, y, "box")
featurePlot(x, y, "pairs")


## data slicing 

sampling = createDataPartition(y=data$type, p=0.75, list=F)
sampling

trainData = data[sampling,]
testData = data[-sampling,]
dim(trainData);dim(testData)

# folding
set.seed(1234)
training = createFolds(y=data$type, k=10, list=T, returnTrain=T)
set.seed(1234)
testing = createFolds(y=data$type, k=10, list=T, returnTrain=F)

sapply(training, length)
sapply(testing, length)
training[[1]][1:10]
testing[[1]][1:10]

# resampling
set.seed(1234)
resampling = createResample(y=data$type, times=10, list=T)
sapply(resampling, length)
resampling[[1]][1:10]

# time slices
set.seed(1234)
tme = 1:1000
timeslicing = createTimeSlices(tme, initialWindow=20, horizon=10)
names(timeslicing)
sapply(timeslicing$train, length)
sapply(timeslicing$test, length)
timeslicing$train[[1]]
timeslicing$test[[1]]


## Training
model = train(type~., data=trainData, method="glm")
args(train.default)

control = trainControl(method = 'repeatedcv',
                        repeats = 5,
                        number = 5,
                        classProbs = T)
model = train(type~., data=trainData, method="glm", 
              trControl = control)
              

## preprocessing
ggplot(trainData, aes(x=capitalAve)) + geom_histogram()
mean(trainData$capitalAve)
sd(trainData$capitalAve)

# standardization
capitalAveS = (trainData$capitalAve - mean(trainData$capitalAve)) / sd (trainData$capitalAve)
mean(capitalAveS)
sd(capitalAveS)

preObj = preProcess(trainData[,-58], method=c("center","scale"))
predict(preObj, trainData[,-58])
capitalAveS = predict(preObj, trainData[,-58])$capitalAve
mean(capitalAveS)
sd(capitalAveS)
par(mfrow=c(1,2))
hist(capitalAveS); qqnorm(capitalAveS)

model = train(type~., data=trainData, method="glm", 
              trControl = control, preProcess=c("center","scale"))

# box-cox transform
preObj = preProcess(trainData[,-58], method=c("BoxCox"))
capitalAveS = predict(preObj, trainData[,-58])$capitalAve
mean(capitalAveS)
sd(capitalAveS)
par(mfrow=c(1,2))
hist(capitalAveS); qqnorm(capitalAveS)

# missing value(Imputing data)
set.seed(1234)
trainData$capAve = trainData$capitalAve
summary(trainData$capAve)
selectNA = rbinom(dim(trainData)[1], size=1, prob=0.05) == 1
trainData$capAve[selectNA] = NA
summary(trainData$capAve)

preObj = preProcess(trainData[,-58], method=c("knnImpute"))
capAve = predict(preObj, trainData[,-58])$capAve
summary(capAve)

## evaluation

modelPredict =  predict(model, testData)
confusionMatrix(modelPredict, testData$type)



# best model 

#results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
#summary(results)
#dotplot(results)