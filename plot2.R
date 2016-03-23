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
    plot(Datetime, Global_active_power, pch = ".", ylab = "Global Active Power (kilowatts)", xlab = "")
    lines(Datetime, Global_active_power)
})

# Make PNG
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()