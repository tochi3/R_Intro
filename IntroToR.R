# Introduction to R
# Instructors:
# Ameet Doshi ameet.doshi@library.gatech.edu
# Jay Forrest jay.forrest@library.gatech.edu

# Getting Started
# You can find R at https://cran.r-project.org/
# You cand find R Studio at https://www.rstudio.com/

# Finding Inspiration
# R Graph Gallery:  https://www.r-graph-gallery.com/

# Creating a project
# File->New Project
# New Directory
# Empty R Project
# Let's call the new directory Rclass and save it to 
# the Documents folder. We can confirm the working 
# directory by using the getwd() command in an R file 
# or directly in the console
getwd()
# We can see files in our working directory in the 
# files box in the lower helright
# You can change the working directory by using setwd( dir ) 
# By using setwd() we see the structure of an 
# R function  FunctionName ( parameters )
# To view examples of any R command, simply list it as 
# a parameter of the help function
help(setwd)
# Help will tell us which R package the command comes from, 
# example usage, and information about the va

# Now lets create a simple program
# Create a new R file by going to File->New File->R Script
# An untitled window will open like this one.
# Press the save icon and call it RClass
# Note R files get a suffix of .R 
# At the top of the screen you can see if your work 
# is unsaved by the rust text and * after the .R
# the .Rproj file includes information about what windows are open, etc

# Start with a comment by using a hastag then space and then text.
# R does not execute comments
# For multiline comments use a # at the beginning of each 
# line R lines are 80 characters wide

setwd("Z:/INTRODUCTION_TO_R_STUDIO/")
setwd(choose.dir()) 

# My first R program
# now lets create a variable named introString and assign it 
# with the assignment operator <- a value
introString <- "Intro to R Studio"
# When we run the line we can see that the variable 
# now shows in the Environment pane

# Now lets print it to the console
print( introString ) # we can also make a comment after a line

# A note about the run command, R will try to execute up 
# to the current line
# So if I reassign introString, but place the cursor on in
# this line and use Run, I won't execute anything after this line
introString <- "Intro to R with Ameet and Jay"

# You can see in the console below what is running ihn 
# blue as well as any output
# You can also see your command history in the history 
# tab in the upper right 
# or by clicking the up arrow at the command line in the console

# Here are some style tips for make your R files easier 
# to understand and read: 
# https://google.github.io/styleguide/Rguide.xml

# Now that are data is ready we will add the rpart package 
# to do the analysis. There are over 13,800 packages that 
# folks have developed for R (and contributed to CRAN)
# These packages allow us to do specialized analysis based on 
# functions that others have coded
# You can find a list with brief descriptions here: 
# https://cran.r-project.org/web/packages/
# By clicking a link, you can find a full description of the package, 
# examples and what other packages are required
# Just as you would in the help file.
# I am going to install the corrplot package to my local instance of r.  
# Please note, I only need to do this once per install.
install.packages("corrplot")

# Now lets work with some data
# Lets grab some data from the UCI Machine Learning Repository
# http://archive.ics.uci.edu/ml/index.php
# Lets look at Bike Sharing: 
# https://archive.ics.uci.edu/ml/datasets/bike+sharing+dataset
# Download the Zip File, Open it, and Extract day.csv to your 
# R Working Directory
# Look at the files tab in the bottom right to confirm the file location

# Load the data file
capitalBikeShareData <- read.csv('day.csv', header = TRUE)
capitalBikeShareData <- read.csv(file.choose(), header = TRUE)
# Here we created a new variable capitalBikeShareData, 
# and assigned it the values from a csv file.  
# We included the file name in single 
# quotes and as the first line of this file includes column names 
# We used the header parameter TRUE  (Numeric and Boolean values 
# as well as variables do not need quotes). Also, all of our 
# manipulation (later) is being done on the data frame, 
# not on the orginal data.

# In the environment tab we can see that myBike data contains 
# 16 attributes or variables and 731 observations or rows
# Lets look at the data
capitalBikeShareData

# We can also look at the first few or last few lines
head(capitalBikeShareData)

# Or last few lines
tail(capitalBikeShareData)

# we can also specify how main lines to display
tail(capitalBikeShareData, n=10L)
sampleDataFrame <- tail(capitalBikeShareData, n=10L)

# Lets compare this data to the metadata from the originating site


# Now lets do some basic comparisons, like min/max, quartiles 
# and median values
summary(capitalBikeShareData)

# Lets plot two variables to see if they relate
plot(capitalBikeShareData$casual, capitalBikeShareData$windspeed)

# The first two parametes of plot are the x and y values, 
# we can plot against any data set that we have
# and we can pick variables by calling them after the $

# What does this chart tell us?
# Lets look at the correlation coefficient
cor(capitalBikeShareData$casual, capitalBikeShareData$windspeed)

# Correlation provides a value between -1 and 1 that tells us 
# about the strength and direction of two variables
# In this example we see a weak negative correlation, 
# lower wind speeds correlate to more riders

# Now lets create a regression model
fit <-lm(casual ~ windspeed, data=capitalBikeShareData)
# We named the model fit and assigned it the result of a 
# linear model where 
# the dependent variable is casual
# we have one independent variable, windspeed
# and or data is coming from the capitalBikeShareData data set

# We can also write the model like this
fit <-lm(capitalBikeShareData$casual ~ capitalBikeShareData$windspeed)

# Calling fit will display the formula and coefficients
fit

# Summary fit will give us additional details
summary(fit)

# We can see how well our model fits the data by looking at the r-squared
# R squared is a value between 0 and 1 and values closer to 1
# have a better goodness of fit

# Here is how to produce a graph of the linear model
plot(fit)

# Chart explanations (Ameet)

# What other variables do you think would work?

# Multivariate model (Ameet)
# Lets combine the best three into a model
multivariateFit <-lm(capitalBikeShareData$casual ~ 
                       capitalBikeShareData$windspeed + 
                       capitalBikeShareData$weathersit + 
                       capitalBikeShareData$temp)

# Did this improve the model
summary(multivariateFit)
plot(multivariateFit)

# Correlation coefficients (Jay/Ameet)
cleanBikeData <- capitalBikeShareData[ , -(2)] 
# we need to remove the non-numeric columns
# Here is what we are doing
# We are creating a new data frame cleanBikeData
# pulling data from capitalBikeShareData
# pulling all rows -- [ ,
# and remove the second column -- -(2)]
round(cor(cleanBikeData),2) # rounding for display

# This is a little hard to read just as a text file, so lets use a package,
# to see a graphical version.  We will talk about installing packages
# a little later.
# install.packages("corrplot") # installing the corrplot package
library(corrplot) # activating the corrplot package
corrplot(cor(cleanBikeData))

# Note the autocorrelation between temp & atemp and cnt & registered, 
# we may use 1, but should not use both of these variables

# From the correlation matrix we can see better correlations 
# (closer to 1 or -1) between casual and year, season, workingday, 
# temp, atemp, and cnt
# Why might we exclude some of these values?
# A better model?
multivariateFit2 <-lm(capitalBikeShareData$casual ~ 
                        capitalBikeShareData$season + 
                        capitalBikeShareData$workingday + 
                        capitalBikeShareData$temp)

summary(multivariateFit2)

# A large dataset
install.packages("nycflights13")
library(nycflights13)

# Helper packages - meet skimr
install.packages("skimr")
library(skimr)

install.packages("Hmisc")
library(Hmisc)

summary(flights)
skimr::skim(flights)

factor(flights$carrier)
table(flights$carrier)

# Corrplot
corrplot::corrplot(cor(flights[complete.cases(flights),c("air_time", "distance",
                                           "arr_delay", "dep_delay", "day", 
                                           "dep_time", "month", "hour",
                                           "sched_dep_time", "sched_arr_time")]))


# Decision Tree
# We will use the rpart package to create a decision tree,
# so lets install rpart, and then call it as a library
# And do the same for the rpart.plot which contains the 
# titanic data and a better plotting tool
install.packages("rpart")
install.packages("rpart.plot")
install.packages("rattle")
install.packages("RColorBrewer")
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)

data("ptitanic")

# creating a decision tree
# note that ~. is a short cut for all columns
# the cp argument is a complexity parameter: 
# Any split that does not decrease the overall lack of fit 
# by a factor of cp is not attempted. 
decisionTreeBinary <- rpart(survived ~ . , data = ptitanic, cp=0.12)
fancyRpartPlot(decisionTreeBinary)

# Each node shows
# - the predicted class (died or survived),
# - the predicted probability of survival,
# - the percentage of observations in the node.