# Load fulldata, if not yet available
if(!exists('fulldata')) { 
    fulldata = read.table('household_power_consumption.txt', header = TRUE, sep = ";", na.strings = "?")
    
    # Reformat Date
    fulldata$Date2      = as.Date( as.character(fulldata$Date), "%d/%m/%Y")
    fulldata$Datetime   = strptime( paste(as.character(fulldata$Date),as.character(fulldata$Time)), "%d/%m/%Y %H:%M:%S")
}

# Subset 2 days
data = subset(fulldata, Date2 >= as.Date("2007-02-01") & Date2 <= as.Date("2007-02-02"))

# Set rows and cols
par(mfcol = c(2, 2), mar = c(5,5,2,1))

# Build graph
with(data, {
    
    # Plot 1
    plot(Datetime, Global_active_power, pch = ".", ylab = "Global Active Power (kilowatts)", xlab = "")
    lines(Datetime, Global_active_power)
    
    # Plot 2
    plot(Datetime, Sub_metering_1, pch = ".", type = "n", xlab ="", ylab = "Energy sub metering")
    lines(Datetime, Sub_metering_1)
    lines(Datetime, Sub_metering_2, col = "Red")
    lines(Datetime, Sub_metering_3, col = "Blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", lwd = c(2,2,2), col = c("Black","Red","Blue"))
    
    # Plot 3
    plot(Datetime, Voltage, pch = ".", ylab = "Voltage", xlab = "datetime")
    lines(Datetime, Voltage)
    
    # Plot 4
    plot(Datetime, Global_reactive_power, pch = ".", xlab = "datetime")
    lines(Datetime, Global_reactive_power)
    
})

# Make PNG
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()