##Download and unzip given data set for course assignment: 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

if(!file.exists("course_data")) {dir.create("course_data")}
setwd("./course_data")

if(!file.exists("household_power_consumption.zip")) {
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile= "household_power_consumption.zip")
unzip("household_power_consumption.zip", junkpaths=TRUE)
}

##Read in subset of data for only those on 2007-02-01 and 2007-02-02 
library(sqldf)

pdt<-read.csv.sql("household_power_consumption.txt", sql="select * from file where Date in ('1/2/2007','2/2/2007')", sep=";", header=TRUE)

##Convert the Date and Time variables to Date/Time class
pdt$Time<-strptime(paste(pdt$Date,pdt$Time), "%d/%m/%Y %H:%M:%S")
pdt$Date<-as.Date(pdt$Date,"%d/%m/%Y")

##Construct required plot and save to PNG file, closing graphics device when done
# Plot 1
png("plot1.png")
hist(pdt$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off(dev.cur())


setwd("..")
