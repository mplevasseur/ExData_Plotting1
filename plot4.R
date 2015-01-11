
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
## Identifying breaks in days based on dimensions of subset, since must same
## count of data/day and must add day labels anyway at the front and back.

     ## Here is code for converting Date and Time variables to Date/Time classes in R using 
     ## the strptime() and as.Date() functions, add to data in its own column
     ## Feb1n2$Date <- as.Date(Feb1n2$Date, "%d/%m/%Y")   
     ## date format needs capital Y, year with century
     ## Adding a date/time column to combine date/time format so duplicate hours
     ## are tagged with date.  

     ## Feb1n2$DateTime <- paste(Feb1n2$Date, Feb1n2$Time)
     ## Feb1n2$DateTime <- strptime(Feb1n2$DateTime, "%Y-%m-%d %H:%M:%S")

## Construct 4 x 4 plot - this code will NOT output to screen device first
png(filename = "plot4.png", width=480, height=480) # choose output device up front, bypass screen
par(mfrow = c(2,2), mar=c(6,5,2,1))  

## Row Position 1, upper left is Original Plot 2
plot(Feb1n2$Global_active_power, type = "n", xaxt = "n" , xlab="", 
     ylab = "Global Active Power")
lines(Feb1n2$Global_active_power)
axis(1, at = c(0, 1440, 2880), labels = c("Thurs", "Fri", "Sat"))



## Row Position 2 (upper right) is new time series plot for Voltage
plot(Feb1n2$Voltage, type = "n", xaxt = "n" , xlab="", ylab ="Voltage")
lines(Feb1n2$Voltage)
axis(1, at = c(0, 1440, 2880), labels = c("Thurs", "Fri", "Sat"))

mtext("datetime", side =1, line= 3, outer = FALSE, cex = 0.75) #add margin text

## Row position 3 (lower left) is Original Plot 3 for Sub Metering        
     plot(Feb1n2$Sub_metering_1, type = "n", xaxt = "n", xlab = "", ylab = "Energy sub metering")
     #xaxt suppresses x labels for now, yaxt = n in the plots leaves original y axis label
     lines(Feb1n2$Sub_metering_1, yaxt = "n")     
     lines(Feb1n2$Sub_metering_2, col = "red", yaxt = "n")
     lines(Feb1n2$Sub_metering_3, col = "blue", yaxt = "n")

     axis(1, at = c(0, 1440, 2880), labels = c("Thurs", "Fri", "Sat"))

     legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c("black", "red" , "blue"), cex = 0.7)

## Row position 4 (lower right) is for Reactive Power:

     plot(Feb1n2$Global_reactive_power, type = "n", xaxt = "n", xlab = "", ylab = "Global_reactive_power")
     lines(Feb1n2$Global_reactive_power)
     axis(1, at = c(0, 1440, 2880), labels = c("Thurs", "Fri", "Sat"))

     mtext("datetime", side =1, line= 3, outer = FALSE, cex = 0.75) #add margin text

## outer margin datetime label
##     mtext("datetime", side =1, outer = FALSE, adj=0)


dev.off() 


## Notes (ignore):
## png(filename=..., width= 480, height=480)   # choose device.. 
## par(mar=c(6,4,4,2)) 
## plot(..)
## For this plot, appears writing straight to png rather than using dev.copy
## produces better results
## dev.copy(png, file = "plot3.png", width=480, height=480) 
## dev.off() 
## par(new = TRUE)     # allows each successive plot on same graph