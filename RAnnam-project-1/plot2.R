# Below code in PART-1 reads the input data file, formats the data as appropriate. 

#
# PART - 1. 

# set working directory
setwd("C:/R_annam/exdata-data-household_power_consumption")

# read the input text data file
data <- read.table(file = 'household_power_consumption.txt', header = TRUE, sep = ";")


## handling date time

# combining the date and time fileds to create a new field
temp_dt <- paste(data$Date, data$Time, sep = " ")
# convert to datetime
data$data_datetime <- strptime(temp_dt, format = "%d/%m/%Y %H:%M:%S")

# converting to Date format
data$Date                  <- as.Date(data$Date, format = "%d/%m/%Y")

# subsetting the data for required date range
dt_index <- data$Date == "2007-02-01" | data$Date == "2007-02-02" 
data <- data[dt_index,]  # select only filtered data

# convert time and other fields to respective formats (from text)
data$Time                  <- strptime(data$Time, format = "%H:%M:%S")
data$Global_active_power   <- as.numeric(levels(data$Global_active_power))[data$Global_active_power]
data$Global_reactive_power <- as.numeric(levels(data$Global_reactive_power))[data$Global_reactive_power]
data$Voltage               <- as.numeric(levels(data$Voltage))[data$Voltage]
data$Global_intensity      <- as.numeric(levels(data$Global_intensity))[data$Global_intensity]
data$Sub_metering_1        <- as.numeric(levels(data$Sub_metering_1))[data$Sub_metering_1]
data$Sub_metering_2        <- as.numeric(levels(data$Sub_metering_2))[data$Sub_metering_2]

#
#
#
## PART - 2

# Generate the plot and write to PNG file

png(file = "plot2.png", width = 480, height = 480) # open the device to write plot

# Generate the plot, using the newly created field data_datetime
plot(data$data_datetime, data$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "")

# close the device
dev.off()















