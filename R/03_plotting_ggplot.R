#------------------------------------------------------#
# 3. Plotting in R using grammar of graphics (ggplot2) #
#------------------------------------------------------#

# presented by Xavier Giroux-Bougard
# material by Etienne Low-Decarie

#### 0. Housekeeping ####

# clean up everything in your current working directory
rm(list=ls())

# install and/or load required packages
if(!require(ggplot2)){install.packages("ggplot2")}
require(ggplot2)

#### 1. Basic scatter plot ####

# Explore the qplot help file
?qplot

# Explore the Iris dataset
data(iris)
?iris
head(iris)
str(iris)
names(iris)

# Most basic scatter plot
basic.plot<-qplot(data=iris,
                  x=Sepal.Length,
                  y=Sepal.Width)
print(basic.plot)

# Most basic scatter plot (categorical data)
categorical.plot<-qplot(data=iris,
                        x=Species,
                        y=Sepal.Width)
print(categorical.plot)

# Edited most basic scatter plot
basic.plot<-qplot(data=iris,
                  x=Sepal.Length,
                  xlab="Sepal Length (mm)",
                  y=Sepal.Width,
                  ylab="Sepal Width (mm)",
                  main="Sepal dimensions")
print(basic.plot)

#------------#
# Exercise 1 # 
#------------#


#### 2. Grammar of graphics ####

#### 2.1 Adding aesthetics and geoms ####

# Adding aesthetic to basic scatter plot
basic.plot <- basic.plot +
              aes(color = Species, 
              shape = Species)

# Adding geoms to basic scatter plot
linear.smooth.plot <- basic.plot + 
                      geom_smooth(method="lm", se = FALSE)
print(linear.smooth.plot)

plot.with.line<-basic.plot+geom_line()
print(plot.with.line)

plot.with.linear.smooth<-basic.plot+geom_smooth(method="lm", se=F)
print(plot.with.linear.smooth)

plot.smooth.on.all<-basic.plot+geom_smooth(method="lm", aes(group=1))
print(plot.smooth.on.all)

plot.with.smooth.on.all.and.species<-plot.with.linear.smooth+geom_smooth(method="lm", aes(group=1))
print(plot.with.smooth.on.all.and.species)

# Adding geoms to basic categorical plot
categorical.plot<-qplot(data=iris,
                        x=Species,
                        y=Sepal.Width)
print(categorical.plot)

boxplot <- categorical.plot + 
           geom_boxplot()
print(boxplot)

#------------#
# Exercise 2 # 
#------------#

#### 2.2 Adding facets and groups

# basic plot from CO2
CO2.plot <- qplot(data = CO2,
                  x = conc,
                  y = uptake,
                  colour = Treatment)
print(CO2.plot)

# Adding facets
CO2.plot<-CO2.plot + 
          facet_grid(.~Type)
print(CO2.plot)

# Adding line geoms
print(CO2.plot + geom_line())

# Specifying groups
CO2.plot <- CO2.plot + 
            geom_line(aes(group = Plant))
print(CO2.plot)

#------------#
# Exercise 3 # 
#------------#


#### 3. Saving plots ####

pdf(“./plots/todays_plots.pdf”)
print(basic.plot)
print(plot.with.linear.smooth)
print(categorical.plot)
print(CO2.plot)
graphics.off()

#### 4. Fine tunning ####

#### 4.1 Fine tunning colours ####
CO2.plot+scale_colour_manual(values=c("nonchilled"="red","chilled"="blue"))

# Bonus!!! Wes Anderson colour palette
if(!require(devtools)) {install.packages("devtools")}
require(devtools)
devtools::install_github("wesanderson","karthik")
require(wesanderson)

ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) + 
  geom_point(size = 5) + 
  scale_color_manual(values = wes.palette(3, "Darjeeling")) 

#### 4.2 Fine tunning scales ####
CO2.plot + scale_y_continuous(name = "CO2 uptake rate",
                              breaks = seq(5,50, by= 10),
                              labels = seq(5,50, by= 10), 
                              trans="log10")

#### 4.3 Fine tunning themes ####
CO2.plot + theme_bw()

#### 5 Bonus!!! ####

#### 5.1 ecologists who may become vegan users ####
install_github("ggvegan", "gavinsimpson")
require(ggvegan)
data(dune)
data(dune.env)
sol <- cca(dune ~ A1 + Management, data = dune.env)
autoplot(sol)
data(mite)
data(mite.env)
mite.hel = decostand(mite, "hel")
rda <- rda(mite.hel ~ WatrCont + Shrub, mite.env)  # Model with all explanatory variables
ggvegan.plot <- autoplot(rda) + theme_bw()
normal.plot <- plot(rda)





