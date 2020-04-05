# This file is just to help me refamiliarize myself with R and the gtrends package/results

library(gtrendsR)
library(tidyverse)
library(dplyr)
library(tibble)

test_gtrends <- gtrends("Work from Home",geo="US-NJ",low_search_volume = FALSE,gprop = "web",time = "today 12-m")

#so the hits are already normalized over population. 
#So instead I should compare interest against X number of cornavirus infections?


#Map data types

sapply(test_gtrends$interest_over_time,typeof)

#okay so I need to convert the double to date

test_gtrends$interest_over_time_date <- test_gtrends$interest_over_time$date %>% 
  as.character() %>%
  #getting rid of date
  substring(first=1,last = 11) %>%
  as.Date(format="%Y-%m-%d")
 
#okay so we should be good
class(test_gtrends$interest_over_time_date)


formatted_df = tibble(date = test_gtrends$interest_over_time_date
                      , hits = test_gtrends$interest_over_time$hits
                      , geo  = test_gtrends$interest_over_time$geo
                      , keyword = test_gtrends$interest_over_time$keyword)

last_month <- subset(formatted_df, date >= as.Date("2020-03-01"))



simple_plot <-ggplot(last_month,mapping = aes(x=date,y=hits)) + geom_point()



