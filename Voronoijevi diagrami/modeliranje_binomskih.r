#MODELIRANJE BINOMSKIH DREVES
######################################################
#uvozimo knjižnice
library(tidyr)
library(dplyr)
library(ggplot2)
library(tinytex)
######################################################

#uvozimo podatke

velikosti <- c(10, 30, 50, 75, 100, 200, 350, 500)
binomski <- lapply(velikosti,
                   . %>% sprintf('files/rezultati_binomski_do_%d.tsv', .) %>%
                     read.table(sep='\t', header=TRUE) %>% .[, -1])

################################################################

#obdelovanje podatkov

povprecja <- lapply(binomski, . %>% group_by(stevilo_sredisc) %>%
                      summarise(povprecje=mean(V_celica_moc)) %>%
                      mutate(velike=povprecje * 1.9,
                             male=povprecje * 0.1))

tipi <- lapply(1:length(velikosti),
               . %>% { inner_join(binomski[[.]], povprecja[[.]]) } %>%
                 mutate(tip_celice=ifelse(V_celica_moc > velike, 'velika',
                                          ifelse(V_celica_moc < povprecje,
                                                 'mala', 'povprecna'))) %>%
                 select(-povprecje, -velike, -male))

koncna <- lapply(tipi, . %>% group_by(stevilo_sredisc, tip_celice) %>%
                   summarise(povprecno_stevilo_vozlisc=round(mean(V_celica_moc))))

graf_binomski <- lapply(1:length(velikosti),
                        function(i)
                          ggplot(data=koncna[[i]],
                                 aes(x=stevilo_sredisc, y=povprecno_stevilo_vozlisc,
                                     col=tip_celice)) + geom_point() + geom_line() +
                          xlab('Število središč') +
                          ylab('Povprečno število vozlišč v celici') +
                          ggtitle(sprintf('Povprečne velikosti celic glede na število središč za binomska drevesa z %d vozlišči', velikosti[i])) + 
                          labs(fill="Tip celice"))

#primerjava vseh vozlišč

povprecni <- lapply(1:length(velikosti),
                    function(i) povprecja[[i]] %>%
                      transmute(velikost=factor(velikosti[i], levels=velikosti),
                                stevilo_sredisc, povprecje)) %>%
  bind_rows()

graf_vsi_binomski <- ggplot(povprecni, aes(x=stevilo_sredisc, y=povprecje,
                                           color=velikost)) + geom_point() +
  ggtitle("Povprečna velikost celic glede na število središč za binomska drevesa vseh velikosti") +
  xlab("Število središč") + ylab("Povprečno število vozlišč v celici") +
  xlim(0, 100) + ylim(0, 25)
