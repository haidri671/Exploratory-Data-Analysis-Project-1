# Loading and reading data into R
data <- read.table("household_power_consumption.txt",
                   sep = ";",
                   header = TRUE,
                   na.strings = "?",
                   stringsAsFactors = FALSE)
# Data and Time Conversion
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
# Subseting required data
data_subset <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
# Combining date and time coloumns
data_subset$DateTime <- strptime(paste(data_subset$Date, data_subset$Time), format = "%Y-%m-%d %H:%M:%S")

png("plot1.png", width = 480, height = 480)
hist(data_subset$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (Kilowatts)",
     col = "red")
dev.off()
