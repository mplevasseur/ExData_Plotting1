## Script assumes datafile named "household_power_consumption.txt" is downloaded 
## and extracted to your working directory

# reads file in a table format and creates a data frame from it

consumption <- read.table("household_power_consumption.txt" ,  
                          header = TRUE, sep = ";", na.strings = "?") 

# subset the two dates needed, pull out 2880 rows, 1440 obs for each day

Feb1 <- "1/2/2007"
Feb2 <- "2/2/2007"
Feb1n2 <- consumption[consumption$Date == Feb1 | consumption$Date == Feb2, ]

png(filename = "PA1_plot1.png", width=480, height=480) 
# choose output device directly

par(mar=c(6,5,4,1))  
hist(Feb1n2$Global_active_power, col = "red", ylim = c(0,1200), 
    xaxp = c(0,6,3),    # this command sets the x-axis scale based on intervals 
    main = "Global Active Power" ,  
    xlab = "Global Active Power (kilowatts)") 

dev.off()  



