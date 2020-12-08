library(tidyr)
library(dplyr)
library(ggplot2)
library("actuar")
library(VGAM)

#___UVOZ IN OSNOVNI HISTOGRAM___

#"neskončne mreže" 32x32 na vzorcu 10
infmreze32 <- read.table(file = 'files/InfMreze/rezultati_inf2dmreze_do_1024(10x).tsv', sep='\t', header = TRUE)
velikosti32 <- infmreze32[,6]

#"neskončne mreže" 8x8 na vzorcu 100
infmreze8_100 <- read.table(file = 'files/InfMreze/rezultati_inf2dmreze_do_64(100x).tsv', sep='\t', header = TRUE)
velikosti8_100 <- infmreze8_100[,6]

#"neskončne mreže" 16x16 na vzorcu 100
infmreze16_100 <- read.table(file = 'files/InfMreze/rezultati_inf2dmreze_do_256(100x).tsv', sep='\t', header = TRUE)
velikosti16_100 <- infmreze16_100[,6]

#Na najbolj "zanesljiv" histogram bomo dodajali ustrezne krivulje
tmp16_100 <- hist(velikosti16_100, breaks=20, freq=FALSE, ylim=c(0,0.15),
                  main = "Porazdelitev Voronoijevih celic po velikosti",
                  xlab = "velikost Voronoijeve celice (1/8 izbranih sredisc)",
                  ylab = "gostota")

#___ISKANJE GOSTOT___

#aproksimacija z Weibullovo porazdelitvijo, ki se na videz najbolj prilega
parametraW16_100<-mde(velikosti16_100, pweibull, start = list(shape=3, scale=1),measure="CvM")
curve(dweibull(x,scale=parametraW16_100$estimate[2],shape=parametraW16_100$estimate[1]),xlim=c(0,25),add=TRUE,col="blue")

parametraW8_100<-mde(velikosti8_100, pweibull, start = list(shape=1, scale=1),measure="CvM")
curve(dweibull(x,scale=parametraW8_100$estimate[2],shape=parametraW8_100$estimate[1]),xlim=c(0,25),add=TRUE, col="purple")

parametraW32<-mde(velikosti32, pweibull, start = list(shape=3, scale=1),measure="CvM")
curve(dweibull(x,scale=parametraW32$estimate[2],shape=parametraW32$estimate[1]),xlim=c(0,25),add=TRUE,col="red")

#poskus aproksimacije z Rayleighovo porazdelitvijo (ima le en parameter)
parametraR16_100<-mde(velikosti16_100, prayleigh, start = list(scale=1),measure="CvM")
curve(drayleigh(x,parametraR16_100$estimate),xlim=c(0,25),add=TRUE,col="green",lwd=2)
legend("topright", c("16x16 100 krat","8x8 100 krat","32x32 10 krat","Rayleighova 16x16 100 krat"),
       col=c("blue","purple","red","green"),lwd=c(2,2,2,4), bty = "n")

#Predpostavimo torej Weibullovo porazdelitev, ki naj bi jo krivulja, dobljena
#na "neskončni" mreži 32x32 najbolje uprizarjala.

#to je sedaj naša projekcija
parametraW32<-mde(velikosti32, pweibull, start = list(shape=3, scale=1),measure="CvM")

#dodamo še inf mrežo 48x48, dobljeno s 5 iteracijami
infmreze48 <- read.table(file = 'files/InfMreze/rezultati_inf2dmreze_do_2304(5x).tsv', sep='\t', header = TRUE)
velikosti48 <- infmreze48[,6]
parametraW48<-mde(velikosti48, pweibull, start = list(shape=3, scale=1),measure="CvM")
curve(dweibull(x,scale=parametraW48$estimate[2],shape=parametraW48$estimate[1]),xlim=c(0,1),col="blue",lty=3, add=TRUE)

#Napoved porazdelitve se izkaže za pravilno, saj se krivulji povsem prekrivata (seveda
#za fiksen procent naključno izbranih Voronoijevih središč)
curve(dweibull(x,scale=parametraW32$estimate[2],shape=parametraW32$estimate[1]),xlim=c(0,25),col="red",lwd=1,
      main="Ujemanje Weibullovih porazdelitev za periodične mreze",
      ylab="gostota",
      xlab="velikost Voronoijeve celice (1/8 izbranih vozlisc)")
curve(dweibull(x,scale=parametraW48$estimate[2],shape=parametraW48$estimate[1]),col="blue",lty=3, add=TRUE)
legend("topright",bty="n",c("infmreza 32x32","infmreza 48x48"),col=c("red","blue"),lty=3)

#__________________________________________________________________#

#Narišemo sila podroben graf z majhno skalo, da lahko ločimo med krivuljama, ker se tako ujemata
curve(dweibull(x,scale=parametraW32$estimate[2],shape=parametraW32$estimate[1]),xlim=c(0,1),col="red",lty=3,
      main="Ujemanje Weibullovih porazdelitev za neskoncne mreze",
      ylab="gostota",
      xlab="velikost Voronoijeve celice (1/8 izbranih vozlisc)")
curve(dweibull(x,scale=parametraW48$estimate[2],shape=parametraW48$estimate[1]),col="blue",lty=3, add=TRUE)
legend("topleft", c("infmreza 32x32 10 krat","infmreza 48x48 5 krat"),
       col=c("red","blue"),lty=c(3,3),bty="n")

#______________________________________________________________________#

#Ob normalni skali je razlika neznatna, zato vse "neskončne" mreže opišemo z isto krivuljo
curve(dweibull(x,scale=parametraW32$estimate[2],shape=parametraW32$estimate[1]),xlim=c(0,27),col="red",lwd=1,
      main="Weibullove gostote glede na 'končnost' mreze",
      ylab="gostota",
      xlab="velikost Voronoijeve celice (1/8 izbranih vozlisc)")

#dodatek navadne mreže 8x8 (z robovi)
mreze8 <- read.table(file = 'files/InfMreze/rezultati_2dmreze_do_64(1000x).tsv', sep='\t', header = TRUE)
velikostinavadna8 <- mreze8[,6]
parametraWnavadna8<-mde(velikostinavadna8, pweibull, start = list(shape=3, scale=1),measure="CvM")
curve(dweibull(x,scale=parametraWnavadna8$estimate[2],shape=parametraWnavadna8$estimate[1]),col="darkorange2",lty=1, add=TRUE)

#dodatek navadne mreže 16x16 (z robovi)
mreze16 <- read.table(file = 'files/InfMreze/rezultati_2dmreze_do_256(100x).tsv', sep='\t', header = TRUE)
velikostinavadna16 <- mreze16[,6]
parametraWnavadna16<-mde(velikostinavadna16, pweibull, start = list(shape=3, scale=1),measure="CvM")
curve(dweibull(x,scale=parametraWnavadna16$estimate[2],shape=parametraWnavadna16$estimate[1]),col="blue",lty=1, add=TRUE)

#dodatek še navadne mreže 48x48 s 5 iteracijami
mreze48 <- read.table(file = 'files/InfMreze/rezultati_2dmreze_do_2304(5x).tsv', sep='\t', header = TRUE)
velikostinavadna48 <- mreze48[,6]
parametraWnavadna48<-mde(velikostinavadna48, pweibull, start = list(shape=3, scale=1),measure="CvM")
curve(dweibull(x,scale=parametraWnavadna48$estimate[2],shape=parametraWnavadna48$estimate[1]),col="green",lty=1, add=TRUE)

curve(dweibull(x,scale=parametraW32$estimate[2],shape=parametraW32$estimate[1]),col="red",lwd=1,add=TRUE)
      
abline(v=8) #pričakovali bi maksimum v 8, ker smo izbrali 1/8 sredisc
legend("topright", c("neskoncne mreze","navadna mreza 8x8","navadna mreza 16x16", "navadna mreza 48x48"), col=c("red","darkorange2","blue","green"),
       lwd=c(1,1,1),bty="n")





