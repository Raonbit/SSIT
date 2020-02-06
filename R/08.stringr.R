library(stringr)

# 길이
str_length("abc")

# 문자열 일부 추출
x <- c("abcdef", "ghifjk")
str_sub(x, 3, 3)    # start pos, end pos
str_sub(x, 2, -2)

# 문자열 대치 
str_sub(x, 3, 3) <- "X"
x

# 문자열 반복
str_dup(x, c(2, 3))

# 공백 붙이기  
x <- c("abc", "defghi")
str_pad(x, 10)
str_pad(x, 10, "both")

x <- c("Short", "This is a long string")

x %>% 
  str_trunc(10) %>% 
  str_pad(10, "right")

# 공백 제거 
x <- c("  a   ", "b   ",  "   c")
str_trim(x)
str_trim(x, "left")

# 문자열 붙이기
jabberwocky <- str_c(
  "`Twas brillig, and the slithy toves ",
  "did gyre and gimble in the wabe: ",
  "All mimsy were the borogoves, ",
  "and the mome raths outgrabe. "
)
jabberwocky

# wrapping
cat(str_wrap(jabberwocky, width = 40))

# 대소문자 
x <- "I like horses."
str_to_upper(x)
str_to_title(x)
str_to_lower(x)

# 정렬
x <- c("y", "i", "k")
str_order(x)
str_sort(x)
str_sort(x, decreasing = T)

# pattern matching 
strings <- c(
  "apple", 
  "219 733 8965", 
  "329-293-8753", 
  "Work: 579-499-7527; Home: 543.355.3679"
)
strings
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"


str_detect(strings, phone)
str_subset(strings, phone)
str_count(strings, phone)

(loc <- str_locate(strings, phone))
str_locate_all(strings, phone)

str_extract(strings, phone)
str_extract_all(strings, phone)
str_extract_all(strings, phone, simplify = TRUE)

str_match(strings, phone)
str_match_all(strings, phone)

str_replace(strings, phone, "XXX-XXX-XXXX")
str_replace_all(strings, phone, "XXX-XXX-XXXX")

