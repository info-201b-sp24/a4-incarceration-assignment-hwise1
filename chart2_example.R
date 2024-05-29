library(tidyr)
library(dplyr)

url4 <- "https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true"
prison_county_state <- read.csv(url4)

data_2016 <- prison_county_state %>%
  filter(year == 2016)

sum_black_pop <- sum(prison_county_state$black_prison_pop, na.rm = TRUE)
sum_white_pop <- sum(prison_county_state$white_prison_pop, na.rm = TRUE)
sum_total_pop <- sum(prison_county_state$total_prison_pop, na.rm = TRUE)
sum_latinx_pop <- sum(prison_county_state$latinx_prison_pop, na.rm = TRUE)
latinx_area_pop <- sum(prison_county_state$latinx_pop_15to64, na.rm = TRUE)
black_area_pop <- sum(prison_county_state$black_pop_15to64, na.rm = TRUE)
white_area_pop <- sum(prison_county_state$white_pop_15to64, na.rm = TRUE)



latinx_in_prison_percent <- sum_latinx_pop / latinx_area_pop

prison_black_percentage <- sum_black_pop / sum_total_pop

prison_latinx_percentage <- sum_latinx_pop / sum_total_pop

black_in_prison_percent <- sum_black_pop / black_area_pop

prison_white_percentage <- sum_white_pop / sum_total_pop

white_in_prison_percent <- sum_white_pop / white_area_pop



df_bar_graph <- data.frame(
  variable = c("White", "Black", "Latinx"),
  value = c(white_in_prison_percent, black_in_prison_percent, latinx_in_prison_percent)
)

library(ggplot2)
ggplot(df_bar_graph, aes(x = variable, y = value, fill = variable)) +
  geom_bar(stat = "identity") +
  labs(title = "Percent of 15 to 64 Year Old Population in Prison by Race",
       x = "Race",
       y = "Percentage in Prison") 
