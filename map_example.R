library(tidyr)
library(dplyr)
library(maps)
library(usmap)

url4 <- "https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true"
prison_county_state <- read.csv(url4)

data_2016 <- prison_county_state %>%
  filter(year == 2016)

data_2016_by_state <- data_2016 %>%
  group_by(state) %>%
  summarize(
    sum_prison = sum(total_prison_pop, na.rm = TRUE),
    sum_total = sum(total_pop, na.rm = TRUE)
  )

data_2016_by_state <- data_2016_by_state %>%
  mutate(ratio = sum_prison / sum_total)

data_2016_by_state <- data_2016_by_state %>%
  arrange(state)

data_2016_by_state$state <- tolower(state.name[match(data_2016_by_state$state, state.abb)])

states_map <- map_data("state")

data_2016_by_state <- counties_map %>%
  left_join(data_2016_by_state, by = c("region" = "state"))

library(ggplot2)
ggplot(data_2016_by_state, aes(map_id = region, fill = ratio)) +
  geom_map(map = US_map, aes(x = long, y = lat, map_id = region)) +
  expand_limits(x = counties_map$long, y = counties_map$lat) +
  scale_fill_gradient(low = "lightblue", high = "darkblue", na.value = "grey50", name = "Percentage") +
  labs(title = "Percentage of Population in Prison by State",
       x = "",
       y = "") +
  theme_void() +
  theme(legend.position = "right")
