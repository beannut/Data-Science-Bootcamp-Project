## R
install.packages("mlbench")
library(mlbench)
library(dplyr)
data("BreastCancer")
data("BostonHousing")


## 1. Build Linear Regression
## predict medv (BostonHousing)
df <- BostonHousing

glimpse(df)
View(df)
head(df)

corMat <- df %>%
  select(medv,age,tax,ptratio,rm,dis) %>%
  cor()

## Build Full model
lmBoston_Full <- lm(medv ~ age + tax + ptratio + rm + dis, data = df)
df$predicted <- predict(lmBoston_Full)

head(df)

##Train RMSE
squared_error <- (df$medv - df$predicted)**2
(rmse <- sqrt(mean(squared_error)))

## Split Data
set.seed(3)
n <- nrow(df)
id <- sample(1:n, size=n*0.7)
train_data <- df[id, ]
test_data  <- df[-id, ]

## Train model
model1 <- lm(medv ~ age + tax + ptratio + rm + dis, data = train_data)
p_train <- predict(model1)
error_train <- train_data$medv - p_train
(rmse_train <- sqrt(mean(error_train**2)))

## Test model
p_test <- predict(model1, newdata = test_data)
error_test <- test_data$medv - p_test
(rmse_test <- sqrt(mean(error_test**2)))

## Print Result
cat("RMSE Train:", rmse_train,
    "\nRMSE Test:", rmse_test)


## 2. Build Logistic Regression
## predict class (BreastCancer)
df2 <- BreastCancer
head(df2)
glimpse(df2)
str(df2)

df2$Cl.thickness  <- as.numeric(df2$Cl.thickness)
df2$Cell.shape  <- as.numeric(df2$Cell.shape)
df2$Marg.adhesion  <- as.numeric(df2$Marg.adhesion)
glimpse(df2)
str(df2)


## Split data
set.seed(3)
n <- nrow(df2)
id <- sample(1:n, size=n*0.8)
train_data2 <- df2[id, ]
test_data2 <- df2[-id, ]

## Train model
logit_model <- glm(Class ~ Cl.thickness + Cell.shape + Marg.adhesion,
                   data = train_data2,
                   family = "binomial")

p_train <- predict(logit_model, type="response")
train_data2$pred <- if_else(p_train >= 0.5, "malignant","benign")
mean(train_data2$Class == train_data2$pred)

## test model
p_test <- predict(logit_model, newdata = test_data2, type="response")
test_data2$pred <- if_else(p_test >= 0.5,"malignant","benign")
mean(test_data2$Class == test_data2$pred)

## confusion matrix
conM <- table(train_data2$pred, train_data2$Class, dnn = c("Predicted","Actual"))

## Model Evaluation
cat("Accuracy:", (conM[1,1]+conM[2,2]/sum(conM)))
cat("Precision:", conM[2,2] / conM[2,1] + conM[2,2])
cat("Recall:", conM[2,2] / conM[1,2] + conM[2,2])

cat("F1:",2*((184.3636*178.9412)/(184.3636+178.9412)))


## 3. Build Neural Network
## predict class (BreastCancer)
glimpse(BreastCancer)
View(BreastCancer)
head(BreastCancer)

install.packages("nnet")
install.packages("NeuralNetTools")

library(nnet)
library(NeuralNetTools)

# train test split data
set.seed(6)
num_BreastCancer <- nrow(BreastCancer)
shuffle_BreastCancer <- sample(1:num_BreastCancer, size = num_BreastCancer*0.8)
BreastCancer_train <- BreastCancer[shuffle_BreastCancer, ]
BreastCancer_test <- BreastCancer[-shuffle_BreastCancer, ]

# model training
set.seed(6)
nn_model <- nnet(Class ~ Cl.thickness + Cell.shape + Marg.adhesion, 
                 data = BreastCancer_train,
                 size = 3)

# plot networks
plotnet(nn_model)

# model evaluation
p <- predict(nn_model, newdata = BreastCancer_test , type = "class")
mean(p == BreastCancer_test$Class)
