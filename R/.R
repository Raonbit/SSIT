table = read.table("http://www.ats.ucla.edu/stat/data/test.txt", header = TRUE)
is.data.frame(table)
head(table)
?read.table

table.fixed = read.fwf("http://www.ats.ucla.edu/stat/data/test_fixed.txt", width = c(8, 1, 3, 1, 1, 1))
is.data.frame(table)
head(table)


