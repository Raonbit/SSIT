simple_tag <- function(tag) {
  function(...) {
    paste0("<", tag, ">", paste0(...), "</", tag, ">")
  }
}
tags <- c("p", "b", "i")
html <- lapply(setNames(tags, tags), simple_tag)
html

html$p("This is ", html$b("bold"), " text.")

with(html, p("This is ", b("bold"), " text."))

attach(html)
p("This is ", b("bold"), " text.")
detach(html)


list2env(html, environment())
p("This is ", b("bold"), " text.")
rm(list = names(html), envir = environment())
