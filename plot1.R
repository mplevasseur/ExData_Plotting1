## Script assumes datafile named "household_power_consumption.txt" is downloaded
## and extracted to your working directory
## One alternative is to read the data from just those dates, but choosing to read, then subset


consumption <- read.table("household_power_consumption.txt" , header = TRUE, sep = ";", na.strings = "?")
## read statement accounts for header, variables separated by ';' and NA denoted by "?"

## Building a subset of Feb 1 and Feb 2, year 2007 only
## The Date column is in the format d/m/yyyy (day first)

Feb1 <- consumption[consumption$Date == "1/2/2007", ]
Feb2 <- consumption[consumption$Date == "2/2/2007", ]
Feb1n2 <- rbind(Feb1, Feb2)

     ## convert the Date and Time variables to Date/Time classes in R using 
     ## the strptime() and as.Date() functions. This is not explicitly used for plot 1.

     Feb1n2$Date <- as.Date(Feb1n2$Date, "%d/%m/%Y")   
     ## date format needs capital Y, year with century

     ## Adding a date/time column combining date/time format so duplicate hours are tagged with date
     ## This is not used on plot 1.

     Feb1n2$DateTime <- paste(Feb1n2$Date, Feb1n2$Time)
     Feb1n2$DateTime <- strptime(Feb1n2$DateTime, "%Y-%m-%d %H:%M:%S")

## Construct histogram - this code will output to screen device first

par(mar=c(6,4,4,2)) 
hist(Feb1n2$Global_active_power, col = "red", ylim = c(0,1200),
     xaxp = c(0,6,3),
     main = "Global Active Power" , 
     xlab = "Global Active Power (kilowatts)")


## Next copy this histogram to a PNG file with a width of 480 pixels and a height of 480 pixels
## Name each of the plot files as plot1.png, plot2.png, etc.


dev.copy(png, file = "plot1.png", width=480, height=480) 

dev.off() 


## Notes for my reference (ignore):
## can also use library(lubridate)
## d$Time <- dmy_hms(paste(d$Date, d$Time))
## d$Date <- dmy(d$Date)