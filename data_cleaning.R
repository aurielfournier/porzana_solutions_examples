# When working on a field or lab project where data is entered over time, and needs to be cleaned each time new data is entered before becoming part of the new master data

# Set up one folder where all the newly entered data is stored, in csv files. Filename should contain the date, and the name of the person who entered it, or their initials

# I can build scripts like this, or custom packages that can do more complex kinds of checks for correctly entered values and appropriat combinations of things (animals can't die before they are born, chicago is always in illinois, 9am is always after 8am, etc). 

# determine the names of all the .csv files in the folder
file_names <- list.files(pattern=".csv")

# often times one big issue in data entry is misspellings. We can catch a lot of these right off the bat by having a vector of knowing correct values for each column. 
# this example is from my own PhD field work

# abbreviated names of my study areas
areas <- c("nvca","scnwr","fgca","slnwr","tsca","bkca","ccnwr","dcca","osca","tmpca")

# impound is short for an impoundment, or a wetland surrouded by a levee, these are the names of all the wetlands I worked in. 
impound <-
c("rail","sanctuary","ash","scmsu2","scmsu3","sgd","sgb","pool2","pool2w","pool3w","m11","m10","m13","ts2a","ts4a","ts6a","ts8a","kt9","kt2","kt5","kt6","ccmsu1","ccmsu2","ccmsu12","dc14","dc18","dc20","dc22","os21","os23","pooli","poole","poolc")

# here are the four regions I worked in
regions <- c("nw","nc","ne","se")

# one of our biggest areas of spelling issues is with plant names. 
plant <- c("reed canary grass","primrose","millet","bulrush","partridge pea","spikerush","a smartweed","p smartweed","willow","tree","buttonbush","arrowhead","river bulrush","biden","upland","cocklebur","lotus","grass","cattail","prairie cord grass","plantain","sedge","sesbania","typha","corn","sumpweed","toothcup","frogfruit","canola","sedge","crop","rush","goldenrod",NA)

# these vectors of character strings could also easily be stored in a seperate file and read in. 

# there are several ways to do this. This is one. 

for(i in 1:length(file_names)){ # we are using length(file_names) so that as we enter more data this will easily grow with our dataset
  int <-  read.csv(file_names[i]) # reads in the ith file
# so this prints out instances where three are things that are not part of the lists above and includes the file name so I can go and find the issue.   
  print(paste0(int[(int$region %in% regions==FALSE),]$region," ",file_names[i]," region"))
  print(paste0(int[(int$area %in% areas==FALSE),]$area," ",file_names[i]," area"))
  print(paste0(int[(int$impound %in% impound==FALSE),]$impound," ",file_names[i]," impound"))
  print(paste0(int[(int$plant1 %in% plant==FALSE),]$plant1," ",file_names[i]," plant1"))
  print(paste0(int[(int$plant2 %in% plant==FALSE),]$plant2," ",file_names[i]," plant2"))
  print(paste0(int[(int$plant3 %in% plant==FALSE),]$plant3," ",file_names[i]," plant3"))
}

## once I resolve all of the issues identified from above I then read in all the files, put them in a list and I can stitch them together into one master file. 

vegsheets <- list()

for(i in 1:length(file_names)){
  vegsheets[[i]] <- read.csv(file_names[i])
}

## this takes the list and combines it all together into one data frame
masterdat <- do.call(rbind, vegsheets)

# write it out into a master file
write.csv(masterdat, "~/Github/data/2015_veg_master.csv", row.names=FALSE)
