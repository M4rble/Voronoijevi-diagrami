import random
import numpy as np
import csv
import pandas as pd
import math


def mreza(m,n):
    '''skonstruira 2D mrežo z m vrsticami in n stolpci'''
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
    for vrstica in matrika:                                         #to je zgolj za lepši izpis
        for element in vrstica:
            print(element, end = " ") 
        print()
    print("")
    return matrika


def triDmreza(m,n,st):                                              #st kot števec nadstropij
    '''skonstruira 3D mrežo'''
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
    for vrstica in matrika:                                             #to je zgolj za lepši izpis   
        for element in vrstica:
            print(element, end = " ") 
        print()
    print("")
    return matrika


def binomsko_drevo(n):
    '''skonstruira binomsko drevo z n vozlišči'''
    matrika = [[0 for i in range(n)] for j in range(n)]
    for i in range(0, n):
        m = 2*i + 1
        k = 2*i + 2
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


def cikli(n):
    '''vzame binomsko drevo in doda k naključnih povezav'''
    matrika = binomsko_drevo(n)
    print(matrika)
    k = random.randint(1,n)
    for i in range(0,k):
        j = random.randint(0, n-1)
        if i == j:
            pass
        elif matrika[i][j] == 1:
            pass
        else:
            matrika[i][j] = 1
    return matrika


def FloydWarshall(graf):
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


def Voronoi_2(graf, U, tip_grafa='binomski'):
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
        print(koncni_seznam)

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
    print(data)

    return data


def generiraj_vse_Voronoije(st_vozlisc=8, tip_grafa='2dmreze'):
    """Generiraj vse Voronije"""
    #ročno popraviš st_vozlisc in tip_grafa na želeno za generiranje
    #za mreže mora biti st_vozlisc = stolpci * vrstice
    
    general_results = []

    # loopaj po vseh možnih številih
    for stv in range(1, st_vozlisc):
        #za mreže izpolniš ročno
        stolpci = 4
        vrstice = 2
        for k in range(1,stv):
            matrika = mreza(vrstice, stolpci)               #če je mreža
            #matrika = binomski(st_vozlisc)                 #če je binomsko drevo
            #matrika = cikli(st_vozlisc)                    #če je cikel
            print(matrika)
            U = random.sample(range(1, len(matrika)), k)
            print(U)
            general_results += [Voronoi_2(matrika, U)]
            print(general_results)


    final_results = pd.concat(general_results, axis=0, ignore_index=True)

    final_results.index.name = 'ID'

    final_results.to_csv(f'files/rezultati_{tip_grafa}_do_{st_vozlisc}.tsv', sep='\t')
