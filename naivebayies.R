install.packages("e1071")
library(e1071)
class(bayesian)
model <- naiveBayes(as.factor(C)~.,data = bayesian);model
p = predict(model,test[,-4]);p
x<-table(p, bayesian[,4])
test <- data.frame(1,2,2, NA)#test data
sum(diag(x))/sum(x)#正確率 