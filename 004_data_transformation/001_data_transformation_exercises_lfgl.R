# Libraries ----
library(tidyverse)
library(nycflights13)

# 4.2.5 Exercises ----

## In a single pipeline for each condition, find all 
## flights that meet the condition:

### Had an arrival delay of two or more hours
flights |> filter(arr_delay >= 120)

### Flew to Houston (IAH or HOU)
#### https://en.wikipedia.org/wiki/List_of_airports_in_the_Greater_Houston_Area
#### https://en.wikipedia.org/wiki/Conroe-North_Houston_Regional_Airport
airports |> filter(faa %in% c('IAH', 'HOU', 
                              'LJN', 'GLS', 'EFD',
                              'IWS', 'CXO', 'SGR',
                              'DWH', 'HPY'))

flights |> filter(dest %in% c('IAH', 'HOU', 
                              'LJN', 'GLS', 'EFD',
                              'IWS', 'CXO', 'SGR',
                              'DWH', 'HPY')) |> 
  count(dest)

### Were operated by United, American, or Delta
airlines

flights |> filter(carrier %in% c('UA', 'AA', 'DL')) |> 
  count(carrier)

### Departed in summer (July, August, and September)
flights |> count(month)
  
flights |> filter(month %in% 7:9) |> 
  count(month)

### Arrived more than two hours late, but didn’t leave late
flights |> filter(arr_delay > 120 & dep_delay <= 0)
#### https://dplyr.tidyverse.org/reference/filter.html
##### If multiple expressions are included, they are combined 
##### with the & operator
flights |> filter(arr_delay > 120, dep_delay <= 0)

### Were delayed by at least an hour, but made up over 30 
### minutes in flight
#### delayed by at least an hour
flights |> filter(dep_delay >= 60)
#### Not recovering any time in flight
flights |> filter(dep_delay == arr_delay)
#### Recovering some time in flight
flights |> filter(dep_delay > arr_delay)
#### Recovering exactly 30 minutes in flight
flights |> filter(dep_delay == arr_delay + 30)
#### Recovering more than 30 minutes in flight
flights |> filter(dep_delay > arr_delay + 30)
#### delayed by at least an hour and recovering more 
#### than 30 minutes in flight  
flights |> 
  filter(dep_delay >= 60 & (dep_delay > arr_delay + 30))
##### Equivalently
flights |> 
  filter(dep_delay >= 60, dep_delay > arr_delay + 30)

## Sort flights to find the flights with longest departure 
## delays. Find the flights that left earliest in the 
## morning.
flights |> arrange(desc(dep_delay))
1301 / 60
### What is morning: dep_time > 0 & dep_time < 1200
flights |> arrange(dep_time)
#### Let's check dep_time == 0 and dep_time == 2400
##### We know there is no 0
###### We don't care about this cases because we can assume
###### that this are equivalent to 0 but we want dep_time > 0 
flights |> filter(dep_time == 2400)

## Sort flights to find the fastest flights. (Hint: Try 
## including a math calculation inside of your function.)
### fastest flights can be interpreted as some measure of
### velocity of the airplane
#### Distance (km) / time (hours)
##### Be careful because the airplane don't fly in a 
##### straight line so distance in flights is an
##### approximation
###### From miles to kilometers and from minutes to 
###### hours
flights |> 
  arrange(desc((distance / 1.609344) / (air_time / 60)))

(762 / 1.609344) / (65 / 60) # 437.0629 kms / hour

## Was there a flight on every day of 2013?
### Yes, taking into account that this tibble
### has 365 rows, n is different from 0 and 
### 2013 is not a leap year (año bisiesto)
flights |>
  count(month, day)

## Which flights traveled the farthest distance? 
## Which traveled the least distance?
flights |> 
  filter(distance == max(distance)) |> 
  glimpse()

flights |> 
  filter(distance == min(distance)) |> 
  glimpse()

### There are no missing values in distance
flights |> 
  filter(is.na(distance))

## Does it matter what order you used filter() and 
## arrange() if you’re using both? Why/why not? 
## Think about the results and how much work the 
## functions would have to do.

### In the case of filter no because you use a logical
### expression where A and B is the same as B and A
### In the case of arrange yes because it is not the
### same to order first based on A and then on B in 
### relation to first based on B and then on A
my_tibble_arrange <- tibble(A = c(1, 2, 2),
                            B = c('b', 'a', 'c'))

my_tibble_arrange |> arrange(A, B)
my_tibble_arrange |> arrange(B, A)

# 4.3.5 Exercises ----

## Compare dep_time, sched_dep_time, and dep_delay. 
## How would you expect those three numbers to be 
## related?

### dep_time = sched_dep_time + dep_delay
#### However this is not always the case if you
#### apply naive arithmetic with HHMM or HMM 
#### formats as doubles
flights |> 
  select(dep_time, sched_dep_time, dep_delay) |> 
  mutate(dep_time_expected = sched_dep_time + dep_delay) |> 
  filter(dep_time != dep_time_expected)

## Brainstorm as many ways as possible to select dep_time, 
## dep_delay, arr_time, and arr_delay from flights.
flights |> 
  select(dep_time, dep_delay, arr_time, arr_delay)

flights |>
  select(starts_with('dep'), starts_with('arr'))

flights |>
  # This is not mention in tidyselect
  ## - symbol
  select(dep_time:arr_delay, -contains('sched'))

## What happens if you specify the name of the same 
## variable multiple times in a select() call?
### The next repeated call is ignored
flights |> 
  select(month, day, month)

## What does the any_of() function do? Why might it be 
## helpful in conjunction with this vector?
?tidyselect::any_of
### x: A vector of character names or numeric locations.
variables <- c("year", "month", "day", 
               "dep_delay", "arr_delay")

#### We obtain a warning
flights |> 
  select(variables)

flights |> 
  select(any_of(variables))

#### More secure
flights |> 
  select(all_of(c(variables, 'foo')))

## Does the result of running the following code 
## surprise you? How do the select helpers deal with 
## upper and lower case by default? How can you 
## change that default?
### lower and upper strings are ignored
flights |> select(contains("TIME"))
flights |> select(contains("TImE"))

flights |> 
  select(contains(match = "TIME", ignore.case = FALSE))

## Rename air_time to air_time_min to indicate units 
## of measurement and move it to the beginning of 
## the data frame.
flights |> 
  rename(air_time_min = air_time) |> 
  relocate(air_time_min)

## Why doesn’t the following work, and what does the 
## error mean?
flights |> 
  # The problem is that only
  # tailnum is selected so
  # arrange can not find the
  # arr_delay column
  select(tailnum) |> 
  arrange(arr_delay)

# 4.5.7 Exercises ----

## Which carrier has the worst average delays? 
## Challenge: can you disentangle the effects of bad 
## airports vs. bad carriers? Why/why not? (Hint: 
## think about flights |> group_by(carrier, dest) |> 
## summarize(n()))
flights |> 
  group_by(carrier) |> 
  # I think a client cares more about minimizing
  # arrival delays
  summarize(arr_delay_mean = mean(arr_delay, na.rm = TRUE)) |> 
  ungroup() |> 
  # Maybe the problem is also related with
  # the origin and destination airport
  arrange(desc(arr_delay_mean))

flights |> 
  group_by(carrier, origin, dest) |> 
  summarize(arr_delay_mean = mean(arr_delay, na.rm = TRUE)) |> 
  ungroup() |> 
  # Things change when we control for 
  # the origin and destination airport 
  arrange(desc(arr_delay_mean))

## Find the flights that are most delayed upon 
## departure from each destination.
flights |> 
  group_by(dest) |> 
  slice_max(dep_delay) |> 
  ungroup() |> 
  select(dest, dep_delay) |> 
  arrange(desc(dep_delay))

## How do delays vary over the course of the day. 
## Illustrate your answer with a plot.
flights |> 
  count(hour)

flights |> 
  group_by(hour) |> 
  # Check the case of hour == 1
  summarize(dep_delay_mean = mean(dep_delay, na.rm = TRUE),
            arr_delay_mean = mean(arr_delay, na.rm = TRUE)) |> 
  ungroup() |> 
  ggplot(aes(x = hour)) +
  geom_line(aes(y=dep_delay_mean), color='red') + 
  geom_line(aes(y=arr_delay_mean), color='blue') +
  labs(x='Hour',
       y='Mean departure and arrival delay')

## What happens if you supply a negative n to 
## slice_min() and friends?
flights |> 
  select(arr_delay)

flights |> 
  select(arr_delay) |> 
  slice_min(arr_delay, n = 2)

### It arranges the data
#### In the case of slice_min it 
#### arranges the data in ascending
#### order
flights |> 
  select(arr_delay) |> 
  slice_min(arr_delay, n = -2)

## Explain what count() does in terms of the dplyr 
## verbs you just learned. What does the sort argument 
## to count() do?

flights |> 
  count(dest)
### count is equivalent to
flights |> 
  group_by(dest) |> 
  summarise(n = n()) |> 
  ungroup()

### sort arrange the data in descending
### order
flights |> 
  count(dest, sort = TRUE)

## Suppose we have the following tiny data frame:
df <- tibble(x = 1:5,
             y = c("a", "b", "a", "a", "b"),
             z = c("K", "K", "L", "L", "K"))

### Write down what you think the output will look 
### like, then check if you were correct, and describe 
### what group_by() does.

#### Group the variable by the y categories
df |>
  group_by(y)

### Write down what you think the output will look 
### like, then check if you were correct, and describe 
### what arrange() does. Also comment on how it’s 
### different from the group_by() in part (a)?

#### Arrange values of y in alphabetical order in
#### ascending order
#### Here we change the order of rows but in group
#### by not
df |>
  arrange(y)

### Write down what you think the output will 
### look like, then check if you were correct, 
### and describe what the pipeline does.

#### Obtain the mean of x according to each y
#### category
df |>
  group_by(y) |>
  summarize(mean_x = mean(x))

### Write down what you think the output will 
### look like, then check if you were correct, 
### and describe what the pipeline does. Then, 
### comment on what the message says.

#### Obtain the mean of x according to each y
#### and z combination of categories
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))

##### The message means that the grouping by 
##### z is droped

### Write down what you think the output will 
### look like, then check if you were correct, 
### and describe what the pipeline does. How 
### is the output different from the one in part (d).

#### Obtain the mean of x according to each y
#### and z combination of categories where you
#### drop any grouping 
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x), .groups = "drop")

### Write down what you think the outputs will look 
### like, then check if you were correct, and describe 
### what each pipeline does. How are the outputs of 
### the two pipelines different?

#### Obtain the mean of x according to each y
#### and z combination of categories and collapse
#### the result for each grouping combination
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))

#### Obtain the mean of x according to each y
#### and z combination of categories and add
#### a column for each row according to the
#### grouping
df |>
  group_by(y, z) |>
  mutate(mean_x = mean(x))
