# Load fulldata, if not yet available
if(!exists('fulldata')) { 
    fulldata = read.table('household_power_consumption.txt', header = TRUE, sep = ";", na.strings = "?")
    
    # Reformat Date
    fulldata$Date2      = as.Date( as.character(fulldata$Date), "%d/%m/%Y")
    fulldata$Datetime   = strptime( paste(as.character(fulldata$Date),as.character(fulldata$Time)), "%d/%m/%Y %H:%M:%S")
}

# Subset 2 days
data = subset(fulldata, Date2 >= as.Date("2007-02-01") & Date2 <= as.Date("2007-02-02"))

# Default par
par(mfcol = c(1, 1), mar = c(5,5,2,3))

# Build graph
with(data, {
    #
    plot(Datetime, Sub_metering_1, pch = ".", ylab = "Energy sub metering", xlab = "", type = "n")
    
    # Line 1
    lines(Datetime, Sub_metering_1)
    
    # Line 2, red
    lines(Datetime, Sub_metering_2, col = "Red")
    
    # Line 3, blue
    lines(Datetime, Sub_metering_3, col = "Blue")
    
    # Legend
    # Labels do not seem to fit the legend.
    # Please let me know, if you have a solution how to resize the legend :-)
    legend("topright", c("Sub_metering_1                                    ", "Sub_metering_2", "Sub_metering_3"), lwd = c(2,2,2), col = c("Black","Red","Blue"), y.intersp = 1.5)
})

# Make PNG
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()