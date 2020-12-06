#MODELIRANJE BINOMSKIH DREVES
######################################################
#uvozimo knjižnice
library(tidyr)
library(dplyr)
library(ggplot2)
library(tinytex)
######################################################

#uvozimo podatke
binomski10 <- read.table(file = 'files/rezultati_binomski_do_10.tsv', sep='\t', header = TRUE) 
binomski10 <- binomski10[, c(-1)]
                         
binomski30 <- read.table(file = 'files/rezultati_binomski_do_30.tsv', sep='\t', header = TRUE) 
binomski30 <- binomski30[, c(-1)]

binomski50 <- read.table(file = 'files/rezultati_binomski_do_50.tsv', sep='\t', header = TRUE) 
binomski50 <- binomski50[, c(-1)]

binomski75 <- read.table(file = 'files/rezultati_binomski_do_75.tsv', sep='\t', header = TRUE) 
binomski75 <- binomski75[, c(-1)]

binomski100 <- read.table(file = 'files/rezultati_binomski_do_100.tsv', sep='\t', header = TRUE) 
binomski100 <- binomski100[, c(-1)]

binomski200 <- read.table(file = 'files/rezultati_binomski_do_200.tsv', sep='\t', header = TRUE) 
binomski200 <- binomski200[, c(-1)]

binomski350 <- read.table(file = 'files/rezultati_binomski_do_350.tsv', sep='\t', header = TRUE) 
binomski350 <- binomski350[, c(-1)]

binomski500 <- read.table(file = 'files/rezultati_binomski_do_500.tsv', sep='\t', header = TRUE) 
binomski500 <- binomski500[, c(-1)]

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

################################################################

#obdelovanje podatkov
#10
povprecni10 <- binomski10 %>%
               group_by(stevilo_sredisc) %>%
               summarise(mean(V_celica_moc))
names(povprecni10)[2] <- "povprecje"
velike10 <- povprecni10$povprecje * 1.9
male10 <- povprecni10$povprecje * 0.1
povprecja10 <- cbind(povprecni10, velike10, male10)

tipi10 <- uporabna_funkcija(binomski10, povprecja10)
koncna10 <- tipi10 %>%
            group_by(stevilo_sredisc, tip_celice) %>%
            summarise(round(mean(V_celica_moc)))
names(koncna10)[3] <- "povprecno_stevilo_vozlisc"

graf_binomski10 <- ggplot(data = koncna10, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                   geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                   ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 10 vozlišč') + 
                   labs(fill = "Tip celice")


#30
povprecni30 <- binomski30 %>%
               group_by(stevilo_sredisc) %>%
               summarise(mean(V_celica_moc))
names(povprecni30)[2] <- "povprecje"
velike30 <- povprecni30$povprecje * 1.9
male30 <- povprecni30$povprecje * 0.1
povprecja30 <- cbind(povprecni30, velike30, male30)

tipi30 <- uporabna_funkcija(binomski30, povprecja30)
koncna30 <- tipi30 %>%
            group_by(stevilo_sredisc, tip_celice) %>%
            summarise(round(mean(V_celica_moc)))
names(koncna30)[3] <- "povprecno_stevilo_vozlisc"


graf_binomski30 <- ggplot(data = koncna30, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                   geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                   ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 30 vozlišč') + 
                   labs(fill = "Tip celice")

#50
povprecni50 <- binomski50 %>%
               group_by(stevilo_sredisc) %>%
               summarise(mean(V_celica_moc))
names(povprecni50)[2] <- "povprecje"
velike50 <- povprecni50$povprecje * 1.9
male50 <- povprecni50$povprecje * 0.1
povprecja50 <- cbind(povprecni50, velike50, male50)

tipi50 <- uporabna_funkcija(binomski50, povprecja50)
koncna50 <- tipi50 %>%
            group_by(stevilo_sredisc, tip_celice) %>%
            summarise(round(mean(V_celica_moc)))
names(koncna50)[3] <- "povprecno_stevilo_vozlisc"

graf_binomski50 <- ggplot(data = koncna50, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                   geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                   ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 50 vozlišč') + 
                   labs(fill = "Tip celice")


#75
povprecni75 <- binomski75 %>%
               group_by(stevilo_sredisc) %>%
               summarise(mean(V_celica_moc))
names(povprecni75)[2] <- "povprecje"
velike75 <- povprecni75$povprecje * 1.9
male75 <- povprecni75$povprecje * 0.1
povprecja75 <- cbind(povprecni75, velike75, male75)

tipi75 <- uporabna_funkcija(binomski75, povprecja75)
koncna75 <- tipi75 %>%
            group_by(stevilo_sredisc, tip_celice) %>%
            summarise(round(mean(V_celica_moc)))
names(koncna75)[3] <- "povprecno_stevilo_vozlisc"

graf_binomski75 <- ggplot(data = koncna75, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                   geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                   ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 75 vozlišč') + 
                   labs(fill = "Tip celice")


#100
povprecni100 <- binomski100 %>%
                group_by(stevilo_sredisc) %>%
                summarise(mean(V_celica_moc))
names(povprecni100)[2] <- "povprecje"
velike100 <- povprecni100$povprecje * 1.9
male100 <- povprecni100$povprecje * 0.1
povprecja100 <- cbind(povprecni100, velike100, male100)

tipi100 <- uporabna_funkcija(binomski100, povprecja100)
koncna100 <- tipi100 %>%
             group_by(stevilo_sredisc, tip_celice) %>%
             summarise(round(mean(V_celica_moc)))
names(koncna100)[3] <- "povprecno_stevilo_vozlisc"

graf_binomski100 <- ggplot(data = koncna100, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                    geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                    ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 100 vozlišč') + 
                    labs(fill = "Tip celice")


#200
povprecni200 <- binomski200 %>%
                group_by(stevilo_sredisc) %>%
                summarise(mean(V_celica_moc))
names(povprecni200)[2] <- "povprecje"
velike200 <- povprecni200$povprecje * 1.9
male200 <- povprecni200$povprecje * 0.1
povprecja200 <- cbind(povprecni200, velike200, male200)

tipi200 <- uporabna_funkcija(binomski200, povprecja200)
koncna200 <- tipi200 %>%
             group_by(stevilo_sredisc, tip_celice) %>%
             summarise(round(mean(V_celica_moc)))
names(koncna200)[3] <- "povprecno_stevilo_vozlisc"

graf_binomski200 <- ggplot(data = koncna200, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                    geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                    ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 200 vozlišč') + 
                    labs(fill = "Tip celice")


#350
povprecni350 <- binomski350 %>%
                group_by(stevilo_sredisc) %>%
                summarise(mean(V_celica_moc))
names(povprecni350)[2] <- "povprecje"
velike350 <- povprecni350$povprecje * 1.9
male350 <- povprecni350$povprecje * 0.1
povprecja350 <- cbind(povprecni350, velike350, male350)

tipi350 <- uporabna_funkcija(binomski350, povprecja350)
koncna350 <- tipi350 %>%
             group_by(stevilo_sredisc, tip_celice) %>%
             summarise(round(mean(V_celica_moc)))
names(koncna350)[3] <- "povprecno_stevilo_vozlisc"

graf_binomski350 <- ggplot(data = koncna350, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                    geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                    ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 350 vozlišč') + 
                    labs(fill = "Tip celice")


#500
povprecni500 <- binomski500 %>%
                group_by(stevilo_sredisc) %>%
                summarise(mean(V_celica_moc))
names(povprecni500)[2] <- "povprecje"
velike500 <- povprecni500$povprecje * 1.9
male500 <- povprecni500$povprecje * 0.1
povprecja500 <- cbind(povprecni500, velike500, male500)

tipi500 <- uporabna_funkcija(binomski500, povprecja500)
koncna500 <- tipi500 %>%
             group_by(stevilo_sredisc, tip_celice) %>%
             summarise(round(mean(V_celica_moc)))
names(koncna500)[3] <- "povprecno_stevilo_vozlisc"

graf_binomski500 <- ggplot(data = koncna500, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                    geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                    ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 500 vozlišč') + 
                    labs(fill = "Tip celice")


#primerjava vseh vozlišč
graf_vsi_binomski <- plot(povprecni30, col = "blue", main = "Primerjava povprečnega števila velikosti celic glede na število središč in vseh vozlišč",
     pch = 20, x_lab = "Število središč", y_lab = "Povprečno število vozlišč v celici", xlim=c(0,100), ylim=c(0,25))
graf_vsi_binomski <- graf_vsi_binomski + points(povprecni10, col = "green", pch = 20)
graf_vsi_binomski <- graf_vsi_binomski + points(povprecni50, col = "red", pch = 20)
graf_vsi_binomski <- graf_vsi_binomski + points(povprecni75, col = "yellow", pch = 20)
graf_vsi_binomski <- graf_vsi_binomski + points(povprecni100, col = "black", pch = 20)
graf_vsi_binomski <- graf_vsi_binomski + points(povprecni200, col = "orange", pch = 20)
graf_vsi_binomski <- graf_vsi_binomski + points(povprecni500, col = "pink", pch = 20)
graf_vsi_binomski <- graf_vsi_binomski +  legend(80, 25, legend = c("10 vozlišč", "30 vozlišč", "50 vozlišč", "75 vozlišč", "100 vozlišč", "200 vozlišč", "350 vozlišč", "500 vozlišč"),
               col=c("green", "blue", "red", "yellow", "black", "orange", "purple", "pink"), 
               fill=c("green", "blue", "red", "yellow", "black", "orange", "purple", "pink"))
