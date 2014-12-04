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

# redirect graphic output to a file
png("plot1.png")
#################################### plotting code follows #################################

hist(power_data$Global_active_power, main = "Global Active Power", 
        xlab = "Global Active Power (kilowatts)", col = "red", ylim = c(0, 1200))

# turn off redirection
dev.off()

