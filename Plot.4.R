# Load data
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, sep = ";", 
                   na.strings = "?", 
                   stringsAsFactors = FALSE)

# Convert Date to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset data for 1st and 2nd February 2007
data_subset <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Combine Date and Time into POSIX datetime
data_subset$Datetime <- strptime(paste(data_subset$Date, data_subset$Time), format = "%Y-%m-%d %H:%M:%S")

# Open PNG device
png("plot4.png", width = 480, height = 480)

# Set 2x2 layout
par(mfrow = c(2, 2))

# Top-left plot: Global Active Power
plot(data_subset$Datetime, data_subset$Global_active_power, 
     type = "l", xlab = "", 
     ylab = "Global Active Power")

# Top-right plot: Voltage
plot(data_subset$Datetime, data_subset$Voltage, 
     type = "l", xlab = "datetime", 
     ylab = "Voltage")

# Bottom-left plot: Energy sub metering
plot(data_subset$Datetime, data_subset$Sub_metering_1, 
     type = "l", xlab = "", 
     ylab = "Energy sub metering")
lines(data_subset$Datetime, data_subset$Sub_metering_2, col = "red")
lines(data_subset$Datetime, data_subset$Sub_metering_3, col = "blue")
legend("topright", bty = "n", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

# Bottom-right plot: Global Reactive Power
plot(data_subset$Datetime, data_subset$Global_reactive_power, 
     type = "l", xlab = "datetime", 
     ylab = "Global Reactive Power")

# Close the PNG device
dev.off()
