#uvozimo knjižnice
library(tidyr)
library(dplyr)
library(ggplot2)
######################################################

binomski30 <- read.table(file = 'files/rezultati_binomski_do_30.tsv', sep='\t', header = TRUE) 
binomski30 <- binomski30[, c(-1)] #odstranimo identitete, zarad lepote

binomski50 <- read.table(file = 'files/rezultati_binomski_do_50.tsv', sep='\t', header = TRUE) 
binomski50 <- binomski50[, c(-1)]

#############################################################################################
#uporabna funkcija s kero se določ ali je posamezna celica velika, povprečna ali mala
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
###############################################################################################
#preračunamo vse stvari, ki jih rabmo, da določimo tip celic
povprecni30 <- binomski30 %>%
  group_by(stevilo_sredisc) %>%
  summarise(mean(V_celica_moc))
names(povprecni30)[2] <- "povprecje"
velike <- povprecni30$povprecje * 1.9
male <- povprecni30$povprecje * 0.1
povprecja30 <- cbind(povprecni30, velike, male)

#določimo tip celic in nardimo končno tabelo podatkov iz katere bomo risal grafe
najs <- uporabna_funkcija(binomski30, povprecja30)
finale <- najs %>% group_by(stevilo_sredisc, tip_celice) %>%
  summarise(round(mean(V_celica_moc)))
names(finale)[3] <- "povprecno_stevilo_vozlisc"

graf_binomski30 <- ggplot(data = finale, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                   geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                   ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 30 vozlišč') + 
                   labs(fill = "Tip celice")

povprecni50 <- binomski50 %>%
  group_by(stevilo_sredisc) %>%
  summarise(mean(V_celica_moc))
names(povprecni50)[2] <- "povprecje"
velike50 <- povprecni50$povprecje * 1.9
male50 <- povprecni50$povprecje * 0.1
povprecja50 <- cbind(povprecni50, velike50, male50)
najs2 <- uporabna_funkcija(binomski50, povprecja50)
finale2 <- najs2 %>% group_by(stevilo_sredisc, tip_celice) %>%
  summarise(round(mean(V_celica_moc)))
names(finale2)[3] <- "povprecno_stevilo_vozlisc"

graf_binomski50 <- ggplot(data = finale2, aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc, col=tip_celice)) +
                   geom_point() + geom_line() + xlab('Število središč') + ylab('Povprečno število vozlišč v celici') + 
                   ggtitle('Primerjava povprečnih velikosti celic glede na število sredič za 50 vozlišč') + 
                   labs(fill = "Tip celice")


plot(povprecni30, col = "blue", main = "Primerjava povprečnega števila velikosti celic glede na število središč in vseh vozlišč",
     pch = 20, x_lab = "Število središč", y_lab = "Povprečno število vozlišč v celici", xlim=c(0,20), ylim=c(0,20))
points(povprecni50, col = "red", pch = 20)
legend(15, 15, legend=c("30 vozlišč", "50 vozlišč"), col=c("blue", "red"), fill=c("blue", "red"))
