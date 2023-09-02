# Libraries ----
library(tidyverse)

# 8.2.4 Exercises ----

## What function would you use to read a file where fields 
## were separated with “|”?
"x|y|z
1|2|3" |> 
  read_delim(delim = '|')

## Apart from file, skip, and comment, what other arguments 
## do read_csv() and read_tsv() have in common?
### All the arguments of both functions are equal
?read_csv
?read_tsv

## What are the most important arguments to read_fwf()?
?read_fwf
### Use a real example
#### UniProt Knowledgebase (UniProtKB)
#### freely accessible and comprehensive database for 
#### protein sequence and annotation data available under 
#### a CC-BY (4.0) license
##### https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/docs/humchr01.txt
read_fwf(file = '000_data_sets/008_humchr01.txt', 
         col_positions = fwf_widths(widths = c(16, 16, 11, 12, 7, NA),
                                    col_names = c('gene_name',
                                                  'chromosomal_position',
                                                  'swiss_prot_ac',
                                                  'entry_name',
                                                  'mim_code',
                                                  'description')),
         na = c('', 'NA', '-'),
         trim_ws = TRUE,
         skip = 36,
         n_max = 2072)

### The key argument is col_positions with the helpers
### fwf_empty(), fwf_widths(), fwf_positions(), fwf_cols()

## Sometimes strings in a CSV file contain commas. To 
## prevent them from causing problems, they need to be 
## surrounded by a quoting character, like " or '. By default, 
## read_csv() assumes that the quoting character will be ". 
## To read the following text into a data frame, what argument 
## to read_csv() do you need to specify?
"x,y\n1,'a,b'" |> 
  read_csv(quote = "'")

## Identify what is wrong with each of the following inline 
## CSV files. What happens when you run the code?

### There are only 2 columns but 3 values in each row
read_csv("a,b\n1,2,3\n4,5,6")
#### Possible solution
read_csv("a,b\n1,2,3\n4,5,6", 
         skip = 1, 
         col_names = c('a', 'b', 'c'))

### Every row has different lengths 
read_csv("a,b,c\n1,2\n1,2,3,4")
#### Possible solution
read_csv("a,b,c\n1,2\n1,2,3,4",
         skip = 2,
         col_names = c('a', 'b', 'c', 'd')) |> 
  add_row(a = 1, b = 2, 
          .before = 1)

### There is only one value but 2 column names 
### Also we have the symbol "1
read_csv("a,b\n\"1")
#### Possible solution
##### No solution, this is a mess!!!

### I don't see any problem
#### Maybe there is a problem with the data
#### types. There is a mixture of numbers 
#### and characters
read_csv("a,b\n1,2\na,b")
#### Possible solution
##### Talk to the source of the information
##### Maybe 1 means a and 2 means b

### The delimiter is not "," but ";"
read_csv("a;b\n1;3")
#### Possible solution
read_csv2("a;b\n1;3")

## Practice referring to non-syntactic names in 
## the following data frame by
set.seed(seed = 123)
annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)

### Extracting the variable called 1
annoying |> 
  select(`1`)

### Plotting a scatterplot of 1 vs. 2.
annoying |> 
  ggplot(aes(x = `1`, y = `2`)) + 
  geom_point()

### Creating a new column called 3, which 
### is 2 divided by 1.
annoying |> 
  mutate(`3` = `2` / `1`)

### Renaming the columns to one, two, and three
annoying |> 
  mutate(`3` = `2` / `1`) |> 
  rename(one = `1`, two = `2`, three = `3`)
