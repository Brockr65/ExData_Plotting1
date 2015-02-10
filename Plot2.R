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

energy$Global_active_power <- as.numeric(energy$Global_active_power)
energy$datetime <- as.POSIXct(energy$datetime)

## Create line plot

plot(energy$Global_active_power~energy$datetime,type="l", ylab = "Global Active Power (kilowatts)", xlab = "")

## Create PNG

dev.copy(png, file="Plot2.png", height=480, width=480)
dev.off()