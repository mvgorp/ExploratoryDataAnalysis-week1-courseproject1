# Load fulldata, if not yet available
if(!exists('fulldata')) { 
    fulldata = read.table('household_power_consumption.txt', header = TRUE, sep = ";", na.strings = "?")
}

# Reformat Date
fulldata$Date2 = as.Date( as.character(fulldata$Date), "%d/%m/%Y")

# Subset 2 days
data = subset(fulldata, Date2 >= as.Date("2007-02-01") & Date2 <= as.Date("2007-02-02"))
    
# Build Graph
with(data, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))

# Make PNG
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()