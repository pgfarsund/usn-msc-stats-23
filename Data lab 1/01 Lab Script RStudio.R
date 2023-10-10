#### DATA LAB 1 ####

# Use the keyboard shortcut "CTRL + Enter" on Windows or "CMD + Enter" on Mac to run a line of code. 

# Using a hashtag (#) will add a comment. Comments will not be part of the code so you can write what you want after a hashtag without thinking about how R code works. 

# For better readability of this script, it is recommended to activate line wrapping. Go to "Tools" in the top menu, then choose "Global options" and then "Code". Activate "Soft Wrap R source files"

# 3. A short introduction to R and RStudio ####

1+1

# How to make an object
a <- 1
a
b <- 1+1
b

# How to create a vector with numbers
c <- 1:10

d <- c(3,6,1,4,3)

# How to write a function
mean(1:10)
mean(c)

# 4. Opening a data file ####

# This function is useful to avoid mess in your environment if you want to start from scratch. It cleans your environment and removes the saved objects, models etc.
rm(list=ls())

sex <- c("male","female","female","male", "male")
weight <- c(73,67,63,81,70)

dataset <- cbind(sex,weight)
View(dataset)

setwd("c:/Users/pgfar/Dropbox/pgfarsund/Misc arbeid/Master Statistikk H22/Master Statistikk H22/Datalabs/Data lab 1/")

titanic <- read.csv("c:/Users/pgfar/Dropbox/pgfarsund/Misc arbeid/Master Statistikk H22/Master Statistikk H22/Datalabs/Datasets for labs/titanic.csv", na.strings=".")

View(titanic) # Opening the dataset in a new tab


?read.csv # opening the help page for the read.csv function we just used. 

# 5. Data classes ####

titanic$Age <- as.numeric(titanic$Age) # changing the data class of the age variable to numeric

# 6. Making a graph of one variable ####

# Histogram
hist(titanic$Age) # standard function to plot a histogram of the age variable
?hist # open help page for hist() function
hist(titanic$Age, breaks = 5) # fewer breaks
hist(titanic$Age, breaks = 30) # more breaks

# Bar chart
counts_class <- table(titanic$PassengerClass) # creates a table containing the number of observations for each passenger class
counts_class # check how this table looks like in the console
barplot(counts_class, main = "Passenger class distribution", xlab = "Passenger class", ylab = "Number of passengers") # Now we can use the table to make a bar graph of the three different passenger classes. Note the use of additional arguments to change the title of the graph, the x-axis and the y-axis 

# We can do the same for the sex variable
counts_sex <- table(titanic$Sex)
barplot(counts_sex, main = "Passenger sex distribution", ylab = "Number of passengers")


# 7.1 Making a graph of two variables (Histograms) ####

# Subsetting with Base R: 
firstclass <- titanic[titanic$PassengerClass=="1st",] # subsetting first class rows with square brackets
secondclass <- titanic[titanic$PassengerClass=="2nd",] # subsetting second class rows with square brackets
thirdclass <- titanic[titanic$PassengerClass=="3rd",] # subsetting third class rows with square brackets


# Now we can plot seperate age histograms for the different passenger classes
hist(firstclass$Age, main = "Age distribution first class passengers", xlab = "Age")
hist(secondclass$Age, main = "Age distribution second class passengers", xlab = "Age")
hist(thirdclass$Age, main = "Age distribution third class passengers", xlab = "Age")

# If we want to use the histograms to compare the age distributions in the different age classes, we should plot them side by side. We can do this with the par() function
par(mfrow=c(3,1)) # plotting three plots underneath each other in one column
hist(firstclass$Age, main = "Age distribution first class passengers", xlab = "Age", ylim = c(0,85)) # we force the y-axis to go from 0 to 85
hist(secondclass$Age, main = "Age distribution second class passengers", xlab = "Age", ylim = c(0,85)) # we force the y-axis to go from 0 to 85
hist(thirdclass$Age, main = "Age distribution third class passengers", xlab = "Age", xlim = c(0,80), ylim = c(0,85)) # we force the y-axis to go from 0 to 85, additionally, we force the x-axis to go from 0 to 80 to match the two first histograms
par(mfrow=c(1,1)) # remember to change the plotting format to one plot at a time


# 7.2 Making a graph of two variables (Other plots) ####
# we can use the sciplot package to create a simple lineplot (or plot of means) that will present the mean and confidence intervals (mean +/- SE) of one response variable for different groups
install.packages("sciplot") # installing package "sciplot", you only need to do this once
library(sciplot) # loading the package "sciplot", you need to do this every time you start RStudio and want to use the package. 
lineplot.CI(data=titanic, x.factor=PassengerClass, response=Age, type = "p") # we specify the dataset used, the factor and the response variable. We also specify that we only want to present points ("p") rather than lines connecting the different groups (here passenger classes)

# creating a strip chart
stripchart(titanic$Age ~ titanic$PassengerClass, vertical = T, method = "stack") # we specify "stack" as the method so that overlapping data points are placed next to each other rather than on top of each other. 

# Question 2 ####

countries <- read.csv("c:/Users/pgfar/Dropbox/pgfarsund/Misc arbeid/Master Statistikk H22/Master Statistikk H22/Datalabs/Datasets for labs/countries2005.csv", na.strings=".", header = TRUE, sep=";")
View(countries)

hist(countries$Birth.rate.crude..per.1000.people.)

countries_fix <- countries[-210,] # removing row 210, you can also remove the row in Excel and import the changed Excel file

# when fixing the dataset in R, we can use the write.csv() function to write the dataset to a new .csv file which we can load the next time we want to use this dataset
write.csv(countries_fix, "c:/Users/pgfar/Dropbox/pgfarsund/Misc arbeid/Master Statistikk H22/Master Statistikk H22/Datalabs/Datasets for labs/countries2005_fix.csv", 
          row.names = F, col.names = T, quote=F)

hist(countries_fix$Birth.rate.crude..per.1000.people.)

# Question 3 ####
battongues <- read.csv("c:/Users/pgfar/Dropbox/pgfarsund/Misc arbeid/Master Statistikk H22/Master Statistikk H22/Datalabs/Datasets for labs/battongues.csv")
View(battongues)

plot(battongues$Tongue.length..mm. ~ battongues$Palate.length.mm., xlab = "Palate length (mm)", ylab = "Tongue length (mm)")


# Question 4 ####
# For the next questions we will use the same dataset (countries_fix). We can attach the dataset. By doing this we tell R that this is the dataset we are working on and we don't need to specify this every single time we want to call a variable from the dataset

attach(countries_fix)

count_continent <- table(Continent)
barplot(count_continent)

hist(Prevalence.of.HIV.total....of.population.ages.15.49.)
lineplot.CI(Continent, Prevalence.of.HIV.total....of.population.ages.15.49., type = "p", ylab = "Prevalence of HIV (% of population age 15-49")


hist(Physicians..per.1000.people.)
lineplot.CI(Continent, Physicians..per.1000.people., type = "p", ylab = "Physicians per 1000 people")
# can't find Physicians..per.1000.people. in my dataset
# choose another variable and do the same procedure

# alternative "solution" is to generate dummy-data:
countries_fix$Physicians..per.1000.people. = floor(runif(n = nrow(countries_fix),
                                                         min = 1, max = 69))
#



hist(Birth.rate.crude..per.1000.people.)
lineplot.CI(Continent, Birth.rate.crude..per.1000.people., type = "p", ylab = "Birthrate per 1000 people")

# Question 5 ####

# a) Male and female life expectancy
plot(Life.expectancy.at.birth.female..years. ~ Life.expectancy.at.birth.male..years., xlab = "Male life expectancy", ylab = "Female life expectancy")

# b) Continent and life expectancy
lineplot.CI(x.factor = Continent, response = Life.expectancy.at.birth.total..years., type = "p", ylab = "Life expectancy")

# c) Literacy rates and life expectancy
plot(Literacy.rate.adult.total....of.people.ages.15.and.above. ~ Life.expectancy.at.birth.total..years., xlab = "Life expectancy", ylab ="Literacy rate")

# d) PCs and life expectancy
plot(Life.expectancy.at.birth.total..years. ~ Personal.computers..per.100.people., xlab ="No. of PCs per 100", ylab = "Life expectancy")

# e) Number of physicians and life expectancy
plot(Life.expectancy.at.birth.total..years. ~ Physicians..per.1000.people.)

detach(countries_fix) # important to detach the dataset when you are finished, otherwise R can become confused when you are starting to work with another dataset

# Question 6 ####
# data collected in class

# Question 7 Mammal dataset ####
# Examine data
MammalsLarge <- read.csv("c:/Users/pgfar/Dropbox/pgfarsund/Misc arbeid/Master Statistikk H22/Master Statistikk H22/Datalabs/Datasets for labs/MammalsLarge.csv", na.strings="")
View(MammalsLarge)
head(MammalsLarge, 10) # shows the 10 first rows in the consolee

counts_continent <- table(MammalsLarge$continent)
barplot(counts_continent) 

MammalsLarge[MammalsLarge=="Af"] <- "AF" # change all occurences of "Af" to "AF" in the dataset

counts_continent <- table(MammalsLarge$continent)
counts_continent

counts_status <- table(MammalsLarge$status)
counts_status

MammalsLarge$log.bodymass <- log10(MammalsLarge$mass.grams) # creating a new variable called "log.bodymass"

# Plots of single variables
barplot(counts_continent)

hist(MammalsLarge$mass.grams, xlab = "Body mass (g)")
hist(MammalsLarge$log.bodymass, xlab = "Body mass (log10)")
hist(MammalsLarge$log.bodymass, xlab = "Body mass (log10)", breaks = 10)
hist(MammalsLarge$log.bodymass, xlab = "Body mass (log10)", breaks = 20)
hist(MammalsLarge$log.bodymass, xlab = "Body mass (log10)", breaks = 50)
hist(MammalsLarge$log.bodymass, xlab = "Body mass (log10)", breaks = 100)

hist(MammalsLarge$log.bodymass, xlab = "Body mass (log10)", freq = F) # display probability density on the y-axis instead og frequency

# Plots of two variables
boxplot(MammalsLarge$log.bodymass ~ MammalsLarge$status, xlab = "Extinction status", ylab = "Body mass (log10)")

tapply(MammalsLarge$log.bodymass, MammalsLarge$status, median, na.rm = T) # calculate median log body mass for every status. NB: na.rm=T is important to remove NA data before calculations. Without this we would not get results for the groups where NA data is present

tapply(MammalsLarge$log.bodymass, MammalsLarge$status, mean, na.rm = T) 
tapply(MammalsLarge$mass.grams, MammalsLarge$status, median, na.rm = T)
