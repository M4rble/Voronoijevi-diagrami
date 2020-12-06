library(tidyr)
library(dplyr)
library(ggplot2)

#Uvoz podatkov za 2d mreže
mreza1x256 <- read.table(file = 'files/mreze256/rezultati_2dmreze_do_1x256.tsv', sep='\t', header = TRUE)
mreza2x128 <- read.table(file = 'files/mreze256/rezultati_2dmreze_do_2x128.tsv', sep='\t', header = TRUE)
mreza4x64 <- read.table(file = 'files/mreze256/rezultati_2dmreze_do_4x64.tsv', sep='\t', header = TRUE)
mreza8x32 <- read.table(file = 'files/mreze256/rezultati_2dmreze_do_8x32.tsv', sep='\t', header = TRUE)
mreza16x16 <- read.table(file = 'files/mreze256/rezultati_2dmreze_do_16x16.tsv', sep='\t', header = TRUE)

#Uvoz podatkov za 3d mreže
mreza2x2x64 <- read.table(file = 'files/mreze256/rezultati_3dmreze_do_2x2x64.tsv', sep='\t', header = TRUE)
mreza2x4x32 <- read.table(file = 'files/mreze256/rezultati_3dmreze_do_2x4x32.tsv', sep='\t', header = TRUE)
mreza2x8x16 <- read.table(file = 'files/mreze256/rezultati_3dmreze_do_2x8x16.tsv', sep='\t', header = TRUE)
mreza4x4x16 <- read.table(file = 'files/mreze256/rezultati_3dmreze_do_4x4x16.tsv', sep='\t', header = TRUE)
mreza4x8x8 <- read.table(file = 'files/mreze256/rezultati_3dmreze_do_4x8x8.tsv', sep='\t', header = TRUE)

#Odstranitev stolpca id
mreza1x256 <- mreza1x256[, c(-1)]
mreza2x128 <- mreza2x128[, c(-1)]
mreza4x64 <- mreza4x64[, c(-1)]
mreza8x32 <- mreza8x32[, c(-1)]
mreza16x16 <- mreza16x16[, c(-1)]

mreza2x2x64 <- mreza2x2x64[, c(-1)]
mreza2x4x32 <- mreza2x4x32[, c(-1)]
mreza2x8x16 <- mreza2x8x16[, c(-1)]
mreza4x4x16 <- mreza4x4x16[, c(-1)]
mreza4x8x8 <- mreza4x8x8[, c(-1)]

#
#ČEZ TA DEL NE RUN-AMO VEČ, DA NE IZBRIŠE ŠE KAKŠNEGA PRVEGA STOLPCA
#

povprecja1x256 <- mreza1x256 %>% group_by(stevilo_sredisc) %>% summarise(mean(V_celica_moc))
names(povprecja1x256)[2] <- "povprecje"
plot(povprecja1x256$stevilo_sredisc, povprecja1x256$povprecje, col ="deeppink1", ylim=c(0,20), type="l",
     main="Povprečne velikosti celic za 2D mreže", xlab="št. naključno izbranih vozlišč (s korakom 5)", ylab="povp. velikost celice")

povprecja2x128 <- mreza2x128 %>% group_by(stevilo_sredisc) %>% summarise(mean(V_celica_moc))
names(povprecja2x128)[2] <- "povprecje"
lines(povprecja2x128$stevilo_sredisc, povprecja2x128$povprecje, col ="green")

povprecja4x64 <- mreza4x64 %>% group_by(stevilo_sredisc) %>% summarise(mean(V_celica_moc))
names(povprecja4x64)[2] <- "povprecje"
lines(povprecja4x64$stevilo_sredisc, povprecja4x64$povprecje, col ="blue")

povprecja8x32 <- mreza8x32 %>% group_by(stevilo_sredisc) %>% summarise(mean(V_celica_moc))
names(povprecja8x32)[2] <- "povprecje"
lines(povprecja8x32$stevilo_sredisc, povprecja8x32$povprecje, col = "red")

povprecja16x16 <- mreza16x16 %>% group_by(stevilo_sredisc) %>% summarise(mean(V_celica_moc))
names(povprecja16x16)[2] <- "povprecje"
lines(povprecja16x16$stevilo_sredisc, povprecja16x16$povprecje, col = "black")
legend("topright", c("1x256","2x128","4x64","8x32","16x16"),
       col=c("deeppink1","green","blue","red","black"),lwd=2) 

plot(povprecja1x256$stevilo_sredisc, povprecja1x256$povprecje, col ="deeppink1", ylim=c(0,20), type="l",
     main="Povprečne velikosti celic za 3D mreže", xlab="št. naključno izbranih vozlišč (s korakom 5)", ylab="povp. velikost celice")

povprecja2x2x64 <- mreza2x2x64 %>% group_by(stevilo_sredisc) %>% summarise(mean(V_celica_moc))
names(povprecja2x2x64)[2] <- "povprecje"
lines(povprecja2x2x64$stevilo_sredisc, povprecja2x2x64$povprecje, col ="green")

povprecja2x4x32 <- mreza2x4x32 %>% group_by(stevilo_sredisc) %>% summarise(mean(V_celica_moc))
names(povprecja2x4x32)[2] <- "povprecje"
lines(povprecja2x4x32$stevilo_sredisc, povprecja2x4x32$povprecje, col ="blue")

povprecja2x8x16 <- mreza2x8x16 %>% group_by(stevilo_sredisc) %>% summarise(mean(V_celica_moc))
names(povprecja2x8x16)[2] <- "povprecje"
lines(povprecja2x8x16$stevilo_sredisc, povprecja2x8x16$povprecje, col ="red")

povprecja4x4x16 <- mreza4x4x16 %>% group_by(stevilo_sredisc) %>% summarise(mean(V_celica_moc))
names(povprecja4x4x16)[2] <- "povprecje"
lines(povprecja4x4x16$stevilo_sredisc, povprecja4x4x16$povprecje, col ="tan4")

povprecja4x8x8 <- mreza4x8x8 %>% group_by(stevilo_sredisc) %>% summarise(mean(V_celica_moc))
names(povprecja4x8x8)[2] <- "povprecje"
lines(povprecja4x8x8$stevilo_sredisc, povprecja4x8x8$povprecje, col ="black")
legend("topright", c("1x1x256","2x2x64","2x4x32","2x8x16","4x4x16","4x8x8"),
       col=c("deeppink1","green","blue","red","tan4","black"),lwd=2) 

