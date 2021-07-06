## data.table

library(data.table)
library(dplyr)
library(nycflights13)

planes_df = copy(planes)
planes_dt = setDT(planes_df)

class(planes)
class(dt)

# select columns
select(planes_df, tailnum, year, model:speed)
planes_dt[,.(tailnum, year, model, engines, seats, speed)]

select(planes,starts_with("t"))
t_col = grepl("^[t*]", names(planes_dt))
planes_dt[,t_col, with = F]

# select rows
filter(planes_dt, year==2004, engines==2)
planes_dt[year==2004 & engines==2]

setkey(planes_dt, year)
planes_dt[2004]

planes_dt$year = as.factor(planes_dt$year)
setkey(planes_dt, year)
planes_dt["2004"]

planes_dt[year %in% c("2004","2005")]

# group by 

flights_df = copy(flights)
flights_dt= setDT(flights_df)

flights_dt[arr_delay > 0 & dep_delay > 0,    #  filter
   .(dep_delay_mean=mean(dep_delay),
     arr_delay_mean=mean(arr_delay),         #  summrise
     n = .N),                      
     by = month]                             # group by


# add/remove fields
flights_dt[, speed := (distance * 1.852) / (air_time / 60)]
flights_dt[is.na(speed), speed := 0]
flights_dt[nchar(tailnum) < 2, tailnum := "Unknown"]
flights_dt

flights_dt[, speed := NULL]; flights_dt

flights_dt[, `:=` (
                  speed = (distance * 1.852) / (air_time / 60),
                  date = paste(year, month, day, sep = "-")
)]
flights_dt

flights_dt[, c("speed", "date") := NULL];flights_dt

# command chaining
newdt = flights_dt[, c("date", "speed") := {
  date = paste(year, month, day, sep = "-")
  km = distance * 1.852
  hr = air_time / 60
  speed = km / hr
  .(date = date, speed = speed)
}]
newdt[speed > 1234, .(date, air_time, distance, speed, carrier, tailnum)]

flights_dt[, c("date", "speed") := {
  date = paste(year, month, day, sep = "-")
  km = distance * 1.852
  hr = air_time / 60
  speed = km / hr
  .(date = date, speed = speed)
}][speed > 1234, .(date, air_time, distance, speed, carrier, tailnum)]

# left join
leftjoin_dt = merge(flights_dt, planes_dt, by = "tailnum", all.x = T)
leftjoin_dt

setkey(planes_dt, tailnum)
setkey(flights_dt, tailnum)
leftjoin_dt = flights_dt[planes_dt]
leftjoin_dt

leftjoin_dt[speed > 1234, .(carrier, tailnum, origin, dest, speed, manufacturer, model, engine)]

# full join 
fulljoin_dt = merge(flights_dt, planes_dt, by = "tailnum", all = T)
fulljoin_dt

# convert multiple column
flights_dt[, lapply(.SD, function(x) x/60), .SDcols = c("dep_delay", "arr_delay")]   # .SD : Subset of dataframe

idx.numcols = which(names(flights_dt) %like% "delay");idx.numcols
names.numcols = names(flights_dt)[idx.numcols];names.numcols

flights_dt[, (names.numcols) := lapply(.SD, function(x) ifelse(is.na(x), x, x/60)), .SDcols = names.numcols]
flights_dt
print(head(flights_dt, 3)[, names.numcols, with = F])

# flights_dt[, arr.delay.corr := arr_delay - dep_delay]

# find duplicated
key(df)
setkey(df) # remove key

dedup = flights_dt[!duplicated(flights_dt),]; dedup  # find the unique records
nrow(dedup) 
nrow(unique(flights_dt, by ="carrier")) 

setkey(flights_dt, carrier)
dedup = flights_dt[!duplicated(flights_dt),]
nrow(dedup) 

# data table copy
planes.copy = planes_dt
planes.copy[, type := NULL]
"type" %in% names(planes_dt) 

planes.deep.copy = copy(planes_dt)
planes.deep.copy[, type := NULL]
"type" %in% names(planes_dt) 

# rename
setnames(flights_dt, c("air_time", "speed"), c("air_time.min", "speed.km.hr"))
flights_dt

# ordering
dfx = flights_dt[, .(year, month, day, date)]  # sample data.table
setcolorder(dfx, c("date", "day", "month", "year"))
dfx[, .(date, day, month, year)]

# fread

library(microbenchmark)
microbenchmark(
  "read.csv"  = read.csv("diamonds.csv"),
  "fread"     = as.data.frame(fread("diamonds.csv"))
)
