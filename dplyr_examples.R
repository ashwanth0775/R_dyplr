library(dplyr) 
data() 
## 
library(nycflights13)
dim(flights)
View(flights)

## --------------
View(filter(flights, month == 1, day == 1)) 

## ----------
View(arrange(flights, year, month, day)) 

## -----------
View(arrange(flights, desc(arr_delay))) 

## ----------------
# Select columns by name
View(select(flights, year, month, day))  
# Select all columns between year and day (inclusive)
View(select(flights, year:day)) 
# Select all columns except those from year to day (inclusive)
View(select(flights, -(year:day))) 


## Create new columns-----------------
flights1 = mutate(flights,
  gain = arr_delay - dep_delay,
  speed = distance / air_time * 60
) 
View(flights1) 

## -------------
flights2 =mutate(flights,
  gain = arr_delay - dep_delay,
  gain_per_hour = gain / (air_time / 60)
)
View(flights2) 

## ---------------
View(sample_n(flights, 20))
View(head(flights, 10))
View(tail(flights, 10)) 
View(sample_frac(flights, 0.01)) 

## ---------------
destinations <- group_by(flights, dest)
summarise(destinations,
  planes = n_distinct(tailnum),
  flights = n()
)

?n() 
View(destinations) 
## ------------------
daily <- group_by(flights, year, month, day)
(per_day   <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year  <- summarise(per_month, flights = sum(flights)))
View(daily)    

## --------------
# `year` represents the integer 1
View(select(flights, year)) 
View(select(flights, 1)) 

## ----------------
filter1 = filter(
  summarise(
    select(
      group_by(flights, year, month, day),
      arr_delay, dep_delay
    ),
    arr = mean(arr_delay, na.rm = TRUE),
    dep = mean(dep_delay, na.rm = TRUE)
  ),
  arr > 30 | dep > 30
)
View(filter1) 



