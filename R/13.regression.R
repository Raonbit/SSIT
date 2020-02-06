library(caret)
data("faithful")

summary(faithful);head(faithful)

split = createDataPartition(y=faithful$eruptions, p=0.7, list=F)
trainData = faithful[split,]
testData = faithful[-split,]
dim(trainData);dim(testData)

model = lm(eruptions~waiting, data=trainData)
summary(model)


predict(model, testData)
coef(model)[1] + coef(model)[2] * testData[1,2]

(trainDataRMSE = sqrt(sum((model$fitted-trainData$eruptions))^2))
(testDataRMSE = sqrt(sum((predict(model,testData)-testData$eruptions))^2))

library(ISLR)
data(Wage)

summary(Wage);head(Wage)

split = createDataPartition(y=Wage$wage, p=0.7, list=F)
trainData = Wage[split,]
testData = Wage[-split,]
dim(trainData);dim(testData)

model = train(wage~ age+jobclass+education, mothod="lm", data=trainData)
#model = train(wage~ ., mothod="lm", data=trainData)
finalModel = model$finalModel

library(ggplot2)

pred = predict(model, testData)
qplot(wage, pred, colour=year, data=testData)



