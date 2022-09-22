## Data Transformation / Data Wrangling

install.packages("tidyverse",dependencies = TRUE)

library(tidyverse)

## read data files
friends <- read_csv("friends.csv")

View(mtcars)

## tibble == enhanced dataframe
mtcars <- tibble(mtcars)
class(mtcars)

## dplyr - data transformation

## select colums
select(mtcars, mpg, hp, wt)
select(mtcars,1,3,5,7,9)
select(mtcars,1:5, 8:9)

select(mtcars, starts_with("h"))
select(mtcars, ends_with("p"))
select(mtcars, contains("a"))
select(mtcars, carb, everything())

select(mtcars, horsePower = hp,
               milePerGallon = mpg,
               weight = wt)

# create new column
mtcars$model <- rownames(mtcars)
rownames(mtcars) <- NULL
mtcars <- select(mtcars, model, everything())


## filter rows with conditions

filter(mtcars, mpg > 15)
filter(mtcars, mpg < 15 & hp > 200& am == 1)
filter(mtcars, mpg < 19 | am == 0)

## combine select + filter
head(mtcars)
mtcars %>%
  select(mpg, hp, wt) %>%
  filter(mpg > 15, hp>200) %>%
  mutate(double_hp = hp*2)

mtcars %>%
  select(mpg, hp, wt, am) %>%
  filter( between(mpg, 25, 30) ) # between

## arrange data 
mtcars %>%
  select(mpg, hp, wt) %>%
  arrange(hp)

mtcars %>%
  select(mpg, hp, wt, am) %>%
  mutate( am = factor(am,
                      levels = c(0,1),
                      labels = c("Auto","Manual")))%>%
  filter( am == "Auto")

mtcars %>%
  select(mpg, hp, wt, am) %>%
  mutate( am = factor(am,
                      levels = c(0,1),
                      labels = c("Auto","Manual")))%>%
  arrange( desc(am) ) %>%
  as.data.frame()

mtcars %>%
  select(mpg, hp, wt, am) %>%
  mutate( am = factor(am,
                      levels = c(0,1),
                      labels = c("Auto","Manual")))%>%
  arrange( desc(am), wt ) %>%
  as.data.frame()


## summarise() 
  mtcars %>%
  summarise(
    avg_mpg = mean(mpg),
    sum_mpg = sum(mpg),
    min_mpg = min(mpg),
    max_mpg = max(mpg),
    var_mpg = var(mpg),
    sd_mpg  = sd(mpg),
    median_mpg = median(mpg),
    n = n()
  )
  
## summarise() + group_by()
  mtcars <- mtcars %>%
    mutate(vs = as.factor(vs),
           am = as.factor(am)) 
  
  mtcars %>%
    group_by(am, vs) %>%
    summarise(
      avg_mpg = mean(mpg),
      sum_mpg = sum(mpg),
      min_mpg = min(mpg),
      max_mpg = max(mpg),
      var_mpg = var(mpg),
      sd_mpg  = sd(mpg),
      median_mpg = median(mpg),
      n = n()
    )
  
