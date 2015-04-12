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
png(filename = "PA1_plot2.png", width=480, height=480) 

# plot commands - intialize without axis and add axis in with needed day labels
par(mar=c(6,5,4,2)) 
plot(Feb1n2$Global_active_power, type = "n", xaxt = "n" , xlab="", ylab = "Global Active Power (kilowatts)") 
lines(Feb1n2$Global_active_power) 
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat")) 

dev.off()
