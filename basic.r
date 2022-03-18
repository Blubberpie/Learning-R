# This file is just me testing out different functions in R

# List from 5 to 15
x <- 5:15

# Access the last element
x[length(x)]

# R is 1-indexed
x[1]

# Ways of accessing the last 5 elements
x[(length(x) - 4) : length(x)]
x[length(x) - (4:0)] # Woah
x[seq.int(to = length(x), length.out = 5)]
tail(x, 5) # Safe, no boundary checking required
tail(x, 20) # Should be safe even if length(x) < 20

# Print even numbers
for (i in 1:20) {
    if (i %% 2 == 0) {
        next
    }
    print(i)
}

# Concatenation
paste(1:12) # same as as.character(..)
as.character(1:12)
paste("A", 1:10, "B", sep = "$")
paste("Today is", date())

do_count <- function(lo, hi) {
    print(sprintf("I can count from %d to %d", lo, hi))
    counter <- lo
    for (i in (lo + 1):hi) {
        counter <- paste(counter, i, sep = ", ")
    }
    print(counter)
}
do_count(1, 20)

# Concatenation by zipping
first_names <- c("Barack", "Donald", "Nicolas")
last_names <- c("Obama", "Trump", "Cage")
paste(first_names, last_names)

# Zipping uneven lengths
letts <- c("A", "B", "C", "D")
nums <- c("1", "2")
paste(letts, nums)

# List comprehension
# Python: xs = [x for x in xs if x % 2 == 0]
zs <- 1:20
zs[ifelse(zs %% 2 == 0, TRUE, FALSE)]