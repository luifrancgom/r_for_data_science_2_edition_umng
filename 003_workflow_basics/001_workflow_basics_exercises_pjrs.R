
#3.1 Coding basics
#math calculations:
1 / 200 * 30
#> [1] 0.15
(59 + 73 + 2) / 3
#> [1] 44.66667
sin(pi / 2)
#> [1] 1


#You can create new objects with the assignment operator <-:
x <- 3 * 4 #value stored
x

#You can combine multiple elements into a vector with c():
primes <- c(2, 3, 5, 7, 11, 13)


#and basic arithmetic on vectors is applied to every element of of the vector:
primes * 2
#> [1]  4  6 10 14 22 26
primes - 1
#> [1]  1  2  4  6 10 12

#All R statements where you create objects, assignment statements, have the same form:
#object_name <- value "“object name gets value” "  

#This <-  can be created with ALt -

#3.2 Comments
#R will ignore anything after #
# create vector of primes
primes <- c(2, 3, 5, 7, 11, 13)

# multiply primes by 2
primes * 2
#> [1]  4  6 10 14 22 26

#Use comments to explain the why of your code, not the how or the what.
#The what and how of your code are always possible to figure out
#use comments to explain your overall plan of attack and record important insights as you encounter them

#3.3 What’s in a name?
#Object names: start with a letter and letters, numbers, _, and . 
##be descriptive. lowercase, snake_case (_).

i_use_snake_case
otherPeopleUseCamelCase
some.people.use.periods
And_aFew.People_RENOUNCEconvention

#inspect an object by writing in the console
x
#[1] 12

#Assignment
this_is_a_really_long_name <- 2.5

#to inspect an object type the name "this" and TAB

#To fix a value: 
this_is_a_really_long_name <- 3.5

#Make yet another assignment:

r_rocks <- 2^3

#inspect : object 'r_rock'or 'R_rocks' will not be found
r_rock

R_rocks

#3.4  Calling functions

seq(from = 1, to = 10) #with TAB you can find information from the function

# we can rewrite this as follows:
  
seq(1, 10)

x <- "hello world" #Rstudio assists when typing " because these come in pair
# when a + appears it will be because R in waiting for mor input

#3.5 Exercises

#1. Why does this code not work?
  
my_variable <- 10
my_varıable #it is not the same ı

#2.Tweak each of the following R commands so that they run correctly:
  
  libary(todyverse)
  
  library(tidyverse)
?mpg
ggplot(dTA = mpg) +
  geom_point(map = aes(x = displ y = hwy)) +
  geom_smooth(method = "lm)
  
  ggplot(dTA = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    geom_smooth(method = NULL) 
    ?????
    
# 3 Press Option + Shift + K / Alt + Shift + K. What happens? 
#How can you get to the same place using the menus?

#4. Let’s revisit an exercise from the Section 2.6. 
#Run the following lines of code. Which of the two plots is saved as mpg-plot.png? Why?

my_bar_plot <- ggplot(mpg, aes(x = class)) +
  geom_bar()
my_scatter_plot <- ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave(filename = "mpg-plot.png", plot = my_bar_plot)

#It is saved the first plot because my_bar_plot variable was the one asked for saving. 



#Caused by error:! object 'displ' not found