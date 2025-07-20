# Load data
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, sep = ";", 
                   na.strings = "?", 
                   stringsAsFactors = FALSE)

# Convert Date column to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset data for dates 2007-02-01 and 2007-02-02
data_subset <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Combine Date and Time into one POSIXlt datetime object
data_subset$Datetime <- strptime(paste(data_subset$Date, data_subset$Time), format = "%Y-%m-%d %H:%M:%S")

# Plot to PNG
png("plot2.png", width = 480, height = 480)
plot(data_subset$Datetime, data_subset$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()
