#k-mean
data(iris)
data= iris
summary(data)

data = iris[,1:4]
head(data)

cl = kmeans(data, 3)
head(cl)

k = 2:10 
tries = 100
betweenss.avg = integer(length(k))
tot.withinss.avg = integer(length(k))

for(v in k){ 
  temp.betweenss.avg = integer(tries) 
  temp.tot.withinss.avg = integer(tries) 
  
  for(i in 1:tries){
    k.temp = kmeans(data,v)
    temp.betweenss.avg[i] = k.temp$betweenss
    temp.tot.withinss.avg[i] = k.temp$tot.withinss
  }
  idx = v-1
  betweenss.avg[idx] = mean(temp.betweenss.avg)
  tot.withinss.avg[idx] = mean(temp.tot.withinss.avg) 
  
}

library(ggplot2)

performance_data = data.frame(k=k, tot.withniss=tot.withinss.avg, betweenss=betweenss.avg)

ggplot(performance_data, aes(k)) + 
  geom_line(aes(y = tot.withniss, colour = "tot.withniss")) + 
  geom_line(aes(y = betweenss, colour = "betweenss"))


#nomalization
performance_data <- transform(performance_data, 
                              z.tot.withniss = scale(tot.withniss), 
                              z.betweenss = scale(betweenss))

ggplot(performance_data, aes(k)) + 
  geom_line(aes(y = z.tot.withniss, colour = "tot.withniss")) + 
  geom_line(aes(y = z.betweenss, colour = "betweenss"))


## hierachical 
data = data[1:20,]
dm = dist(data) 
hc_complete = hclust(dm) #agglomerative clustering using complete linkage
plot(hc_complete)
hcd = as.dendrogram(hc_complete)
plot(hcd)

hc_complete = hclust(dm, method = "ward.D2")
plot(hc_complete)
hcd = as.dendrogram(hc_complete)
plot(hcd)

library(cluster)
# Agglomerative
hc_agglomerative = agnes(dm, method="complete")
plot(hc_agglomerative, which=2)

#divisive
hc_divisive = diana(dm)
plot(hc_divisive)