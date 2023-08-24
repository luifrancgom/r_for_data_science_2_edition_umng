# Libraries ----
library(tidyverse)

# 6.2.1 Exercises ----

## For each of the sample tables, describe 
## what each observation and each column 
## represents.

### Let's rescue the tables using information in
### the tidyr package
#### tidyr::who, tidyr::population 
table1 <- who |> 
  filter(iso3 %in% c('AFG', 'BRA', 'CHN'), 
         year %in% c(1999, 2000)) |> 
  rowwise(iso3, year) |> 
  mutate(cases = sum(c_across(new_sp_m014:newrel_f65), 
                     na.rm = TRUE)) |> 
  ungroup() |> 
  select(country, year, cases) |> 
  left_join(y = population, 
            by = join_by(country == country, year == year))

table2 <- table1 |> 
  pivot_longer(cols = cases:population, 
               names_to = 'type',
               values_to = 'count') 

table3 <- table1 |> 
  mutate(rate = str_c(cases, population, sep = '/')) |> 
  select(country, year, rate)

#### In table1 and table2 the observation is the 
#### (country, year). However in the case of table3
#### the observation is (country, year, variable)
#### In table1 the columns are the country, year,
#### number of new tuberculosis cases: see ?tidyr::who
#### In table2 the columns are country, year, variable
#### type and the value of the variable
#### In table3 the columns are country, year and relation
#### between new tuberculosis cases and population. 
#### However the problem is that is expressed as a
#### character and mix 2 variables: see ?tidyr::who
table1
table2  
table3  

## Sketch out the process you’d use to calculate 
## the rate for table2 and table3. You will need 
## to perform four operations:
  
### Extract the number of TB cases per country per year.
### Extract the matching population per country per year.
### Divide cases by population, and multiply by 10000.
### Store back in the appropriate place.

## You haven’t yet learned all the functions you’d 
## need to actually perform these operations, but you 
## should still be able to think through the transformations 
## you’d need.

#### For table2
##### For this case you need to group by country, then
##### divide row 1 by row 2 and multiply by 10000
###### Without changing the structure of the data the 
###### process is more difficult

#### For table3
##### For this case you need to separate the rate in
##### 2 columns and then apply mutate to the new 
##### created columns by dividing the 2 columns and
##### multiplying them by 10000
