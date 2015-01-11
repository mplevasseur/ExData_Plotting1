## Script assumes datafile named "household_power_consumption.txt" is downloaded,
## and extracted to your working directory
## A different alternative (not used) is to read the data from just those dates

consumption <- read.table("household_power_consumption.txt", 
                    header = TRUE, sep = ";", na.strings = "?")

## read statement accounts for header, variables separated by ';' and NA denoted by "?"

## Building a subset of Feb 1 and Feb 2, year 2007 only
## The Date column is in the format d/m/yyyy (day first)

Feb1 <- consumption[consumption$Date == "1/2/2007", ]
Feb2 <- consumption[consumption$Date == "2/2/2007", ]
Feb1n2 <- rbind(Feb1, Feb2)

     ## convert the Date and Time variables to Date/Time classes in R using 
     ## the strptime() and as.Date() functions, not explicitly used for plot 2

     ## Following Date conversion not used for plot 2
     ## Feb1n2$Date <- as.Date(Feb1n2$Date, "%d/%m/%Y")   
     ## date format needs capital Y, year with century

     ## Adding a date/time column to combine date/time format so duplicate hours
     ## are tagged with date.  This is not used on plot 2.

     ## Feb1n2$DateTime <- paste(Feb1n2$Date, Feb1n2$Time)
     ## Feb1n2$DateTime <- strptime(Feb1n2$DateTime, "%Y-%m-%d %H:%M:%S")

## Construct Time Series Plot - this code will output to screen device first

par(mar=c(6,5,4,2))
plot(Feb1n2$Global_active_power, type = "n", xaxt = "n" , xlab="", ylab = "Global Active Power (kilowatts)")
lines(Feb1n2$Global_active_power)
axis(1, at = c(0, 1440, 2880), labels = c("Thurs", "Fri", "Sat"))

## Next copy plot to a PNG file with a width of 480 pixels and a height of 480 pixels
## Name each of the plot files as plot2.png, etc.


dev.copy(png, file = "plot2.png", width=480, height=480) 
dev.off() 





