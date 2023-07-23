# Libraries ----
library(tidyverse)
library(palmerpenguins)
library(ggthemes)

# 2.2.5 Exercises ----

## How many rows are in penguins? How many columns?
penguins
nrow(penguins)
ncol(penguins)

## What does the bill_depth_mm variable in the penguins 
## data frame describe? Read the help for ?penguins to 
## find out.
help("penguins")

### bill_length_mm: a number denoting bill length 
###                 (millimeters)

## Make a scatterplot of bill_depth_mm vs. bill_length_mm. 
## That is, make a scatterplot with bill_depth_mm on the 
## y-axis and bill_length_mm on the x-axis. Describe the 
## relationship between these two variables.
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(mapping = aes(color = species)) + 
  geom_smooth(method = 'lm') +
  labs(title = "Bill length and bill depth",
       subtitle = "Bill dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill length (mm)", 
       y = "Bill depth (mm)",
       color = "Species", 
       shape = "Species") +
  scale_color_colorblind()

### Simpson's paradox
### https://en.wikipedia.org/wiki/Simpson%27s_paradox
#### Simpson's paradox is a phenomenon in probability and statistics 
#### in which a trend appears in several groups of data but disappears 
#### or reverses when the groups are combined. This result is often 
#### encountered in social-science and medical-science statistics and 
#### is particularly problematic when frequency data are unduly given 
#### causal interpretations.
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = bill_depth_mm,
                     color = species)) +
  geom_point() + 
  geom_smooth(method = 'lm') +
  labs(title = "Bill length and bill depth",
       subtitle = "Bill dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill length (mm)", 
       y = "Bill depth (mm)",
       color = "Species", 
       shape = "Species") +
  scale_color_colorblind()

## What happens if you make a scatterplot of species vs. bill_depth_mm? 
## What might be a better choice of geom?
ggplot(data = penguins,
       mapping = aes(x = species, y = bill_depth_mm,
                     color = species)) +
  geom_point() +
  labs(title = "Bill depth by species",
       subtitle = "Bill depth for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Species", 
       y = "Bill depth (mm)",
       color = "Species", 
       shape = "Species") +
  scale_color_colorblind()

ggplot(data = penguins,
       mapping = aes(x = species, y = bill_depth_mm,
                     color = species)) +
  geom_violin() +
  geom_jitter(width = 0.1) +
  labs(title = "Bill depth distribution by species",
       subtitle = "Bill depth for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Species", 
       y = "Bill depth (mm)",
       color = "Species", 
       shape = "Species") +
  scale_color_colorblind()

## Why does the following give an error and how would you fix it?
ggplot(data = penguins) + 
  geom_point()

### Add aesthetics: x and y
help("geom_point")
#### geom_point() understands the following aesthetics (required 
#### aesthetics are in bold):
#### x
#### y

## What does the na.rm argument do in geom_point()? What is the 
## default value of the argument? Create a scatterplot where you 
## successfully use this argument set to TRUE.
help("geom_point")

### na.rm = FALSE by default
#### If FALSE, the default, missing values are removed with a warning. 
#### If TRUE, missing values are silently removed.
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point(mapping = aes(color = species), na.rm = TRUE) +
  # geom_smooth(method = 'lm') +
  # geom_smooth(method = 'lm', na.rm = TRUE) +
  labs(title = "Bill length and bill depth",
       subtitle = "Bill dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill length (mm)", 
       y = "Bill depth (mm)",
       color = "Species", 
       shape = "Species") +
  scale_color_colorblind()

## Add the following caption to the plot you made in the previous 
## exercise: “Data come from the palmerpenguins package.” Hint: Take a 
## look at the documentation for labs().
help("labs")
### caption: The text for the caption which will be displayed in the 
###          bottom-right of the plot by default.
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = bill_depth_mm,
                     color = species)) +
  geom_point() + 
  geom_smooth(method = 'lm') +
  labs(title = "Bill length and bill depth",
       subtitle = "Bill dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       caption = "Data come from the palmerpenguins package",
       x = "Bill length (mm)", 
       y = "Bill depth (mm)",
       color = "Species", 
       shape = "Species") +
  scale_color_colorblind()

## Recreate the following visualization. What aesthetic should 
## bill_depth_mm be mapped to? And should it be mapped at the 
## global level or at the geom level?
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(color = bill_depth_mm)) + 
  geom_smooth(method = 'loess')

help("geom_smooth")
### method: Smoothing method (function) to use, accepts either 
###         NULL or a character vector, e.g. "lm", "glm", "gam", 
###         "loess" or a function, e.g. MASS::rlm or mgcv::gam, 
###         stats::lm, or stats::loess. "auto" is also accepted 
###         for backwards compatibility. It is equivalent to NULL.

## Run this code in your head and predict what the output will 
## look like. Then, run the code in R and check your predictions.
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g, 
                     color = island)) +
  geom_point() +
  geom_smooth(se = FALSE)

help("geom_smooth")
### se: Display confidence interval around smooth? (TRUE by 
###     default, see level to control.)

## Will these two graphs look different? Why/why not?
### Global level, they’re passed down to each of the subsequent 
### geom layers of the plot
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point() +
  geom_smooth()

### Local level that are added to those inherited from the 
### global level
ggplot() +
  geom_point(data = penguins,
             mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_smooth(data = penguins,
              mapping = aes(x = flipper_length_mm, y = body_mass_g))

# 2.4.3 Exercises ----

## Make a bar plot of species of penguins, where you assign species 
## to the y aesthetic. How is this plot different?
ggplot(penguins, aes(y = species)) +
  geom_bar()

ggplot(penguins, aes(y = fct_infreq(species))) +
  geom_bar()

## How are the following two plots different? Which aesthetic, color 
## or fill, is more useful for changing the color of bars?
ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")

### Nothing helpful here
help("geom_bar")
vignette("ggplot2-specs")
### Goggle it: what is the difference between color and fill ggplot2
#### https://stackoverflow.com/questions/50557718/what-is-the-difference-between-the-color-and-fill-argument-in-ggplot2
#### https://stackoverflow.com/questions/15965870/fill-and-border-colour-in-geom-point-scale-colour-manual-in-ggplot

## What does the bins argument in geom_histogram() do?
help("geom_histogram")
### bins: Number of bins. Overridden by binwidth. 
###       Defaults to 30.
#### Why bins = NULL but it says default to 30?
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(bins = NULL, color = 'black')

ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(bins = 30, color = 'black')

#### Well now I understand the bins argument
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(bins = 10, color = 'black')

## Make a histogram of the carat variable in the diamonds 
## dataset that is available when you load the tidyverse 
## package. Experiment with different binwidths. What 
## binwidth reveals the most interesting patterns?
help("diamonds")
### I don't know how is the weight of a diamond measured
### Let's find out!!!
#### https://en.wikipedia.org/wiki/Carat_(mass)
##### The carat (ct) is a unit of mass equal to 200 mg 
##### (0.00705 oz; 0.00643 ozt), which is used for measuring 
##### gemstones and pearls
help("geom_histogram")
### binwidth: The default is to use the number of bins in bins, 
###           covering the range of the data
(5.01 - 0.2) / 30
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(color = 'black')

ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 1, color = 'black')

ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.1, color = 'black')

#### Here we begin to see something
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.01, color = 'black')

#### Let's deep more
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.001, color = 'black')

##### We need to ask an expert because I don't have
##### a domain knowledge to explain this patterns

# 2.5.5 Exercises ----

## The mpg data frame that is bundled with the ggplot2 package 
## contains 234 observations collected by the US Environmental 
## Protection Agency on 38 car models. Which variables in mpg 
## are categorical? Which variables are numerical? (Hint: Type 
## ?mpg to read the documentation for the dataset.) How can you 
## see this information when you run mpg?
help("mpg")
glimpse(mpg)

### Categorical variables
#### manufacturer
#### model 
#### trans
#### drv
#### fl
#### class

### Numerical variables
#### displ
#### year 
#### cyl
#### cty
#### hwy

## Make a scatterplot of hwy vs. displ using the mpg data frame. 
## Next, map a third, numerical variable to color, then size, 
## then both color and size, then shape. How do these aesthetics 
## behave differently for categorical vs. numerical variables?
ggplot(mpg, aes(x = hwy, y = displ)) +
  geom_point()

ggplot(mpg, aes(x = hwy, y = displ, color = cyl)) +
  geom_point()

ggplot(mpg, aes(x = hwy, y = displ, size = cyl)) +
  geom_point()

ggplot(mpg, aes(x = hwy, y = displ, color = cyl, size = cyl)) +
  geom_point()

ggplot(mpg, aes(x = hwy, y = displ, shape = cyl)) +
  geom_point()

## In the scatterplot of hwy vs. displ, what happens if you 
## map a third variable to linewidth?
ggplot(mpg, aes(x = hwy, y = displ, linewidth = cyl)) +
  geom_point()
help("geom_point")
### geom_point() understands the following aesthetics 
### (required aesthetics are in bold):
#### x, y, alpha, colour, fill, group, shape, size, stroke

## What happens if you map the same variable to multiple aesthetics?
ggplot(mpg, aes(x = hwy, y = displ, color = displ, size = displ)) +
  geom_point()

## Make a scatterplot of bill_depth_mm vs. bill_length_mm and color 
## the points by species. What does adding coloring by species reveal 
## about the relationship between these two variables? What about 
## faceting by species?

### The relationship is negative
ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point()

### Now the relationship is positive
ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm,
                     color = species)) +
  geom_point()

### You can see better that the relationship is positive
ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point() + 
  facet_wrap(facets = vars(species))

## Why does the following yield two separate legends? How 
## would you fix it to combine the two legends?
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = bill_depth_mm, 
                     color = species, shape = species)) +
  geom_point() +
  labs(color = "Species")

### The problem is that the legend label for color is 'Species'
### with upper case but by default the legend laber for shape
### is 'species' with lower case so we need to modify it
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(color = species, shape = species)) +
  labs(color = "Species",
       shape = "Species")

### Another alternative is
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(color = species, shape = species))

## Create the two following stacked bar plots. Which question 
## can you answer with the first one? Which question can you 
## answer with the second one?

### The percentage of each specie in each island
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

### How each specie is distributed in each island
ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")

# 2.6.1 Exercises ----

## Run the following lines of code. Which of the two plots 
## is saved as mpg-plot.png? Why?

# ggplot(mpg, aes(x = class)) +
#   geom_bar()
# ggplot(mpg, aes(x = cty, y = hwy)) +
#   geom_point()
# ggsave("mpg-plot.png")
help("ggsave")
### plot: Plot to save, defaults to last plot displayed.
#### This means that the last plot is the one that is saved

## What do you need to change in the code above to save the plot 
## as a PDF instead of a PNG? How could you find out what types 
## of image files would work in ggsave()?
# ggplot(mpg, aes(x = cty, y = hwy)) +
#   geom_point()
# ggsave("000_images/002_mpg_plot.pdf")
help("ggsave")
### device: Device to use. Can either be a device function (e.g. png), 
###         or one of "eps", "ps", "tex" (pictex), "pdf", "jpeg", 
###         "tiff", "png", "bmp", "svg" or "wmf" (windows only).
