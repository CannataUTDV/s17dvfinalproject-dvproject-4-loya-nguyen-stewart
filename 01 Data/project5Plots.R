require(ggplot2)
require(dplyr)

income <- read.csv(file="../01 Data/income.csv", header=TRUE, sep=",")
fatalPoliceShootings <- read.csv(file="../01 Data/fatalPoliceShootings.csv", header=TRUE, sep=",")
incomeOfTheFatallyShot <- read.csv(file="../01 Data/incomeOfTheFatallyShot.csv", header=TRUE, sep=",")

# First Plot

genderMentalIll <- dplyr::select(incomeOfTheFatallyShot, Per_Capita_Income, gender, signs_of_mental_illness)

countTotal <- genderMentalIll %>% mutate(Per_Capita_Range = ifelse(Per_Capita_Income < 26500, "low", ifelse(Per_Capita_Income < 31000 & Per_Capita_Income > 26500, "medium","high"))) %>% count(Per_Capita_Range,gender, signs_of_mental_illness)


lowCapitaRange <- countTotal %>% filter(Per_Capita_Range == "low")
mediumCapitaRange <- countTotal %>% filter(Per_Capita_Range == "medium")
highCapitaRange <- countTotal %>% filter(Per_Capita_Range == "high")

capitaRangePlot <- ggplot() + 
  geom_text(data = lowCapitaRange, aes(x=gender, y=signs_of_mental_illness, label = n),nudge_x = -0.2, size=10) + 
  geom_text(data = mediumCapitaRange, aes(x=gender, y=signs_of_mental_illness, label = n),nudge_x = 0, size=10) + 
  geom_text(data = highCapitaRange, aes(x=gender, y=signs_of_mental_illness, label = n),nudge_x = 0.2, size=10) 

# Second Plot

plotDF <- dplyr::inner_join(income, fatalPoliceShootings, by = c("State" = "state")) %>% 
  dplyr::group_by(gender, race) %>% 
  dplyr::summarize(avg_median_income = mean(Median_Income))

subset <- dplyr::inner_join(income,fatalPoliceShootings, by = c("State" = "state")) %>% dplyr::filter(Median_Income >= 46000 & Median_Income <= 62000) %>%
  dplyr::group_by(gender, race) %>% 
  dplyr::summarize(avg_median_income = mean(Median_Income)) 

genderRacePlot <- ggplot() + 
  geom_text(data = plotDF, aes(x= gender, y=race, label = avg_median_income), size=10) + 
  geom_text(data = subset, aes(x=gender, y=race, label = avg_median_income), nudge_y = -.5, size=4)



#Third Plot

test <- incomeOfTheFatallyShot %>% dplyr::group_by(race,flee) %>% dplyr::summarise(income = median(Median_Income), MedianFamilyIncomePerCapitaIncomeRatio = median(Median_Family_Income/Per_Capita_Income))

raceFleePlot <- ggplot(test) + 
  theme(axis.text.x=element_text(angle=90, size=16, vjust=0.5)) + 
  theme(axis.text.y=element_text(size=16, hjust=0.5)) +
  geom_text(aes(x=race, y=flee, label = income), size=6)+
  geom_tile(aes(x=race, y=flee, fill=MedianFamilyIncomePerCapitaIncomeRatio), alpha=0.50)


require("grid")

png("crossTabPlots.png", width = 45, height = 45, units = "in", res = 120)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2)))   

# Print Plots
print(capitaRangePlot, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))  
print(genderRacePlot, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(raceFleePlot, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))

dev.off()

