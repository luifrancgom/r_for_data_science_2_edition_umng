# Libraries ----
library(tidyverse)
library(nycflights13)

# 5.6 Exercises ----

## Restyle the following pipelines following the 
## guidelines above.

### You can use the styler package
#### https://CRAN.R-project.org/package=styler
#### https://styler.r-lib.org/
### Also you can check the tidyverse style guide
#### https://style.tidyverse.org/
flights|>filter(dest=="IAH")|>group_by(year,month,day)|>summarize(n=n(),
                                                                  delay=mean(arr_delay,na.rm=TRUE))|>filter(n>10)

flights |>
  filter(dest == "IAH") |>
  group_by(year, month, day) |>
  summarize(
    n = n(),
    delay = mean(arr_delay, na.rm = TRUE)
  ) |>
  filter(n > 10)

flights|>filter(carrier=="UA",dest%in%c("IAH","HOU"),sched_dep_time>
                  0900,sched_arr_time<2000)|>group_by(flight)|>summarize(delay=mean(
                    arr_delay,na.rm=TRUE),cancelled=sum(is.na(arr_delay)),n=n())|>filter(n>10)

flights |>
  filter(carrier == "UA", dest %in% c("IAH", "HOU"), sched_dep_time >
    0900, sched_arr_time < 2000) |>
  group_by(flight) |>
  summarize(delay     = mean(arr_delay, na.rm = TRUE), 
            # Here we obtain a clue about NA values
            # in the case of arr_delay. The flights 
            # that are cancelled have NA values
            cancelled = sum(is.na(arr_delay)), n = n()) |>
  filter(n > 10)