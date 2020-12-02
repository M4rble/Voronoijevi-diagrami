import random
import numpy as np
import csv
import pandas as pd
import math

from tqdm import tqdm

class Graf:                                         #naredimo classe za splošen graf in vsak tip grafa posebej
    """
    Osnovni razred za grafe.
    """

    def generiraj(self):
        """
        Privzeto so grafi deterministični.
        """
        return self.matrika

    def stevilo_vozlisc(self):
        return len(self.matrika)

class Mreza(Graf):
    """
    Razred za 2D mreže.
    """
    TIP = "2dmreza"

    def __init__(self, m, n):
        """
        Inicializiraj mrežo velikosti m*n.
        """
        self.matrika = mreza(m, n)


class Mreza3D(Graf):
    """
    Razred za 3D mreže
    """
    TIP = "3dmreza"
    
    def __init__(self, m, n, st):
        """
        Inicializiraj mrežo velikosti m*n.
        """
        self.matrika = triDmreza(m,n,st)


class BinomskoDrevo(Graf):
    """
    Razred za binomska drevesa
    """
    TIP = "binomski"

    def __init__(self, n):
        """
        Inicializiraj mrežo velikosti m*n.
        """
        self.matrika = binomsko_drevo(n)


class Cikli(BinomskoDrevo):
    """
    Razred za drevesa z dodanimi cikli.
    Deduje od binomskega drevesa, ki ga vzame za osnovo.
    """
    TIP = "cikel"

    def generiraj(self):
        """
        Ta razred je nedeterminističen, zato povozimo funkcijo generiraj.
        """
        matrika = [vrstica[:] for vrstica in self.matrika]                  #naredimo kopijo osnovne matrike
        n = len(matrika)
        k = random.randint(1, n)                                            #dodajanje povezav
        izbrana_vozlisca = random.sample(range(0, len(matrika)), k)         #naključno izebermo vozlišča katerim bomo dodali povezave
        for i in range(0,n):                                               
            for j in izbrana_vozlisca:                                      #dodajanje povezav na primerna mesta
                if i == j:                                                  #ne na diagonalo ali tam, kjer že je povezava
                    pass
                elif matrika[i][j] == 1:
                    pass
                else:
                    matrika[i][j] = 1                                                   
        return self.matrika


def mreza(m,n):
    """
    skonstruira 2D mrežo z m vrsticami in n stolpci
    """
    v = min(m,n)                                                    #da je lahko tudi več vrstic kot stolpcev,
    s = max(m,n)                                                    # saj sta to ista oz. ekvivalentna grafa
    if v == 1 and s == 2:
        return [[0,1],[1,0]]                                        #primitiven popravek, da ne vrne samih 0
    matrika = [[0 for i in range(v*s)] for j in range(v*s)]
    for i in range(0,v*s):
        for j in range(0,v*s):
            if i == j+1 or i == j-1 or i == j-s or j == i-s:
                matrika[i][j] = 1                                   #enice pod in nad diagonalo ali na diagonalah pod bloki
    for i in range(0,v*s, s):
        matrika[i][i-1] = 0                                         #popravek, da enice niso na celi pod oz. nad-diagonali
        matrika[i-1][i] = 0                                         #imamo toliko blokov, kot je minimum m-ja ter n-ja
    """for vrstica in matrika:                                      #to je zgolj za lepši izpis
        for element in vrstica:
            print(element, end = " ") 
        print()
    print("")"""
    return matrika


def triDmreza(m,n,st):                                              #st kot števec nadstropij
    """
    skonstruira 3D mrežo
    """
    if st == 1:                                                     #lepotni popravek, ki nas vrne v 2 dimenziji
        return mreza(m,n)
    v = min(m, n)
    s = max(m, n)
    if v == 1 and s == 2:
        matrika = [[0,1],[1,0]]                                     #da odpravimo težave pri 1x2 oz. 2x1
    else:
        matrika = [[0 for i in range(v*s*st)] for j in range(v*s*st)]
        for i in range(0,v*s):
            for j in range(0,v*s):
                if i == j+1 or i == j-1 or i == j-s or j == i-s:
                    matrika[i][j] = 1  
        for i in range(0, v*s, s):
            matrika[i][i - 1] = 0 
            matrika[i - 1][i] = 0                                      #prvi blok levo zgoraj je mreza    
        for k in range(0, st):
            for i in range(0, m*n):
                for j in range(0, m*n):
                    matrika[i + k*m*n][j + k*m*n] = matrika[i][j]       #mrežo tolikokrat reproduciramo,
        for i in range(0, m*n*(st - 1)):                                #kot imamo nadstropij
            matrika[i][m*n + i] = 1
            matrika[m*n + i][i] = 1                                     #ta for je poskrbel za povezavo med "nadstropji"
    """for vrstica in matrika:                                             #to je zgolj za lepši izpis   
        for element in vrstica:
            print(element, end = " ") 
        print()
    print("")"""
    return matrika


def binomsko_drevo(n):
    """
    skonstruira binomsko drevo z n vozlišči
    """
    matrika = [[0 for i in range(n)] for j in range(n)]             #konstruiranje prazne matrike
    for i in range(0, n):                                           #kompletna binomska drevesa se za vse n
        m = 2*i + 1                                                 #generirajo po standardnem vzorcu, ki sva
        k = 2*i + 2                                                 #ga izpeljala
        if m < n:
            matrika[i][m] = 1                                       
        if k < n:
            matrika[i][k] = 1
        if i == 0:
            matrika[i][i] = 0
        elif i % 2 == 1:
            matrika[i][math.floor((i-1)/2)] = 1
        else:
            matrika[i][math.floor((i-2)/2)] = 1
    return matrika

def FloydWarshall(graf):                                            #standarden znan algoritem
    ''' Vrne najkrajše poti med vsemi pari vozlišč '''
    n = len(graf[0])
    d = graf
    for i in range(0,n):
        for j in range(0,n):
            if d[i][j] == 0:
                d[i][j] = float('inf')
    for i in range(0,n):
        d[i][i] = 0
    for k in range(0,n):
        for i in range(0,n):
            for j in range(0,n):
                d[i][j] = min(d[i][j], d[i][k] + d[k][j])
    return d


def stolpec(matrika, j):
    ''' Vrne j-ti stolpec matrike'''
    return [vrstica[j] for vrstica in matrika]


def Voronoi_2(graf, U, tip_grafa):
    ''' Skonstruira Voronoijev diagram 
    iz matrike sosednosti (graf) na vozliščih iz U '''
    u = len(U)
    n = len(graf[0])
    m = n - u
    d = FloydWarshall(graf)                                            #d je matrika razdalj med poljubnima vozliščema
    seznam = []                                                        #seznam bo vseboval dolžine od vozlišč iz U do vseh ostalih
    for i in range(0,u):  
        seznam.append(d[U[i]-1])   
    uporabn_seznam = []
    for podseznam in seznam:
        uporabn_seznam.append([x if x != 0 else n for x in podseznam]) #vse dolžine 0 - razdalja vozlišča do sebe 
    koncni_seznam = [[element] for element in U]                       #nastavimo na število vseh vozlišč, da ne bo problemov z njimi
    for j in range(0,n):                                                
        stolpec_j = stolpec(uporabn_seznam, j)                          #skonstruiramo vektorje vseh razdalj iz U do posameznega vozlišča                      
        minimum = min(stolpec_j)                                        #poiščemo najkrajšo razdaljo v vektorju razdalj
        lokacija = [i for i, j in enumerate(stolpec_j) if j == minimum] #poiščemo lokacijo (indeks) vseh vozlišč iz U z minimalno razdaljo    
        for i in lokacija:                                              #(običajno 1, lahko jih je več - takrat moraš poiskati vse)
            if j + 1 in U:                                              #vozlišče dodamo pripadajočim vozliščem iz U
                pass
            else:
                koncni_seznam[i].append(j+1)

#zapis rezultatov, NE SPREMINJAJ
    results = {'tip_grafa':[], 'stevilo_vseh_vozlisc':[],
            'stevilo_sredisc':[], 'V_celica_id_vozlisce':[], 'V_celica_moc':[]}

    for i, celica in enumerate(koncni_seznam):

        results['tip_grafa'] += [tip_grafa]
        results['stevilo_vseh_vozlisc'] += [n]
        results['stevilo_sredisc'] += [len(koncni_seznam)]
        results['V_celica_id_vozlisce'] += [i]
        results['V_celica_moc'] += [len(celica)-1]
    
    data = pd.DataFrame(results)
    
    return data


def generiraj_vse_Voronoije(graf):
    """Generiraj vse Voronije"""

    st_vozlisc = graf.stevilo_vozlisc()
    tip_grafa = graf.TIP
    
    for i in range(0, 5):                                  #vsakič ponovimo 5x
        general_results = []

        # loopaj po vseh možnih številih
        print(f'Trenutno preračunavam {i+1}. iteracijo grafa tipa {tip_grafa} s/z {st_vozlisc} vozlišči')
        for stv in tqdm(range(1, st_vozlisc)):
            matrika = graf.generiraj()
            sp_meja = math.ceil(stv * 0.1)                          #najbolj zanimiva števila središč voronoijevih
            zg_meja = math.ceil(stv * 0.5)                          #celic bodo med 10 in 50% vseh vozlišč grafa 
            for k in range(sp_meja, zg_meja + 1):                   #generiranje voronoijevega diragrama za graf
                U = random.sample(range(0, len(matrika) + 1), k)
                general_results += [Voronoi_2(matrika, U, tip_grafa)]
                

        final_results = pd.concat(general_results, axis=0, ignore_index=True)

        final_results.index.name = 'ID'

        final_results.to_csv(f'files/rezultati_{tip_grafa}_do_{st_vozlisc}.tsv', sep='\t')


if __name__ == '__main__':                                           #generiranje podatkov za obdelovanje

    print('Sem v Main in delam')

    a = generiraj_vse_Voronoije(Mreza(4,2))
    b = generiraj_vse_Voronoije(Mreza3D(4,3,3))
    c = generiraj_vse_Voronoije(BinomskoDrevo(8))
    d = generiraj_vse_Voronoije(Cikli(8))
