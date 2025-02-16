library(data.table)

# Read the dataset
data <- fread("household_power_consumption.txt", sep=";", na.strings="?")

# Convert Date column to Date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Filter data for February 1-2, 2007
useful_data <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02"]

# Merge Date and Time into a DateTime column
useful_data$DateTime <- as.POSIXct(paste(useful_data$Date, useful_data$Time), format="%Y-%m-%d %H:%M:%S")

# Convert Global Active Power to numeric
useful_data$Global_active_power <- as.numeric(useful_data$Global_active_power)

# Create the plot
png("plot2.png", width=480, height=480)

plot(useful_data$DateTime, useful_data$Global_active_power, type="l", 
     xlab=" ", ylab="Global Active Power (kilowatts)")
dev.off()
