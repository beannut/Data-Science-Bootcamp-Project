## Churn prediction

install.packages("tidyverse")
install.packages("caret")

library(tidyverse)
library(caret)
library(dplyr)


df <- read_csv("churn.csv")
head(df)
view(df)

df$churn <- factor(df$churn)
table(df$churn)

## Check missing values
mean(complete.cases(df)) ## In this case, no missing value because mean = 1

## 1. split data
set.seed(6)
id <- createDataPartition(y= df$churn,
                          p= 0.8,
                          list = FALSE)
train_df <- df[id, ]
test_df <- df[-id, ]

## 2. train model
set.seed(6)
ctrl <- trainControl(
  method = "cv",
  number = 5,
  classProbs = TRUE,
  summaryFunction = twoClassSummary,
  verboseIter = TRUE
)

rf_model <- train(
  churn ~ .,
  data = train_df,
  method = "rf",
  metric = "ROC",
  preProcess = c("center","scale"),
  trControl = ctrl
)

## 3. test model
p <- predict(rf_model, newdata = test_df)
mean(p == test_df$churn)

#confusionMatrix
confusionMatrix(p, test_df$churn,
                positive = "Yes",
                mode = "prec_recall")

