library(microbenchmark)

x <- runif(100)
microbenchmark(
  sqrt(x),
  x ^ 0.5
)

f0 <- function() NULL
f1 <- function(a = 1) NULL
f2 <- function(a = 1, b = 1) NULL
f3 <- function(a = 1, b = 2, c = 3) NULL
f4 <- function(a = 1, b = 2, c = 4, d = 4) NULL
f5 <- function(a = 1, b = 2, c = 4, d = 4, e = 5) NULL
microbenchmark(f0(), f1(), f2(), f3(), f4(), f5(), times = 50)


microbenchmark(
  "[32, 11]"      = mtcars[32, 11],
  "$carb[32]"     = mtcars$carb[32],
  "[[c(11, 32)]]" = mtcars[[c(11, 32)]],
  "[[11]][32]"    = mtcars[[11]][32],
  ".subset2"      = .subset2(mtcars, 11)[32]
)


ifef <- function(x, a, b) {
  ifelse(x <= a, a, ifelse(x >= b, b, x))
}
mathf <- function(x, a, b) {
  pmax(pmin(x, b), a)
}
swapf <- function(x, a, b) {
  x[x <= a] <- a
  x[x >= b] <- b
  x
}

x = runif(100, -1.5, 1.5)
microbenchmark(
  ifef = ifef(x, -1, 1),
  mathf = mathf(x, -1, 1),
  swapf = swapf(x, -1, 1),
  unit = "us"
)

devtools::install_github("rstudio/profvis")
library(profvis)
library(ggplot2)

profile = profvis({
  g <- ggplot(diamonds, aes(carat, price)) + geom_point(size = 1, alpha = 0.2)
  print(g)
})
profile


library(pryr)
object_size(1:10)
sizes = sapply(0:50, function(n) object_size(seq_len(n)))
plot(0:50, sizes, xlab = "Length", ylab = "Size (bytes)", type = "s")

mem_used()
mem_change(v <- list(1:1e8, 1:1e8, 1:1e8))
mem_used()


devtools::install_github("hadley/lineprof")
library(lineprof)

read_delim <- function(file, header = TRUE, sep = ",") {
  first <- scan(file, what = character(1), nlines = 1,
                sep = sep, quiet = TRUE)
  p <- length(first)
  
  all <- scan(file, what = as.list(rep("character", p)),
              sep = sep, skip = if (header) 1 else 0, quiet = TRUE)
  
  all[] <- lapply(all, type.convert, as.is = TRUE)
  
  if (header) {
    names(all) <- first
  } else {
    names(all) <- paste0("V", seq_along(all))
  }
  
  as.data.frame(all)
}

write.csv(diamonds, "diamonds.csv", row.names = FALSE)
profile = lineprof(read_delim("diamonds.csv"))
shine(profile)

