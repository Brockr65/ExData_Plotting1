## Download, unzip and read file

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "energy.zip", method = "curl")
unzip("energy.zip")
list.files()
energy <- read.table("household_power_consumption.txt",header=T,sep=";",stringsAsFactors=FALSE, dec = ".")

## Convert Date and time fields to a new datetime field

datetime <- paste(energy$Date,energy$Time,sep=" ")
datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")
energy$datetime <- datetime

## Subset data based on date range

energy <- subset(energy, subset=(datetime >= "2007-02-01 00:00:00" & datetime < "2007-02-03 00:00:00"))

## Convert fields to data types that allow for plots

energy$datetime <- as.POSIXct(energy$datetime)
energy$Sub_metering_1 <- as.numeric(energy$Sub_metering_1)
energy$Sub_metering_2 <- as.numeric(energy$Sub_metering_2)
energy$Sub_metering_3 <- as.numeric(energy$Sub_metering_3)

## Create line plot with 3 lines plotted

plot(energy$datetime, energy$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(energy$datetime, energy$Sub_metering_1, type = "l")
lines(energy$datetime, energy$Sub_metering_2, type = "l", col = "red")
lines(energy$datetime, energy$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_Metering_3"), lty = 1, col = c("black","red","blue"))

## Create PNG

dev.copy(png, file="Plot3.png", height=480, width=480)
dev.off()