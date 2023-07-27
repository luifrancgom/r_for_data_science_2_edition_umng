# Libraries ----
library(tidyverse)

# 3.5 Exercises ----

## Why does this code not work?
### Check out i vs ı 
my_variable <- 10
my_varıable

## Tweak each of the following R commands so that they run correctly
# libary(todyverse)
# 
# ggplot(dTA = mpg) + 
#   geom_point(maping = aes(x = displ y = hwy)) +
#   geom_smooth(method = "lm)
  
library(tidyverse)
ggplot(data = mpg, 
       mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(method = "lm")

## Press Option + Shift + K / Alt + Shift + K. What happens? How 
## can you get to the same place using the menus?
### Keyboard Shorcut Quick Reference
### Help > Keyboard Shorcuts Help

## Let’s revisit an exercise from the Section 2.6. Run the following 
## lines of code. Which of the two plots is saved as mpg-plot.png? 
## Why?
my_bar_plot <- ggplot(mpg, aes(x = class)) +
  geom_bar()
my_scatter_plot <- ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave(filename = "000_images/003_mpg_plot.png", plot = my_bar_plot)
### With the argument plot we specify which plot to save by overriding
### the default plot = last_plot()
#### Also take into account the working directory which is different
#### in a .R file and in a .qmd file