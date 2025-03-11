data <- fread('household_power_consumption.txt',na.strings = "?")
dim(data)

# num of rows
rows <- nrow(data)

# number of columns
cols <- ncol(data)

# numeric data as 8 bytes 
bytes <- 8

# memory req in bytes
memory_b <- rows*cols*bytes

#memory req in megabytes 
memory_mb <- memory_b / (2^20)

#result
memory_mb  # 142.496 MB 