###############################################
# Exploratory data analysis
# Course project #1
# dataset comes from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# and unzipped to c:\data
# The variables in the dataset are

# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). 
#   It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave 
#   (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). 
#   It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). 
#   It corresponds to an electric water-heater and an air-conditioner.

## read the data
# Note that in this dataset missing values are coded as ?.
power_data = read.csv("c:\\data\\household_power_consumption.txt", sep=";", na.strings = "?")

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
power_data = power_data[which(power_data$Date == "1/2/2007" | power_data$Date == "2/2/2007"), ]

# concatenate the date and time strings and convert to a time structure...
DateTime = strptime(paste(power_data$Date, power_data$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

# add the new column to the dataset
power_data = cbind(DateTime, power_data)

#get rid of useless columns
power_data$Date = NULL
power_data$Time = NULL

#################################### plotting code follows #################################
## divert to bitmap device
png("plot4.png")

## multiple plots per page - 2x2
par(mfcol=c(2, 2))

## top left
plot(power_data$DateTime, power_data$Global_active_power, type = "n", ylab = "Global Active Power", xlab = "")
lines(power_data$DateTime, power_data$Global_active_power)

## bottom left
plot(power_data$DateTime, power_data$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(power_data$DateTime, power_data$Sub_metering_1, type = "l", col="black")
lines(power_data$DateTime, power_data$Sub_metering_2, type = "l", col="red")
lines(power_data$DateTime, power_data$Sub_metering_3, type = "l", col="blue")
legend('topright', names(power_data)[6:8], lty=1, bty="n", col=c("black", "red", "blue")) 

## top right
plot(power_data$DateTime, power_data$Voltage, type = "l", xlab="datetime", ylab = "Voltage")


## bottom right
plot(power_data$DateTime, power_data$Global_reactive_power, type = "l", xlab="datetime", ylab = "Global_reactive_power")
dev.off()
 
