## Download, unzip and read file

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "energy.zip", method = "curl")
unzip("energy.zip")
list.files()
energy <- read.table("household_power_consumption.txt",header=T,sep=";",stringsAsFactors=FALSE, dec = ".")

## Convert Date field to POSIXlt

Date <- energy$Date
Date <- strptime(Date, "%d/%m/%Y")
Date1 <- as.POSIXlt("2007-02-01")
Date2 <- as.POSIXlt("2007-02-02")
energy$Date <- Date

## Subset dataset based on the date criteria (2/1/2007 and 2/2/2007)

energy <- subset(energy, subset=(Date >= Date1 & Date <= Date2))

## Convert field to numeric for plot

energy$Global_active_power <- as.numeric(energy$Global_active_power)

## Make histogram

hist(energy$Global_active_power, col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")

## Create png

dev.copy(png, file="Plot1.png", height=480, width=480)
dev.off()
