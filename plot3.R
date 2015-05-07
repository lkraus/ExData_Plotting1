##Download the data from the given url
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./HouseholdPower.txt")

##Load the Data
household.power <- read.table("HouseholdPower.txt", header = TRUE, na.strings = "?",  sep = ";", skip = 1,
                              col.names = c("Date","Time","Global_active_power","Global_reactive_power",
                                            "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                                            "Sub_metering_3"))

##Convert date and time variables to date and time classes
timestamp <- strptime(paste(household.power$Date, household.power$Time), "%d/%m/%Y %H:%M:%S")

household.power$Date <- as.Date(household.power$Date, "%d/%m/%Y")
household.power$Time <- strptime(household.power$Time, "%H:%M:%S")

##Add the weekdays vector on to the data set
household.power.2 <- cbind(timestamp, household.power)

##Create final data set by using only the data from 2007-02-01 and 2007-02-02
house.power <- household.power.2[household.power.2$Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")),]

## Create the plot as a .png file
png(filename = "plot3.png", width = 480, height = 480)
plot(house.power$timestamp, house.power$Sub_metering_1, type = "n", xlab = NA, ylab = "Energy sub metering")
## Plot the 3 sub metering variables separately
points(house.power$timestamp, house.power$Sub_metering_1, type = "l")
points(house.power$timestamp, house.power$Sub_metering_2, type = "l", col = "red")
points(house.power$timestamp, house.power$Sub_metering_3, type = "l", col = "blue")
## Add a legend
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()