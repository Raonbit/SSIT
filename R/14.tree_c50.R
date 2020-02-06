library(C50)
library(caret)

data(iris)
summary(iris);head(iris)

split = createDataPartition(y=iris$Species, p=0.7, list=F)
trainData = iris[split,]
testData = iris[-split,]
dim(trainData);dim(testData)

trainDataX = trainData[,1:4]
trainDataY = trainData[,5]
model = C5.0( trainDataX, trainDataY )
summary( model )

#boosting
model = C5.0( trainDataX, trainDataY, trials=10)
summary( model )
plot(model)

testDataX = testData[,1:4]
testDataY = testData[,5]
pred = predict(model, testDataX, type="class")
sum(pred==testDataY ) / length(pred)


# rpart
rpart_model = train(Species~., method="rpart", data=trainData)
print(rpart_model$finalModel)

library(rattle)
fancyRpartPlot(rpart_model$finalModel)

rpart_pred = predict(rpart_model, testData)
sum(rpart_pred==testDataY ) / length(rpart_pred)
