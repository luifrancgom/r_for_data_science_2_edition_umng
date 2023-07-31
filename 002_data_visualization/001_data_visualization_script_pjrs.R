


# Librerias ---- 
library(tidyverse)
library(palmerpenguins)
library(ggthemes)

#Do penguins with longer flippers weigh more or less than 
#penguins with shorter flippers? 
#What does the relationship between flipper length 
#and body mass look like? Is it positive? Negative? Linear? 
#Nonlinear? Does the relationship vary by the species of the penguin? How about by the island where the penguin lives?

palmerpenguins::penguins
penguins #otra forma de correr la data

# preview of data frame penguins
View(penguins)
?penguins #to learn more about 

ggplot(data = penguins) #it´s empty because it needs to be told how to visualize the data

#mapping argument defines how variables are mapped in  aes() function of x and y
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
)  # it is not defined how to represent penguins data 

#bar charts use bar geoms (geom_bar()), line charts use line geoms 
#(geom_line()), boxplots use boxplot geoms (geom_boxplot()), 
#scatterplots use point geoms (geom_point()), and so on.

geom_point() # adds a layer of points to your plot, which creates a scatterplot

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +  geom_point()

#does the relationship between flipper length and body mass differ by species?
#we need to change aesthetic, in different colors
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point()

#agregando línea de tendencia, con una curva suave "smooth"
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point() +
  geom_smooth()

#colocando un color para sólo la función de puntos
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species)) +
  geom_smooth(method = "lm")

#use different shapes for each species of penguins and improve labels.
#map species to the shape aesthetic.
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm")

#adding labels to the gragh
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind() 

#theme_excel_new() estilo gráfico de excel

##Exercises
# 1. How many rows are in penguins? How many columns?
View(penguins) #344 entries, 8 total columns

#2. What does the bill_depth_mm variable in the penguins data frame describe? Read the help for ?penguins to find out
?penguins 
#bill_depth_mm a number denoting bill depth (millimeters)
  
#3. Make a scatterplot of bill_depth_mm vs. bill_length_mm. 
#That is, make a scatterplot with bill_depth_mm on the y-axis and bill_length_mm on the x-axis. 
#Describe the relationship between these two variables

ggplot(
     data = penguins,
     mapping = aes(x = bill_length_mm, y = bill_depth_mm)
   ) +
   geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm")

ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm, color = species, shape = species)
) +
  geom_point() +
  geom_smooth(method = "lm")
#Es una relación decreciente, entre más largo el pico menos profundidad tendrá. 
#sin embargo, las especies tienden a diferenciarse por el largo de su pico. Las observaciones tienden a ser dispersas
#y con algunos casos atípicos. 

#What happens if you make a scatterplot of species vs. bill_depth_mm? What might be a better choice of geom?
#Se requiere un gráfico de boxplot

ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)
) +  geom_boxplot()


#Why does the following give an error and how would you fix it?

ggplot(data = penguins) + 
  geom_point() #hace falta definir qué graficar, los ejes y definir cada variablede cada eje

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +  geom_point()

#What does the na.rm argument do in geom_point()?
#You can use the argument na.rm = TRUE to exclude missing values when calculating descriptive statistics in R
#What is the default value of the argument? FALSE 
#Create a scatterplot where you successfully use this argument set to TRUE

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +  geom_point(na.rm = TRUE)

#7. Add the following caption to the plot you made in the previous exercise: 
#“Data come from the palmerpenguins package.” 
#Hint: Take a look at the documentation for labs()
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +  geom_point(na.rm = TRUE) +
  labs(
    caption = "Data come from the palmerpenguins package"
  ) 

#8. Recreate the following visualization. 
#What aesthetic should bill_depth_mm be mapped to? in color
#And should it be mapped at the global level or at the geom level? global

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = bill_depth_mm)
) +  geom_point() + 
  geom_smooth()


#9. la línea de tendencia la toma global, por eso hay 3. 
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = TRUE) 

#se = FALSE no muestra los errores estandar 

#10. Will these two graphs look different? Why/why not?
#No. son el mismo, pues tienen la misma programación desde lo geométrico. 
#() significa NULL, sin modificación. 

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  )

#2.3

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

#otra forma de llamar la data, con pipe
penguins |> 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

#variable categorica
ggplot(penguins, aes(x = species)) + 
  geom_bar()

#transforma var categorica a factor
ggplot(penguins, aes(x = fct_infreq(species))) +
  geom_bar()

#para ver variables numéricas se usan histogramas
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 200)

# binwith determina el ancho de banda del histograma
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 2000)
#para conocer la densidad
ggplot(penguins, aes(x = body_mass_g)) +
  geom_density()


#exercises 2.4.3
#Make a bar plot of species of penguins, where you assign species to the y aesthetic. 
#How is this plot different? Muestra el histograma de forma horizontal

ggplot(penguins, aes(y = fct_infreq(species))) +
  geom_bar()

#How are the following two plots different? Which aesthetic, color or fill, 
#is more useful for changing the color of bars?
#fill rellena el color en las barras, color solo delinea

ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")

#What does the bins argument in geom_histogram() do?
# bars of the histogram, it can be customized with the bins argument 

ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(bins = 50)

#Make a histogram of the carat variable in the diamonds dataset 
#that is available when you load the tidyverse package. 
#Experiment with different binwidths. What binwidth reveals the most interesting patterns?

ggplot(diamonds, aes(x = carat)) + 
  geom_bar()
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.2)

#2.5 Visualizing relationships

#boxplot 
ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()
#density plot
ggplot(penguins, aes(x = body_mass_g, color = species)) +
  geom_density(linewidth = 0.75)

#color a especies, relleno  y transparencia (alpha)
ggplot(penguins, aes(x = body_mass_g, color = species, fill = species)) +
  geom_density(alpha = 0.5)

#We can use stacked bar plots to visualize the relationship between two categorical variables. 
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar() # the percentage balance within each island?

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

# A scatterplot is used for visualizing the relationship between two numerical variables.
#we can incorporate more variables into a plot by mapping them to additional aesthetics
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = island))


#split your plot into facets, subplots that each display one subset of the data.
#variable trough facet_wrap() must be categorical

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)

#2.5.5 Exercises
# 1. Which variables in mpg are categorical? Which variables are numerical?
?mpg #The mpg data frame that is bundled with the ggplot2 package
View(mpg)

#categorial = manufacturer, model, year, trans, drv, fl, class
#nunmerical = displ, cyl, cty, hwy

#2. Make a scatterplot of hwy vs. displ using the mpg data frame.
ggplot(mpg, aes(x = hwy, y = displ)) +
  geom_point()
#3. Next, map a third, numerical variable to color, then size, then both color and size, then shape. 
ggplot(mpg, aes(x = hwy, y = displ)) +
  geom_point(aes(color = cty))
#4. What happens if you map the same variable to multiple aesthetics?

ggplot(mpg, aes(x = hwy, y = displ)) +
  geom_point(aes(size = cty))

ggplot(mpg, aes(x = hwy, y = displ)) +
  geom_point(aes(color = cty, size = cty))

ggplot(mpg, aes(x = hwy, y = displ)) +
  geom_point(aes(color = cty, size = cty, shape = fl))

#How do these aesthetics behave differently for categorical vs. numerical variables?

#5. Make a scatterplot of bill_depth_mm vs. bill_length_mm 
#and color the points by species. 
ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point(aes(color = species))

#What does adding coloring by species reveal about the relationship between these two variables? 
#Es posible identificar cuáles especies tienen el pico más largo y cuáles las de mayor profundidad. 
#Se puede ver claramente las tendencias por especie
#What about faceting by species?

#6. Why does the following yield two separate legends? 
#utiliza dos veces aestethics color, una global y otra local. 
#Además, la capa pide una nueva leyenda llamada "Species"

ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() +
  labs(color = "Species")

#How would you fix it to combine the two legends?
ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() +
  labs()

#7. Create the two following stacked bar plots. 

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")
#Which question can you answer with the first one? #What % of species was found in each island? What % of species can you find per island? 
ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")
#Which question can you answer with the second one? what % of each species can you find in each island? 
#I think I can answer the same question. 

# 2.6 Saving your plots: ggsave()

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()
ggsave(filename = "penguin-plot.png")

#2.6.1 Exercises
# Which of the two plots is saved as mpg-plot.png? Why?
#The last one, by default ggsave() save the last plot displayed.
ggplot(mpg, aes(x = class)) +
  geom_bar()
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave("mpg-plot.png")

#What do you need to change in the code above to save the plot as a PDF instead of a PNG? 
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave("mpg-plot.pdf")
#How could you find out what types of image files would work in ggsave()?
#Reading about: "eps", "ps", "tex" (pictex), "pdf", "jpeg", "tiff", "png", "bmp", "svg" or "wmf" (windows only).

#Common problems: 
#Write ( without ) or "with no closing" 

# + must be at the end of the line
ggplot(data = mpg) 
+ geom_point(mapping = aes(x = displ, y = hwy))

#You can ask fot R help by writing ?function_name in the console or F1 + the function
#Or simply read the error message or Google it
