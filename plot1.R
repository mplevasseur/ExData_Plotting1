## Script assumes datafile named "household_power_consumption.txt" is downloaded
## and extracted to your working directory
## Choosing to read full file in for each plot, then subset 
## Not as efficient but does satisfies requirement and offers some flexibility

consumption <- read.table("household_power_consumption.txt" , 
                    header = TRUE, sep = ";", na.strings = "?")

## read statement accounts for header, separator ';' and NA denoted by "?"


## Build a subset of Feb 1 and Feb 2, year 2007 only
## The Date column of input data is in the format d/m/yyyy (day first)

Feb1 <- consumption[consumption$Date == "1/2/2007", ] #subset off the string
Feb2 <- consumption[consumption$Date == "2/2/2007", ] #subset off the string
Feb1n2 <- rbind(Feb1, Feb2)

## Note: used alternate means for labeling plots, rather than converting
## date, time variables to Date/Time class as SUGGESTED in the assignment
     
     ## However, I include the code here I had to show it was not oversight:

     Feb1n2$Date <- as.Date(Feb1n2$Date, "%d/%m/%Y")   
     ## date format needs capital Y, year with century

     ## Adds date/time column combining date/time format
     Feb1n2$DateTime <- paste(Feb1n2$Date, Feb1n2$Time)
     Feb1n2$DateTime <- strptime(Feb1n2$DateTime, "%Y-%m-%d %H:%M:%S")

## Construct histogram - this code will output to screen device first

par(mar=c(6,4,4,2)) 
hist(Feb1n2$Global_active_power, col = "red", ylim = c(0,1200),
     xaxp = c(0,6,3),    # this command sets the x-axis scale based on intervals
     main = "Global Active Power" , 
     xlab = "Global Active Power (kilowatts)")

## Next copy the histogram to a PNG file with a width, height = 480 pixels
## Name each of the plot files as plot1.png, plot2.png, etc.

dev.copy(png, file = "plot1.png", width=480, height=480) 

dev.off() 


## Notes for my reference (ignore):
## can also use library(lubridate)
## d$Time <- dmy_hms(paste(d$Date, d$Time))
## d$Date <- dmy(d$Date)