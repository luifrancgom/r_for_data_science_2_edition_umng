
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
#R will ignore anaything after #
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

