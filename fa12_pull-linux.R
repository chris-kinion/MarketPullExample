# ---------------------------------------------------- FA cleaning -----------------------------------------

# pull in all interested values from FA
oneFourtyVector <- as.vector(rep(1,140)) # vector of 140 ones
# DA12_Data.txt has 25,564 rows
getRawData <- read.fwf(file = "FA12_Data.txt", widths = c(-2280,1,1,-5056,oneFourtyVector,-16367,1), header = FALSE, n=25564)

# name columns
SelfConceptNameVector <- as.vector(rep("SC", 140))
colnames(getRawData) <- c("M", "F", SelfConceptNameVector,"Rode") # successful rename

# change na for m to 0
getRawData$M <- ifelse(
  is.na(getRawData$M),
  0,
  getRawData$M
)

# change na for f to 0
getRawData$F <- ifelse(
  is.na(getRawData$F),
  0,
  getRawData$F
)

# remove !sum of mf = 1
getRawData <- subset(getRawData, getRawData$M + getRawData$F == 1)
# only f = 1
getRawData <- subset(getRawData, getRawData$F == 1)
# only if rides
getRawData <- subset(getRawData, getRawData$Rode == 1)

# remove uneeded columns of m, f, rode since I now have the correct domographic and only their self-concept data remains   
getRawData <- getRawData[,3:142]

# change na for everything to 0
getRawData <- apply(getRawData[,c(1:140)], MARGIN = c(1,2), function(x){ifelse(is.na(x), 0, x)})

# save data
write.table(getRawData, "FA12filtered.txt", na=" ", row.names = FALSE, col.names = FALSE) # creates whitespace between variables

# verify data
dim(getRawData)
View(getRawData)
