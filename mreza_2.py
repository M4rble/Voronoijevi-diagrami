#m = št. vrstic, n = št. stolpcev
import numpy as np

def mreza(m,n):
    v = min(m,n) #da je lahko tudi več vrstic kot stolpcev,
    s = max(m,n) # saj sta to ista oz. ekvivalentna grafa
    if v == 1 and s == 2:
        return [[0,1],[1,0]] #primitiven popravek, da ne vrne samih 0
    matrika = [[0 for i in range(v*s)] for j in range(v*s)]
    for i in range(0,v*s):
        for j in range(0,v*s):
            if i == j+1 or i == j-1 or i == j-s or j == i-s:
                matrika[i][j] = 1 #enice pod in nad diagonalo ali na diagonalah pod bloki
    for i in range(0,v*s, s):
        matrika[i][i-1] = 0 #popravek, da enice niso na celi pod oz. nad-diagonali
        matrika[i-1][i] = 0 #imamo toliko blokov, kot je minimum m-ja ter n-ja
    for vrstica in matrika: #to je zgolj za lepši izpis
        for element in vrstica:
            print(element, end = " ") 
        print()
    print("")

    return matrika

#DELA POVSOD
#print(mreza(3,5))
#print(mreza(5,3))
#print(mreza(2,4))
#print(mreza(4,2))
#print(mreza(4,5))
#print(mreza(1,1))
#print(mreza(3,1))
#print(mreza(1,3))
#print(mreza(2,2))
#print(mreza(2,1))
#print(mreza(1,2))

def triDmreza(m,n,st): #st kot števec nadstropij
    if st == 1: #lepotni popravek, ki nas vrne v 2 dimenziji
        return mreza(m,n)
    v = min(m, n)
    s = max(m, n)
    if v == 1 and s == 2:
        matrika = [[0,1],[1,0]] #da odpravimo težave pri 1x2 oz. 2x1
    else:
        matrika = [[0 for i in range(v*s*st)] for j in range(v*s*st)]
        for i in range(0,v*s):
            for j in range(0,v*s):
                if i == j+1 or i == j-1 or i == j-s or j == i-s:
                    matrika[i][j] = 1  
        for i in range(0, v*s, s):
            matrika[i][i - 1] = 0 
            matrika[i - 1][i] = 0 #prvi blok levo zgoraj je mreza    
        for k in range(0, st):
            for i in range(0, m*n):
                for j in range(0, m*n):
                    matrika[i + k*m*n][j + k*m*n] = matrika[i][j] #mrežo tolikokrat reproduciramo,
        for i in range(0, m*n*(st - 1)):                      #kot imamo nadstropij
            matrika[i][m*n + i] = 1
            matrika[m*n + i][i] = 1 #ta for je poskrbel za povezavo med "nadstropji"
    for vrstica in matrika: #to je zgolj za lepši izpis   
        for element in vrstica:
            print(element, end = " ") 
        print()
    print("")
    return matrika

#triDmreza(3,4,3)
#triDmreza(2,2,1)
#triDmreza(3,4,1)
#triDmreza(4,1,1)
#triDmreza(4,3,1)
#triDmreza(2,2,3)
#triDmreza(2,3,5)



