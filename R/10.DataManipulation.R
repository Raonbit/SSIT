library(tidyr)
library(dplyr)
library(nycflights13)

str(flights)
str(weather)
str(planes)
str(airports)

## tidyr

# gather()
flight_delay = flights[c("tailnum","arr_delay", "dep_delay")]
flight_delay = flight_delay[sample(nrow(flight_delay), 5), ]
flight_delay
delay_gather = flight_delay %>% gather(delay, time, arr_delay:dep_delay)
delay_gather

# spread()
head(delay_gather,10)
flight_return <- delay_gather %>% spread(delay, time)
head(flight_return)

# seperate()
head(airports)
name_seperate <- airports %>% separate(name, c("prefix", "suffix"))
head(name_seperate)

#unite()
weather_part = weather[c("Date","Location", "MinTemp", "MaxTemp","Rainfall")]
head(weather_part)
temp_unite <- weather_part %>% unite(Temp, MinTemp, MaxTemp, sep = "/")
head(temp_unite)


## dplyr

# select()
head(planes)
planes_part = planes %>% select(tailnum, year, model:speed)
head(planes_part)
planes %>% select(starts_with("t"))
planes %>% select(-manufacturer, -speed)

#filter()
summary(planes)
planes_2004 = planes %>% filter(year==2004, engines > 2)
head(planes_2004)

# summarise()
flights %>% summarise(dep_delay_mean=mean(dep_delay),arr_delay_mean=mean(arr_delay)) 
head(flights);summary(flights)
flights_complete = flights %>% filter(!is.na(dep_delay), !is.na(arr_delay))
summary(flights_complete)
flights_complete %>% summarise(dep_delay_mean=mean(dep_delay),arr_delay_mean=mean(arr_delay)) 

# group_by()
flights_groupby_summarise = flights_complete %>% group_by(month) %>% summarise(dep_delay_mean=mean(dep_delay),arr_delay_mean=mean(arr_delay)) 
flights_groupby_summarise

# arrange()
flights_groupby_summarise_arrange = flights_groupby_summarise %>% arrange(dep_delay_mean)
flights_groupby_summarise_arrange
flights_groupby_summarise_arrange = flights_groupby_summarise %>% arrange(desc(arr_delay_mean))
flights_groupby_summarise_arrange


#join()
head(airports)
flights_dest_group = flights %>%  group_by(dest) %>%  filter(!is.na(arr_delay)) %>%  
  summarise(arr_delay = mean(arr_delay),  n = n()  ) %>%  arrange(desc(arr_delay))
location = airports %>%  select(dest = faa, name, lat, lon)
flights_join = flights_dest_group %>% left_join(location)
flights_join = flights_dest_group %>% left_join(location, by='dest')
flights_join = flights_dest_group %>% semi_join(location)


# mutate()
flights_mutate = flights %>%  select(year, month, day, tailnum, hour, minute) %>%  mutate(time = hour + minute / 60) 
flights_mutate_summarise = flights %>% mutate(time = hour + minute / 60) %>%
  group_by(time) %>%  summarise(arr_delay = mean(arr_delay, na.rm = TRUE), n = n()) 
