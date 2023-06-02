# Dealership Reviews and Ratings and Their Influence on Car Prices

## Background
Online word of mouth has become increasingly popular and represents one of the main sources of information for digital buyers. Prior to making a purchase decision, customers often rely on peer evaluation of products or services to verify their quality. As extant studies have shown a positive correlation between consumer reviews and digital sales, there is no doubt that reviews act as an indicator of transparency, having the potential to build the trust of potential customers. Although there is a rich stream of review literature, there is a gap in the automotive sector which we aim to fill.

## Motivation and Research Question
To fill the gaps in extant literature, this study investigates how ratings and reviews of US dealerships influence prices of the cars they sell. By identifying both what customers value, but also the issues they face when interacting with a dealership, this could help businesses improve their services, as well as gain competitive advantage over others. Finding the relationship between consumers’ evaluations and prices could reveal new strategies for setting appropriate car prices and accelerate sales. This would not only support the economy, but also the businesses and local communities. Moreover, we extend the research by studying the impact of socio-economic indicators, which are different for each USA state.
To fill the gaps in extant literature, this study investigates how ratings and reviews of US dealerships influence prices of the cars they sell. By identifying both what customers value, but also the issues they face when interacting with a dealership, this could help businesses improve their services, as well as gain competitive advantage over others. Finding the relationship between consumers’ evaluations and prices could reveal new strategies for setting appropriate car prices and accelerate sales. This would not only support the economy, but also the businesses and local communities. 

## Method
- Perform sentiment analysis on dealers reviews 
- Regress car prices on sentiment score from reviews, rating scores and moderator variables
We first perform sentiment analysis on the written reviews to extract sentiment scores that indicate the polarity (negativity or positivity) of the reviews. To measure the impact of the reputation on selling prices, we conduct regression analysis using the sentiment scores, five rating scores representing different evaluation criteria and four moderating variables indicating certain aspects of the customer-dealership encounter. These are the independent variables on which we regress the listing car prices of the same dealership to which the reviews belong to.

![conceptual-model](https://github.com/ana-bianca-luca/dealership-reviews-impact-on-car-prices/assets/60931541/fd66fa65-605d-4efa-87f3-268ba4ebb9dd)

## Data and Workflow
To measure this relationship, we collect a rich amount of data from the [Cars.com](https://www.cars.com/dealers/buy/) marketplace: 1,250 dealerships across US for which we collected their inventory of cars and reviews, resulting in a sample of 371,652 reviews and 152,990 cars


![Workflow](https://github.com/ana-bianca-luca/dealership-reviews-impact-on-car-prices/assets/60931541/c5558b60-d996-4460-be1b-1f720230fc05)

## Data
Data scraped from [Cars.com](https://www.cars.com/dealers/buy/)
## Results
Results indicate that in general higher rating scores lead to an increase in listing prices, however the interaction effects between the ratings and moderators are almost always negative. Nonetheless, the final effect on listing price remains positive, which indicate that despite the details of the customer-dealership encounters, a higher rated dealership is expected to also have higher prices of cars. We also reveal differences in the effects between certain price ranges and conclude that for low priced cars, the quality of the buying process and of the repair have more power to influence the selling price, than for more expensive cars. When performing the regression on the entire price range, the sentiment scores do not have a significant influence, but they become significant for the low-price category.
