## R script for Coursera "Exploratory" course, week 1 project, plot 1

# This assignment uses data from the UC Irvine Machine Learning Repository, 
# a popular repository for machine learning datasets.
# More info here: http://archive.ics.uci.edu/ml/

# The data for the project are located here:
#  https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# The objectives of this script are as follows:
# 1) download, unzip, and read in the data.
# 2) plot the first plot (histogram)

##############################
# To run this code, set your desired working directory below

### run these lines if you do not have these packages already installed:
#install.packages("curl")
#install.packages("plyr")
#install.packages("dplyr")
#install.packages("lubridate")
library(curl)
library(data.table)
library(lubridate)

### Set working directory
file_location <- "C:/Users/Jon/Desktop/temp/course4week1/"
setwd(file_location)


##############################
## script for part 1:
## Downloads and unzips the file

# download and read in the data
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataURL, 
              destfile = paste0(file_location, "projectData.zip"),
              method = "curl")
dateDownloaded <- date()

## You will need to unzip these files to the same directory
zipFile <- paste0(file_location, "projectData.zip")
unzip(zipFile)

###############################
## script for plot 1:

## Read in the data:
power_raw <- fread(paste0(file_location, "household_power_consumption.txt"))

## the dates are in dd-mm-yyyy format, read them into date format
power <- power_raw
power$Date <- dmy(power$Date)
## looked to see if 2007-02-01 matches with Thursday (it does)
wday("2007-02-01", label=TRUE)

## keep only the data from Feb 1 and 2, 2017
power <- power[power$Date=="2007-02-01" | power$Date=="2007-02-02",]

## change power from character to numeric
power$Global_active_power <- as.numeric(power$Global_active_power)

## plot the histogram in plot 1 to console
hist(power$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

## plot the histogram in plot 1 to a PNG file
png(paste0(file_location, "plot1.png"))
hist(power$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
