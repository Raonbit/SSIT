library(lubridate)

Sys.setlocale("LC_TIME", "usa")

today = today()
year = year(today)
month = month(today)
day = day(today)

rbind(year, month, day)

w = wday(today)
m = mday(today)
y = yday(today)

rbind(w,m,y)

wday(today, label = TRUE)


now <- now()
h <- hour(now)
m <- minute(now)
s <- second(now)

rbind(h, m, s)

ymd("20160301"); mdy("03-01-2016"); dmy("01/03/2016")


