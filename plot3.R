# Load fulldata, if not yet available
if(!exists('fulldata')) { 
    fulldata = read.table('household_power_consumption.txt', header = TRUE, sep = ";", na.strings = "?")
    
    # Reformat Date
    fulldata$Date2      = as.Date( as.character(fulldata$Date), "%d/%m/%Y")
    fulldata$Datetime   = strptime( paste(as.character(fulldata$Date),as.character(fulldata$Time)), "%d/%m/%Y %H:%M:%S")
}

# Subset 2 days
data = subset(fulldata, Date2 >= as.Date("2007-02-01") & Date2 <= as.Date("2007-02-02"))

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
    legend("topright", c("Submet1", "Submet2", "Submet3"), lwd = c(2,2,2), col = c("Black","Red","Blue"))
})

# Make PNG
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()