library("excel.link")
library("tidyverse")
library("xlsx")
library(ggplot2)

input_path <- "Y:\\8_Bioinf\\measure_disc_speed\\logs\\measure_discspeed.xlsx"
dat <- xl.read.file(input_path, header = T) %>%
  as_tibble()

#+++++++++++++++++++++++++

# Function to calculate the mean and the standard deviation

# for each group

#+++++++++++++++++++++++++

# data : a data frame

# varname : the name of a column containing the variable

#to be summariezed

# groupnames : vector of column names to be used as

# grouping variables

data_summary <- function(data, varname, groupnames){
  require(plyr)
  summary_func <- function(x, col){
    c(mean = mean(x[[col]], na.rm=TRUE),
      sd = sd(x[[col]], na.rm=TRUE))
  }
  data_sum<-ddply(data, groupnames, .fun=summary_func,
                  varname)
  data_sum <- rename(data_sum, c("mean" = varname))
  return(data_sum)
}


dat2 <- data_summary(dat, varname="duration_secs",
                    groupnames=c("task","disc"))
# Convert dose to a factor variable
dat2$disc=as.factor(dat2$dose)


p <- ggplot (dat, aes(x=task,y=duration_secs,fill=disc)) +
  geom_bar(stat="identity",color="black", 
           position=position_dodge()) +
  geom_errorbar(aes(ymin=duration_secs-sd,ymax=duration_secs+sd), width=.2,
                position=position_dodge(.9))

# as_tibble(dat)

print(p)