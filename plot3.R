
## Script assumes datafile named "household_power_consumption.txt" 
## is downloaded and extracted to your working directory
## An alternative (not used) is to read the data from just those dates

consumption <- read.table("household_power_consumption.txt", 
                          header = TRUE, sep = ";", na.strings = "?")

## read statement accounts for header, variables separated by ';' and NA as "?"

## Build a subset of Feb 1 and Feb 2, year 2007 only
## The Date column is in the format d/m/yyyy (notice day comes first)

Feb1 <- consumption[consumption$Date == "1/2/2007", ]
Feb2 <- consumption[consumption$Date == "2/2/2007", ]
Feb1n2 <- rbind(Feb1, Feb2)

## Using alternative to converting date/time for labels, this code not essential
     ## convert Date and Time variables to Date/Time classes in R using 
     ## the strptime() and as.Date() functions, add to data in its own column
     ## Feb1n2$Date <- as.Date(Feb1n2$Date, "%d/%m/%Y")   
     ## date format needs capital Y, year with century
     ## Adding a date/time column to combine date/time format so duplicate hours
     ## are tagged with date.  This is not used on plot 3.

     ## Feb1n2$DateTime <- paste(Feb1n2$Date, Feb1n2$Time)
     ## Feb1n2$DateTime <- strptime(Feb1n2$DateTime, "%Y-%m-%d %H:%M:%S")

## Construct line overlay plot - this code will output to screen device first

par(mar=c(6,6,4,4))
## par(new = TRUE)     # this allows each successive plot on same graph

plot(Feb1n2$Sub_metering_1, type = "n", xaxt = "n", xlab = "", ylab = "Energy sub metering")
#xaxt suppresses x labels for now, yaxt = n in the plots leaves original y axis label

lines(Feb1n2$Sub_metering_1, yaxt = "n")     
lines(Feb1n2$Sub_metering_2, col = "red", yaxt = "n")
lines(Feb1n2$Sub_metering_3, col = "blue", yaxt = "n")

axis(1, at = c(0, 1440, 2880), labels = c("Thurs", "Fri", "Sat"))

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c("black", "red" , "blue"), cex = 0.6)

## Next copy plot to a PNG file with a width of 480 pixels and a height of 480 pixels
## Name each of the plot files as plot3

dev.copy(png, file = "plot3.png", width=480, height=480) 
dev.off() 
