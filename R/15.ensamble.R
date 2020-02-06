library(ISLR)
library(ggplot2)
library(caret)

data(Wage);summary(Wage);head(Wage)

split = createDataPartition(y=Wage$wage, p=0.7, list=F)
trainData = Wage[split,]; testData = Wage[-split,]
dim(trainData);dim(testData)

#rpart
fitControl= trainControl("repeatedcv", repeats=100)
rpart_model = train(wage ~ ., method="rpart", trControl=fitControl, data=trainData, verbose=F)
qplot(predict(rpart_model,testData), wage, data=testData)

# boosting 
boost_model = train(wage ~ ., method="gbm", data=trainData, verbose=F)
qplot(predict(boost_model,testData), wage, data=testData)


# randomforest(bagging)
rf_model = train(wage ~ ., method="rf", data=trainData, verbose=F)
qplot(predict(rf_model,testData), wage, data=testData)
