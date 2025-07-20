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
png("plot3.png", width = 480, height = 480)

# Plot the first sub metering variable
plot(data_subset$Datetime, data_subset$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering", 
     col = "black")

# Add the second and third sub metering variables
lines(data_subset$Datetime, data_subset$Sub_metering_2, col = "red")
lines(data_subset$Datetime, data_subset$Sub_metering_3, col = "blue")

# Add a legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1)

# Close the PNG device
dev.off()
