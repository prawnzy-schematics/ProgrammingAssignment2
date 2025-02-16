library(data.table)
data <- fread("household_power_consumption.txt", sep=";", na.strings="?")

# Convert Date column to Date format
data[, Date := as.Date(Date, format="%d/%m/%Y")]

# Filter for useful dates
useful_data <- data[Date >= "2007-02-01" & Date <= "2007-02-02"]

# Combine Date and Time using as.POSIXct
DateTime <- as.POSIXct(paste(useful_data$Date, useful_data$Time), format="%Y-%m-%d %H:%M:%S")

# Convert variables to numeric
Global_active_power <- as.numeric(useful_data$Global_active_power)
Sub_metering_1 <- as.numeric(useful_data$Sub_metering_1)
Sub_metering_2 <- as.numeric(useful_data$Sub_metering_2)
Sub_metering_3 <- as.numeric(useful_data$Sub_metering_3)

# Create the plot
png("plot3.png", width=480, height=480)
plot(DateTime, Sub_metering_1, type="l", ylab="Energy Sub metering", xlab="")
lines(DateTime, Sub_metering_2, type="l", col="red")
lines(DateTime, Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, lwd=2, col=c("black", "red", "blue"),cex = 0.75)
dev.off()

