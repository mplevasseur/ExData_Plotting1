## Script assumes datafile named "household_power_consumption.txt" is downloaded 
## and extracted to your working directory

# reads file in a table format and creates a data frame from it

consumption <- read.table("household_power_consumption.txt" ,  
                          header = TRUE, sep = ";", na.strings = "?") 

# subset the two dates needed, pull out 2880 rows, 1440 obs for each day
Feb1 <- "1/2/2007"
Feb2 <- "2/2/2007"
Feb1n2 <- consumption[consumption$Date == Feb1 | consumption$Date == Feb2, ]

## Convert the Date column to date format and combine with time to form a 
## DateTime variable for plotting individual readings

Feb1n2$Date <- as.Date(Feb1n2$Date, "%d/%m/%Y")    
## date format needs capital Y, year with century 

## Add date/time column combining date/time format 
Feb1n2$DateTime <- paste(Feb1n2$Date, Feb1n2$Time) 
Feb1n2$DateTime <- strptime(Feb1n2$DateTime, "%Y-%m-%d %H:%M:%S") 

Feb1n2 <- Feb1n2[, c(10, 1:9)]  #reorders the columns to get DateTime first

# choose output device directly
png(filename = "PA1_plot3.png", width=480, height=480) 

par(mar=c(6,6,4,4))
## par(new = TRUE)     # this allows each successive plot on same graph

plot(Feb1n2$Sub_metering_1, type = "n", xaxt = "n", xlab = "", ylab = "Energy sub metering")
#xaxt suppresses x labels for now, yaxt = n in the plots leaves original y axis label

lines(Feb1n2$Sub_metering_1, yaxt = "n")     
lines(Feb1n2$Sub_metering_2, col = "red", yaxt = "n")
lines(Feb1n2$Sub_metering_3, col = "blue", yaxt = "n")

axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c("black", "red" , "blue"), cex = 0.9)


dev.off()

