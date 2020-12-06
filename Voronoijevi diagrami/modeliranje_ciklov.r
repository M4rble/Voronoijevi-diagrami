#MODELIRANJE CIKLOV
######################################################
#uvozimo knjižnice
library(tidyr)
library(dplyr)
library(ggplot2)
library(tinytex)
######################################################

#uvozimo podatke

cikel10 <- read.table(file = 'files/rezultati_cikel_do_10.tsv', sep='\t', header = TRUE) 
cikel10 <- cikel10[, c(-1)]

cikel30 <- read.table(file = 'files/rezultati_cikel_do_30.tsv', sep='\t', header = TRUE) 
cikel30 <- cikel30[, c(-1)]

cikel50 <- read.table(file = 'files/rezultati_cikel_do_50.tsv', sep='\t', header = TRUE) 
cikel50 <- cikel50[, c(-1)]

cikel75 <- read.table(file = 'files/rezultati_cikel_do_75.tsv', sep='\t', header = TRUE) 
cikel75 <- cikel75[, c(-1)]

cikel100 <- read.table(file = 'files/rezultati_cikel_do_100.tsv', sep='\t', header = TRUE) 
cikel100 <- cikel100[, c(-1)]

cikel200 <- read.table(file = 'files/rezultati_cikel_do_200.tsv', sep='\t', header = TRUE) 
cikel200 <- cikel200[, c(-1)]

cikel350 <- read.table(file = 'files/rezultati_cikel_do_350.tsv', sep='\t', header = TRUE) 
cikel350 <- cikel350[, c(-1)]

cikel500 <- read.table(file = 'files/rezultati_cikel_do_500.tsv', sep='\t', header = TRUE) 
cikel500 <- cikel500[, c(-1)]

############################################################################

#uporabna funkcija za določanje tipa celice
uporabna_funkcija <- function(podatki, povprecja){
  tip_celice <- numeric()
  k <- podatki['stevilo_sredisc']
  for (vrstica in 1:nrow(podatki)){
    for (i in 1:nrow(povprecja)){
      if (povprecja[i ,'stevilo_sredisc'] != k[vrstica, 1]){
      }
      else{
        if (podatki [vrstica, 'V_celica_moc'] > povprecja[i, 3]){
          tip_celice[vrstica] <- 'velika'
        }
        else if (podatki[vrstica, 'V_celica_moc'] < povprecja[i, 2]){
          tip_celice[vrstica] <- 'mala'
        }
        else{
          tip_celice[vrstica] <- 'povprecna'
        }
      }
    }
  }
  koncno <- cbind(podatki, tip_celice)
  return(koncno)
}

#############################################################

#obdelovanje podatkov
#10
povprecni10 <- cikel10 %>%
               group_by(stevilo_sredisc) %>%
               summarise(mean(V_celica_moc))
names(povprecni10)[2] <- "povprecje"
velike10 <- povprecni10$povprecje * 1.9
male10 <- povprecni10$povprecje * 0.1
povprecja10 <- cbind(povprecni10, velike10, male10)

tipi10 <- uporabna_funkcija(cikel10, povprecja10)
koncna10 <- tipi10 %>%
            group_by(stevilo_sredisc, tip_celice) %>%
            summarise(round(mean(V_celica_moc)))
names(koncna10)[3] <- "povprecno_stevilo_vozlisc"

graf_cikel10 <- ggplot(data = koncna10, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 10 vozlišč') + 
                labs(fill = "Tip celice")


#30
povprecni30 <- cikel30 %>%
               group_by(stevilo_sredisc) %>%
               summarise(mean(V_celica_moc))
names(povprecni30)[2] <- "povprecje"
velike30 <- povprecni30$povprecje * 1.9
male30 <- povprecni30$povprecje * 0.1
povprecja30 <- cbind(povprecni30, velike30, male30)

tipi30 <- uporabna_funkcija(cikel30, povprecja30)
koncna30 <- tipi30 %>%
            group_by(stevilo_sredisc, tip_celice) %>%
            summarise(round(mean(V_celica_moc)))
names(koncna30)[3] <- "povprecno_stevilo_vozlisc"


graf_cikel30 <- ggplot(data = koncna30, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 30 vozlišč') + 
                labs(fill = "Tip celice")


#50
povprecni50 <- cikel50 %>%
               group_by(stevilo_sredisc) %>%
               summarise(mean(V_celica_moc))
names(povprecni50)[2] <- "povprecje"
velike50 <- povprecni50$povprecje * 1.9
male50 <- povprecni50$povprecje * 0.1
povprecja50 <- cbind(povprecni50, velike50, male50)

tipi50 <- uporabna_funkcija(cikel50, povprecja50)
koncna50 <- tipi50 %>%
            group_by(stevilo_sredisc, tip_celice) %>%
            summarise(round(mean(V_celica_moc)))
names(koncna50)[3] <- "povprecno_stevilo_vozlisc"

graf_cikel50 <- ggplot(data = koncna50, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 50 vozlišč') + 
                labs(fill = "Tip celice")


#75
povprecni75 <- cikel75 %>%
               group_by(stevilo_sredisc) %>%
               summarise(mean(V_celica_moc))
names(povprecni75)[2] <- "povprecje"
velike75 <- povprecni75$povprecje * 1.9
male75 <- povprecni75$povprecje * 0.1
povprecja75 <- cbind(povprecni75, velike75, male75)

tipi75 <- uporabna_funkcija(cikel75, povprecja75)
koncna75 <- tipi75 %>%
            group_by(stevilo_sredisc, tip_celice) %>%
            summarise(round(mean(V_celica_moc)))
names(koncna75)[3] <- "povprecno_stevilo_vozlisc"

graf_cikel75 <- ggplot(data = koncna75, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 75 vozlišč') + 
                labs(fill = "Tip celice")


#100
povprecni100 <- cikel100 %>%
                group_by(stevilo_sredisc) %>%
                summarise(mean(V_celica_moc))
names(povprecni100)[2] <- "povprecje"
velike100 <- povprecni100$povprecje * 1.9
male100 <- povprecni100$povprecje * 0.1
povprecja100 <- cbind(povprecni100, velike100, male100)

tipi100 <- uporabna_funkcija(cikel100, povprecja100)
koncna100 <- tipi100 %>%
             group_by(stevilo_sredisc, tip_celice) %>%
             summarise(round(mean(V_celica_moc)))
names(koncna100)[3] <- "povprecno_stevilo_vozlisc"

graf_cikel100 <- ggplot(data = koncna100, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                 geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                 ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 100 vozlišč') + 
                 labs(fill = "Tip celice")


#200
povprecni200 <- cikel200 %>%
                group_by(stevilo_sredisc) %>%
                summarise(mean(V_celica_moc))
names(povprecni200)[2] <- "povprecje"
velike200 <- povprecni200$povprecje * 1.9
male200 <- povprecni200$povprecje * 0.1
povprecja200 <- cbind(povprecni200, velike200, male200)

tipi200 <- uporabna_funkcija(cikel200, povprecja200)
koncna200 <- tipi200 %>%
             group_by(stevilo_sredisc, tip_celice) %>%
             summarise(round(mean(V_celica_moc)))
names(koncna200)[3] <- "povprecno_stevilo_vozlisc"

graf_cikel200 <- ggplot(data = koncna200, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                 geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                 ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 200 vozlišč') + 
                 labs(fill = "Tip celice")


#350
povprecni350 <- cikel350 %>%
                group_by(stevilo_sredisc) %>%
                summarise(mean(V_celica_moc))
names(povprecni350)[2] <- "povprecje"
velike350 <- povprecni350$povprecje * 1.9
male350 <- povprecni350$povprecje * 0.1
povprecja350 <- cbind(povprecni350, velike350, male350)

tipi350 <- uporabna_funkcija(cikel350, povprecja350)
koncna350 <- tipi350 %>%
             group_by(stevilo_sredisc, tip_celice) %>%
             summarise(round(mean(V_celica_moc)))
names(koncna350)[3] <- "povprecno_stevilo_vozlisc"

graf_cikel350 <- ggplot(data = koncna350, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                 geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                 ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 350 vozlišč') + 
                 labs(fill = "Tip celice")


#500
povprecni500 <- cikel500 %>%
                group_by(stevilo_sredisc) %>%
                summarise(mean(V_celica_moc))
names(povprecni500)[2] <- "povprecje"
velike500 <- povprecni500$povprecje * 1.9
male500 <- povprecni500$povprecje * 0.1
povprecja500 <- cbind(povprecni500, velike500, male500)

tipi500 <- uporabna_funkcija(cikel500, povprecja500)
koncna500 <- tipi500 %>%
             group_by(stevilo_sredisc, tip_celice) %>%
             summarise(round(mean(V_celica_moc)))
names(koncna500)[3] <- "povprecno_stevilo_vozlisc"

graf_cikel500 <- ggplot(data = koncna500, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                 geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                 ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 500 vozlišč') + 
                 labs(fill = "Tip celice")


#primerjava vseh vozlišč
graf_vsi_cikel <- plot(povprecni30, col = "blue", main = "Primerjava povprečnega števila velikosti celic glede na število središč in vseh vozlišč",
     pch = 20, x_lab = "Število središč", y_lab = "Povprečno število vozlišč v celici", xlim=c(0,180), ylim=c(0,30))
graf_vsi_cikel <- graf_vsi_cikel + points(povprecni10, col = "green", pch = 20)
graf_vsi_cikel <- graf_vsi_cikel + points(povprecni50, col = "red", pch = 20)
graf_vsi_cikel <- graf_vsi_cikel + points(povprecni75, col = "yellow", pch = 20)
graf_vsi_cikel <- graf_vsi_cikel + points(povprecni100, col = "black", pch = 20)
graf_vsi_cikel <- graf_vsi_cikel + points(povprecni200, col = "orange", pch = 20)
graf_vsi_cikel <- graf_vsi_cikel + points(povprecni350, col = "purple", pch = 20)
graf_vsi_cikel <- graf_vsi_cikel + points(povprecni500, col = "pink", pch = 20)
graf_vsi_cikel <- graf_vsi_cikel + legend(130, 30, legend=c("10 vozlišč", "30 vozlišč", "50 vozlišč", "75 vozlišč", "100 vozlišč", "200 vozlišč", "350 vozlišč", "500 vozlišč"),
       col=c("green", "blue", "red", "yellow", "black", "orange", "purple", "pink"), 
       fill=c("green", "blue", "red", "yellow", "black", "orange", "purple", "pink"))
