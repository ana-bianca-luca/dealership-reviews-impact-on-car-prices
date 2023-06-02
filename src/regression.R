#import libraries and load data

library(car)
library(tidyverse)
library(stargazer)
library(ranger)
library(glmnet)
library(leaps)
library(MASS)
library(data.table)
library(Hmisc)
library(broom)
library(corrplot)
library(fabricatr)

df <- read.csv("regression.csv")

df$recommend <- ifelse(df$recommend == 'yes', 1, 0)
df$purchase <- ifelse(df$purchase == 'yes', 1, 0)
df$repair <- ifelse(df$purchase_type == 'repair', 1, 0)
df$purchase_type <- ifelse(df$purchase_type == 'new', 1, 0)

df_clean <- df[, c(4,6:16)]

# Log-Log model
fg_log <- lm(log(price) ~ log(sentiment_score+1) + log(cust_service) + log(buying_process) + log(repair_quality) +  log(facilities) +   log(experience) + recommend + purchase_type + purchase
             + repair + log(buying_process)*purchase_type + log(cust_service)*recommend + log(buying_process)*purchase + log(repair_quality)*repair + log(facilities)*recommend + log(experience)*recommend, data = df_clean)

summary(fg_log)
stargazer(fg_log, type = "text")

#calculate effects
facilities = coef(fg_log)[6]
rec = coef(fg_log)[8]
fac_rec = coef(fg_log)[16]

deltaMethod(fg_log, "facilities+rec+fac_rec")

# Check multicollinearity
factor_cor <- rcorr(as.matrix(df_clean[,2:11])) 
round(factor_cor$P, 3)
corrplot(cor(df_clean[,2:11]), method="number")

vif(fg_log)


# Stepwise selection on fine grained log log model

step.model <- stepAIC(fg_log, direction = "both", trace = FALSE)
stargazer(step.model, type = "text")

#calculate effects
facilities = coef(step.model)[4]
fac_rec = coef(step.model)[11]
deltaMethod(step.model, "facilities+fac_rec")

repair = coef(step.model)[8]
repair_repair_q = coef(step.model)[10]
deltaMethod(step.model, "repair+repair_repair_q")

buying_process_purchase_type = coef(step.model)[9]
purchase_type = coef(step.model)[6]
deltaMethod(step.model, "buying_process_purchase_type+purchase_type")


#price histogram
hist(df_clean$price, xlim = c(0,100000), breaks = 1000, xlab = "Listing price", main = "Distribution of Listing price")


#split price ranges
split_quantile(x = df_clean$price, type = 5)

s <- df_clean %>% mutate(quantile = ntile(price, 5))

#models of different ranges
range1 <- lm(log(price) ~ log(sentiment_score+1) + log(cust_service) + log(buying_process) + log(repair_quality) +  log(facilities) +   log(experience) + recommend + purchase_type + purchase
             + repair + log(buying_process)*purchase_type + log(cust_service)*recommend + log(buying_process)*purchase + log(repair_quality)*repair + log(facilities)*recommend + log(experience)*recommend, data = s %>% filter(quantile == 1))

range2 <- lm(log(price) ~ log(sentiment_score+1) + log(cust_service) + log(buying_process) + log(repair_quality) +  log(facilities) +   log(experience) + recommend + purchase_type + purchase
             + repair + log(buying_process)*purchase_type + log(cust_service)*recommend + log(buying_process)*purchase + log(repair_quality)*repair + log(facilities)*recommend + log(experience)*recommend, data = s %>% filter(quantile == 2))

range3 <- lm(log(price) ~ log(sentiment_score+1) + log(cust_service) + log(buying_process) + log(repair_quality) +  log(facilities) +   log(experience) + recommend + purchase_type + purchase
             + repair + log(buying_process)*purchase_type + log(cust_service)*recommend + log(buying_process)*purchase + log(repair_quality)*repair + log(facilities)*recommend + log(experience)*recommend, data = s %>% filter(quantile == 3))

range4 <- lm(log(price) ~ log(sentiment_score+1) + log(cust_service) + log(buying_process) + log(repair_quality) +  log(facilities) +   log(experience) + recommend + purchase_type + purchase
             + repair + log(buying_process)*purchase_type + log(cust_service)*recommend + log(buying_process)*purchase + log(repair_quality)*repair + log(facilities)*recommend + log(experience)*recommend, data = s %>% filter(quantile == 4))

range5 <- lm(log(price) ~ log(sentiment_score+1) + log(cust_service) + log(buying_process) + log(repair_quality) +  log(facilities) +   log(experience) + recommend + purchase_type + purchase
             + repair + log(buying_process)*purchase_type + log(cust_service)*recommend + log(buying_process)*purchase + log(repair_quality)*repair + log(facilities)*recommend + log(experience)*recommend, data = s %>% filter(quantile == 5))

#display models
stargazer(range1, range2, range3, range4, range5, type='text', column.labels = c("$1,500-$23,992", "$23,992-$31,985",
                                                                                 "$31,985-$40,900", "$40,900-$53,580","$53,580-$1,690,000"), intercept.bottom = FALSE, initial.zero = FALSE)

#calculate effects
purchase_type = coef(range1)[9]
buying_process_purchase_type = coef(range1)[12]
deltaMethod(range1, "purchase_type+buying_process_purchase_type")

repair = coef(range1)[11]
repair_rep_quality = coef(range1)[15]
deltaMethod(range1, "repair+repair_rep_quality")

purchase = coef(range5)[10]
buy_purchase = coef(range5)[14]
deltaMethod(range5, "purchase+buy_purchase")