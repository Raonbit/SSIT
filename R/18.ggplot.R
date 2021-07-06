library(ggplot2)

housing = read.csv("landdata-states.csv")
str(housing)

## histogram
ggplot(housing, aes(x=Home.Value)) + geom_histogram()
#bin : x 축 ( 초기값은 range / 30 ), range : max - min
ggplot(housing, aes(x=Home.Value)) + geom_histogram(bins=100)
ggplot(housing, aes(x=Home.Value)) + geom_histogram(binwidth = 4000)

## Statistical Transformation
housing.sum = aggregate(housing["Home.Value"], housing["State"], FUN=mean)
head(housing.sum, 10)

ggplot(housing.sum, aes(x=State, y=Home.Value)) + geom_bar()
ggplot(housing.sum, aes(x=State, y=Home.Value)) + geom_bar(stat="identity")


## scatter plot
ggplot(subset(housing, State %in% c("MA", "TX")), aes(x=Date, y=Home.Value, color=State))+geom_point()

## add viz
hp2001Q1 = subset(housing, Date == 20011) 
p1 = ggplot(hp2001Q1, aes(y = Structure.Cost, x = Land.Value))
# 1. scatter plot
(p2 = p1 + geom_point(aes(color = Home.Value)))  
# 2. prediction line 추가(linear regression)
hp2001Q1$pred.SC <- predict(lm(Structure.Cost ~ Land.Value, data = hp2001Q1))
(p3 = p2 + geom_line(aes(y=hp2001Q1$pred.SC)))
# 3. smoothers
(p4 = p2 + geom_smooth(method=loess))
# loess : Local Polynomial Regression Fitting
# text
(p5 = p1 + geom_text(aes(label=State), size=3))
# text 겹침 방지
library(ggrepel)  
(p6 = p1 + geom_point() + geom_text_repel(aes(label=State), size = 3))


## 고정값의 사용은 aes() 밖에서
p1 + geom_point(aes())
p1 + geom_point(aes(), size=2, color="red")
p1 + geom_point(aes(size=100, color="red"))

p1 + geom_point(aes(color=Home.Value, shape = region))


## 실습
dat <- read.csv("c:/raonbit/dataSets/EconomistData.csv")
# 1. x 축은 CPI, y축은 HDI로 scatter plot 
# 2. 1번 plot 점의 색깔은 파란색으로 
# 3. 점의 색깔을 Region  별로 다르게 
# 4. Region에 의한 CPI boxplot
# 5. box plot 과 scatter plot overlay

ggplot(dat, aes(x=CPI, y=HDI)) + geom_point(color="blue")
ggplot(dat, aes(x=CPI, y=HDI)) + geom_point(aes(color=Region))
ggplot(dat, aes(x=Region, y=CPI)) + geom_boxplot()
ggplot(dat, aes(x=Region, y=CPI)) + geom_boxplot() + geom_point()


## 실습
# 1. 앞 실습 1번 plot에 lm method를 이용하여 smoothing line 추가
# 2. 앞 실습 1번 plot에 기본 method를 이용하여 smoothing line 추가

ggplot(dat, aes(x=CPI, y=HDI)) + geom_point(aes(color=Region)) + geom_smooth(method="lm")
ggplot(dat, aes(x=CPI, y=HDI)) + geom_point(aes(color=Region)) + geom_smooth()
ggplot(dat, aes(x=CPI, y=HDI)) + geom_point(aes(color=Region)) + geom_smooth(span = .4)


## Scale : Control the mapping between data and aesthetics.
# scale_<aestheitc>_<type>
# position, color, fill, size, shape, line type


(p3 = ggplot(housing, aes(x = State, y = Home.Price.Index)))

# jitter : overplotting(겹처짐 방지)
(p4 = p3 + geom_point(aes(color=Date), alpha=0.5, size=1.5, position=position_jitter(width=0.25, height=0)))


(p4 +
  scale_x_discrete(name="State Abbreviation") +
  scale_color_continuous(name="Color Index",
                         breaks = c(19751, 19941, 20131),
                         labels = c(1971, 1994, 2013),
                         low = "blue", high = "red"))

(p4 +
  scale_color_gradient2(name="Color Index",
                        breaks = c(19751, 19941, 20131),
                        labels = c(1971, 1994, 2013),
                        low = "blue",
                        high = "red",
                        mid = "gray60",
                        midpoint = 19941))

## Faceting : display subsets of the dataset in different panels.

(p5 = ggplot(housing, aes(x = Date, y = Home.Value)) + geom_line(aes(color = State)))

(p5 <- p5 + geom_line() +  facet_wrap(~State, ncol = 10))
# 2차원
(p5 + geom_line() +  facet_grid(region~State))


## Theme : handles non-data plot elements such as
# Axis labels, Plot background, Facet label backround, Legend appearance

p5
p5 + theme_linedraw()
p5 + theme_light()

# Overriding theme defaults
p5 + theme_minimal()
p5 + theme_minimal()+ theme(text = element_text(color = "turquoise"))


theme_new = theme_bw() +
  theme(plot.background = element_rect(size = 1, color = "blue", fill = "black"),
        text=element_text(size = 12, family = "Arial", color = "ivory"),
        axis.text.y = element_text(colour = "purple"),
        axis.text.x = element_text(colour = "red"),
        panel.background = element_rect(fill = "pink"),
        strip.background = element_rect(fill = "orange"))

p5 + theme_new


# Tip
housing.byyear = aggregate(cbind(Home.Value, Land.Value) ~ Date, data = housing, mean)
head(housing.byyear)

ggplot(housing.byyear, aes(x=Date)) +  
  geom_line(aes(y=Home.Value), color="red") +
  geom_line(aes(y=Land.Value), color="blue")

library(tidyr)
home.land.byyear = gather(housing.byyear, value = "value",key = "type",Home.Value, Land.Value)
head(home.land.byyear)
ggplot(home.land.byyear, aes(x=Date, y=value, color=type)) +  geom_line()


## full

# data load
dat = read.csv("EconomistData.csv")

# scatter plot
pc1 = ggplot(dat, aes(x = CPI, y = HDI, color = Region))
pc1 + geom_point()

# trend line
(pc2 = pc1 +  geom_smooth(aes(group = 1),  method = "lm", formula = y ~ log(x), se = FALSE, color = "red")) +
  geom_point()

# open point
(pc2 + geom_point(shape = 1, size = 4))
(pc3 = pc2 +
  geom_point(size = 4.5, shape = 1) +
  geom_point(size = 4, shape = 1) +
  geom_point(size = 3.5, shape = 1))

# labeling
pointsToLabel = c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                  "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                  "India", "Italy", "China", "South Africa", "Spane",
                  "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                  "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                  "New Zealand", "Singapore")
(pc4 = pc3 +
  geom_text(aes(label = Country),
            color = "gray20",
            data = subset(dat,Country %in% pointsToLabel)))

# 겹침방지
(pc3 +  geom_text_repel(aes(label = Country),
                        color = "gray20",
                        data = subset(dat, Country %in% pointsToLabel),
                        force = 10))

#범례 변경 
dat$Region = factor(dat$Region,
                    levels = c("EU W. Europe",
                               "Americas",
                               "Asia Pacific",
                               "East EU Cemt Asia",
                               "MENA",
                               "SSA"),
                    labels = c("OECD",
                               "Americas",
                               "Asia &\nOceania",
                               "Central &\nEastern Europe",
                               "Middle East &\nnorth Africa",
                               "Sub-Saharan\nAfrica"))

(pc4$data = dat)

# title & axes
library(grid)
(pc5 <- pc4 +
  scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                     limits = c(.9, 10.5),
                     breaks = 1:10) +
  scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",
                     limits = c(0.2, 1.0),
                     breaks = seq(0.2, 1.0, by = 0.1)) +
  scale_color_manual(name = "",
                     values = c("#24576D",
                                "#099DD7",
                                "#28AADC",
                                "#248E84",
                                "#F2583F",
                                "#96503F")) +
  ggtitle("Corruption and Human development"))


(pc6 <- pc5 +
  theme_minimal() + # start with a minimal theme and add what we need
  theme(text = element_text(color = "gray20"),
        legend.position = c("top"), # position the legend in the upper left 
        legend.direction = "horizontal",
        legend.justification = 0.1, # anchor point for legend.position.
        legend.text = element_text(size = 11, color = "gray10"),
        axis.text = element_text(face = "italic"),
        axis.title.x = element_text(vjust = -1), # move title away from axis
        axis.title.y = element_text(vjust = 2), # move away for axis
        axis.ticks.y = element_blank(), # element_blank() is how we remove elements
        axis.line = element_line(color = "gray40", size = 0.5),
        axis.line.y = element_blank(),
        panel.grid.major = element_line(color = "gray50", size = 0.5),
        panel.grid.major.x = element_blank()
  ))
