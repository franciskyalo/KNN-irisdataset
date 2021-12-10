
#---------------------about project----------------------

# in this project we will use KNN algorithm on the IRIS data set
# we will build a model that can predict the the species 


#---------------------- data-------------------------

head(iris)

#------------------ model----------------------------

# splitting data to training and testing set
set.seed(123)

split <- sample(2, nrow(iris), replace = T, prob = c(0.8,0.2))

train <- iris[split==1,]
test <- iris[split==2,]

labels <- train$Species

library(caret)
library(pROC)

# validation method- repeated cross validation
Control=trainControl(method="repeatedcv",
                     number = 5,
                     repeats = 2)

set.seed(1234) 


model <- train(Species ~., 
               data = train,
               tuneGrid=expand.grid(k=1:30),
               method="knn",
               trControl=Control,
               preProc=c("center","scale"))


model 

# optimal model visualization

plot(model)

# variable importance

varImp(model) 

# predicting test data

pred <- predict(model, newdata= test) 

# confusion matrix

confusionMatrix(pred, test$Species)
