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


#############################
## Script for plot 3:


## Read in the data:
power_raw <- fread(paste0(file_location, "household_power_consumption.txt"))

## set working version
power <- power_raw

## the dates are in dd-mm-yyyy format, read them into date format
power$date_time <- paste(power$Date, power$Time)
power$Date <- dmy(power$Date)

## keep only the data from Feb 1 and 2, 2017
power <- power[power$Date=="2007-02-01" | power$Date=="2007-02-02",]

## change date/time from character to date format
power$date_time <- dmy_hms(power$date_time)

## change power from character to numeric
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)

## send the plot for plot 3 to the console
plot(power$date_time, power$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
points(power$date_time, power$Sub_metering_2, type="l", col="red")
points(power$date_time, power$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd=c(2.5, 2.5, 2.5), col=c("black", "red", "blue"))

## send the plot for plot 3 to a PNG file
png(paste0(file_location, "plot3.png"))
plot(power$date_time, power$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
points(power$date_time, power$Sub_metering_2, type="l", col="red")
points(power$date_time, power$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd=c(2.5, 2.5, 2.5), col=c("black", "red", "blue"))
dev.off()
