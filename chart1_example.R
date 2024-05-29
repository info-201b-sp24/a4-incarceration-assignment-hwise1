library(tidyr)
library(dplyr)

url4 <- "https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true"
prison_county_state <- read.csv(url4)

data_select_years <- prison_county_state %>%
  filter(year > 1982 & year < 2017)

data_summary <- data_select_years %>%
  group_by(year) %>%
  summarize(black_total = sum(black_prison_pop, na.rm = TRUE), white_total = sum(white_prison_pop, na.rm = TRUE), latinx_total = sum(latinx_prison_pop, na.rm = TRUE))

prison_county_state_shaped <- pivot_longer(data_summary, cols = c(black_total, white_total, latinx_total), names_to = "race", values_to = "total")

library(ggplot2)
  ggplot(prison_county_state_shaped, aes(x = year, y = total, color = race)) +
    geom_line() +
    labs(title = "Inmates by Race Over Time",
         x = "Year",
         y = "Number of Prisoners",
         color = "Race") +
    scale_color_manual(values = c(black_total = "blue", white_total = "red", latinx_total = "green"),
                       labels = c(black_total = "African American", white_total = "White", latinx_total = "Latinx")) 
  
