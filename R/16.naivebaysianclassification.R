library (e1071)

data (HouseVotes84, package="mlbench") 
summary(HouseVotes84); head(HouseVotes84)

model = naiveBayes(Class ~ ., data = HouseVotes84) 
predict(model, HouseVotes84[1:20,-1]) 

# 확률
predict(model, HouseVotes84[1:20,-1], type = "raw") 

pred = predict(model, HouseVotes84[,-1])
(table = table(pred, HouseVotes84$Class)) 
confusionMatrix(table)

## Laplace smoothing: 
model = naiveBayes(Class ~ ., data = HouseVotes84, laplace = 3)
pred = predict(model, HouseVotes84[,-1]) 
table = table(pred, HouseVotes84$Class) 
confusionMatrix(table)

library(ROCR)
HouseVotes84$republican = factor(1*(HouseVotes84$Class == 'republican'))
pred = predict(model, HouseVotes84[,-1], type = 'raw') 
pred = pred[,2]
plot(performance(prediction(pred, HouseVotes84$republican), 'tpr', 'fpr'))