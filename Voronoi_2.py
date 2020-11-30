import random #da lahko naključno generiramo matrike
import numpy as np

matrika1 = [[0,1,1],[1,0,0],[1,0,0]]
matrika2 = [[0,1,0,0,1,0],[1,0,0,0,1,1],[0,0,0,1,1,0],[0,0,1,0,0,0],[1,1,1,0,0,0],[0,1,0,0,0,0]]

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

def Voronoi_2(graf, U):
    ''' Skonstruira Voronoijev diagram 
    iz matrike sosednosti (graf) na vozliščih iz U '''
    u = len(U)
    n = len(graf[0])
    m = n - u
    d = FloydWarshall(graf)                                            #d je matrika razdalj med poljubnima vozliščema
    seznam = []                                                        #seznam bo vseboval dolžine od vozlišč iz U do vseh ostalih
    for i in range(0,u):  
        seznam.append(d[U[i]-1])
    print("seznam razdalj do vozlisc iz U: ", seznam)    
    uporabn_seznam = []
    for podseznam in seznam:
        uporabn_seznam.append([x if x != 0 else n for x in podseznam]) #vse dolžine 0 - razdalja vozlišča do sebe 
    print ("uporabn seznam:", uporabn_seznam)                          #nastavimo na število vseh vozlišč, da ne bo problemov z njimi
    koncni_seznam = [[element] for element in U]
    print(koncni_seznam)
    for j in range(0,n):                                                
        stolpec_j = stolpec(uporabn_seznam, j)                          #skonstruiramo vektorje vseh razdalj iz U do posameznega vozlišča
        print("stolpec, ki ga gledam:", stolpec_j)                      
        minimum = min(stolpec_j)                                        #poiščemo najkrajšo razdaljo v vektorju razdalj
        print("najmanjša vrednost v stolpcu:", minimum)
        lokacija = [i for i, j in enumerate(stolpec_j) if j == minimum] #poiščemo lokacijo (indeks) vseh vozlišč iz U z minimalno razdaljo    
        print("kje vse se pojavijo te minimumi:", lokacija)             #(običajno 1, lahko jih je več - takrat moraš poiskati vse)
        for i in lokacija:                                              #vozlišče dodamo pripadajočim vozliščem iz U
            if j + 1 in U:
                pass
            else:
                koncni_seznam[i].append(j+1)
        print(koncni_seznam)
    return(koncni_seznam)

#print(Voronoi_2(matrika1,[1]))
#print(Voronoi_2(matrika1,[2,3]))
#print(Voronoi_2(matrika1,[1,2,3]))
#print(Voronoi_2(matrika1,[1,3]))
print(Voronoi_2(matrika2,[1,3,6]))
#print(Voronoi_2(matrika2,[1,4,5]))
#print(Voronoi_2(matrika2,[1,3]))
#print(Voronoi_2(matrika2,[1,4]))
#print(Voronoi_2(matrika2,[1,5]))
#print(Voronoi_2(matrika2,[1,6]))
#print(Voronoi_2(matrika2,[2,1]))
#print(Voronoi_2(matrika2,[3,6]))
#print(Voronoi_2(matrika2,[3,6]))
#print(Voronoi_2(matrika2,[1,3,4,5]))
#print(Voronoi_2(matrika2,[5,3,4,1]))
#print(Voronoi_2(matrika2,[1,2,3,4,5]))
#print(Voronoi_2(matrika2,[1,2,3,4,5,6]))
#print(Voronoi_2(matrika2,[1,3,4,2,6,5]))