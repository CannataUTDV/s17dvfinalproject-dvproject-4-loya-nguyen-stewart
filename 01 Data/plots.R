require("jsonlite")
require("RCurl")
require("ggplot2")
df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ",
                                                'oraclerest.cs.utexas.edu:5048/rest/native/?query="SELECT * FROM `fatal-police-shootings-cleaned` LIMIT 100;"')),
                                 httpheader=c(DB='jdbc:data:world:sql:robin-stewart:s-17-dv-project-4', 
                                              USER='robin-stewart', 
                                              PASS='eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50OnJvYmluLXN0ZXdhcnQiLCJpc3MiOiJhZ2VudDpyb2Jpbi1zdGV3YXJ0OjpiMjlmYzcwMy0yYmZhLTQ3NzktYmJmYi04YTNhNjdjOWI1NmEiLCJpYXQiOjE0ODQ2OTcyNzMsInJvbGUiOlsidXNlcl9hcGlfd3JpdGUiLCJ1c2VyX2FwaV9yZWFkIl0sImdlbmVyYWwtcHVycG9zZSI6dHJ1ZX0.s0t13SAi0Pn7jm5cCWfzzb0n3MRDnpi2GGIQCH8soOt5OICuSyDGfpZNsQKHxKAOA8gOzU5PGKwokczVk_S4Zw', 
                                              MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor ='JSON'), verbose = FALSE) ))

colnames(df) <- c("ID","Date","Manner of Death", "armed", "age", "Gender", "Race", "City", "State", "Signs of Mental Illness", "Threat Level", "Flee", "Body Camera")

p1<- ggplot(df) + geom_point(aes(x = armed, y = age, color = armed)) + labs(title=' Age and Weapon Use When Shot by Police')
p2<- ggplot(df) + geom_dotplot(aes(x=age, fill = gender))+ labs(title='Age and Gender at Death by Police')
p3<- ggplot(df) + geom_bin2d(aes(x=dff$race, y = dff$state))+ labs(title='Race by State at Death by Police')
p4<- ggplot(df) + geom_bar(aes(x=flee, fill = armed))+ labs(title=' Weapons Used When Fleeing')



require("grid")

png("fatalPoliceShootingsPlots.png", width = 25, height = 20, units = "in", res = 72)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2)))   

# Print Plots
#print(p1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))  
#print(p2, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
#print(p3, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))  
#print(p4, vp = viewport(layout.pos.row = 2, layout.pos.col = 2)) 

dev.off()
