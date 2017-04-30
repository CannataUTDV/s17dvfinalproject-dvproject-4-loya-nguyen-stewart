require(ggplot2)
require(dplyr)


income <- read.csv(file="../01 Data/income.csv", header=TRUE, sep=",")
fatalPoliceShootings <- read.csv(file="../01 Data/fatalPoliceShootings.csv", header=TRUE, sep=",")
incomeOfTheFatallyShot <- read.csv(file="../01 Data/incomeOfTheFatallyShot.csv", header=TRUE, sep=",")


# Median Income by Race

incomeByRace <- incomeOfTheFatallyShot %>% dplyr::group_by(race, gender) %>% dplyr::summarize(avg_median_income = mean(Median_Income), sum_income = sum(Median_Income)) %>% dplyr::group_by(race, gender, avg_median_income) %>% dplyr::summarize(window_avg_income = mean(sum_income))

incomeByRacePlot <- ggplot(incomeByRace, aes(x = gender, y = avg_median_income)) + 
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = scales::comma) + 
  facet_wrap(~race, ncol=1) +
  coord_flip() +
  geom_text(mapping=aes(x=gender, y=avg_median_income, label=round(avg_median_income - window_avg_income)),colour="blue", hjust=-.5)
plot(incomeByRacePlot)

# Median Income by Fleeing

fleeMentalIncome <- incomeOfTheFatallyShot %>% dplyr::select(flee,signs_of_mental_illness,Median_Income) %>% group_by(signs_of_mental_illness,flee) %>% dplyr::filter(flee %in% c('Car','Foot','Not fleeing')) %>% summarise(Median_income = median(Median_Income))


fleePlot <- ggplot(fleeMentalIncome, aes(x=signs_of_mental_illness, y=Median_income, fill=signs_of_mental_illness)) +
  theme(axis.text.x=element_text(angle=0, size=12, vjust=0.5)) + 
  theme(axis.text.y=element_text(size=12, hjust=0.5)) + 
  geom_bar(stat = "identity") + 
  facet_wrap(~flee, ncol=1) + 
  coord_flip() + 
  geom_hline(aes(yintercept = median(Median_income)), color="purple")
plot(fleePlot)


# Inequality Index for High Income Criminals

inequalityIndexforHighIncome <- incomeOfTheFatallyShot %>% dplyr::select(id,GINI,Median_Income) %>% mutate(Median_Income_Range = ifelse(Median_Income < 50000, "low", ifelse(Median_Income < 60000 & Median_Income > 50000, "medium","high"))) %>% dplyr::filter(Median_Income_Range == 'high',id > 1000) 
  
inequalityPlot <- ggplot(inequalityIndexforHighIncome, aes(x=id, y=GINI, fill=Median_Income)) +
  theme(axis.text.x=element_text(angle=0, size=12, vjust=0.5)) + 
  theme(axis.text.y=element_text(size=12, hjust=0.5)) +
  geom_bar(stat = "identity")
plot(inequalityPlot)



require("grid")

setwd("../03 Visualizations")

png("allPlots.png", width = 45, height = 45, units = "in", res = 120)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2)))   

# Print Plots
print(incomeByRacePlot, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))  
print(fleePlot, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(inequalityPlot, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))

dev.off()
