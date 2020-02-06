## dplyr, ggplot2, shiny
library(ggvis)
library(dplyr)
library(shiny)


(p <- ggvis(mtcars, x = ~wt, y = ~mpg))
layer_points(p)


mtcars %>%  ggvis(x = ~wt, y = ~mpg) %>%  layer_points()

mtcars %>%  ggvis(x = ~mpg, y = ~disp) %>%  mutate(disp = disp / 61.0237) %>% layer_points()


#visual properties
head(mtcars)
mtcars %>% ggvis(~mpg, ~disp, stroke = ~vs) %>% layer_points()
mtcars %>% ggvis(~mpg, ~disp, fill = ~vs) %>% layer_points()
mtcars %>% ggvis(~mpg, ~disp, size = ~vs) %>% layer_points()
mtcars %>% ggvis(~mpg, ~disp, shape = ~factor(cyl)) %>% layer_points()


mtcars %>% ggvis(~wt, ~mpg) %>% layer_points()

mtcars %>% ggvis(~wt, ~mpg, fill = "red") %>% layer_points()  # 적용 안됨
mtcars %>% ggvis(~wt, ~mpg, fill := "red", stroke := "black") %>% layer_points()  # := 
mtcars %>% ggvis(~wt, ~mpg, size := 300, opacity := 0.4) %>% layer_points()


# interaction
mtcars %>% ggvis(~wt, ~mpg, size := input_slider(10, 100),  opacity := input_slider(0, 1)) %>%  layer_points()

mtcars %>% ggvis(~wt) %>% 
  layer_histograms(width =  input_slider(0, 2, step = 0.10, label = "width"),
                   center = input_slider(0, 2, step = 0.05, label = "center"))

# input_slider(),  input_checkbox(), input_checkboxgroup(), input_numeric(), 
# input_radiobuttons(), input_select(), input_text(). 

## keyboard control
keys_s <- left_right(10, 1000, step = 50)
mtcars %>% ggvis(~wt, ~mpg, size := keys_s, opacity := 0.5) %>% layer_points()

## tooltip
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points() %>% add_tooltip(function(df) df$wt)


## layers
# layer_paths
df <- data.frame(x = 1:10, y = runif(10))
df
df %>% ggvis(~x, ~y) %>% layer_paths()
df %>% ggvis(~x, ~y) %>% layer_paths(fill := "red")

# layer_ribbon
df %>% ggvis(~x, ~y) %>% layer_paths()
df %>% ggvis(~x, ~y) %>% layer_ribbons()
df %>% ggvis(~x, ~y) %>% layer_ribbons(fill := "red")
df %>% ggvis(~x, ~y + 0.1, y2 = ~y - 0.1) %>% layer_ribbons()

# layer_rects
set.seed(1014)
df <- data.frame(x1 = runif(5), x2 = runif(5), y1 = runif(5), y2 = runif(5))
df
df %>% ggvis(~x1, ~y1, x2 = ~x2, y2 = ~y2, fillOpacity := 0.1) %>% layer_rects()


# layer_text
df <- data.frame(x = 3:1, y = c(1, 3, 2), label = c("a", "b", "c"))
df
df %>% ggvis(~x, ~y, text := ~label) %>% layer_text()
df %>% ggvis(~x, ~y, text := ~label) %>% layer_text(fontSize := 20)
df %>% ggvis(~x, ~y, text := ~label) %>% layer_text(fontSize := 30, angle := 45)

# layer_lines
t <- seq(0, 2 * pi, length = 20)
df <- data.frame(x = sin(t), y = cos(t))
df
df %>% ggvis(~x, ~y) %>% layer_paths()
df %>% ggvis(~x, ~y) %>% layer_lines()
df %>% ggvis(~x, ~y) %>% layer_points()
df %>% ggvis(~x, ~y) %>% arrange(x) %>% layer_points()
df %>% ggvis(~x, ~y) %>% arrange(x) %>% layer_paths()

# layer_histogram
mtcars %>% ggvis(~mpg) %>% layer_histograms()

# layer_smooths
mtcars %>% ggvis(~wt, ~mpg) %>% layer_paths()
mtcars %>% ggvis(~wt, ~mpg) %>% layer_lines()
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths()
smoothed <- mtcars %>% compute_smooth(mpg ~ wt)
smoothed %>% ggvis(~pred_, ~resp_) %>% layer_paths()

span <- input_slider(0.2, 1, value = 0.75)
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths(span = span)


## multiple layers
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths() %>% layer_points()
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths(span = 1) %>% layer_smooths(span = 0.3, stroke := "red")
