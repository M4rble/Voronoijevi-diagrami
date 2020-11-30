#m = št. vrstic, n = št. stolpcev

def mreza(m,n):
    v = min(m,n) #da je lahko tudi več vrstic kot stolpcev,
    s = max(m,n) # saj sta to ista oz. ekvivalentna grafa
    matrika = [[0 for i in range(v*s)] for j in range(v*s)]
    for i in range(0,v*s):
        for j in range(0,v*s):
            if i == j+1 or i == j-1 or i == j-s or j == i-s:
                matrika[i][j] = 1 #enice pod in nad diagonalo ali na diagonalah pod bloki
    print(matrika)
    for i in range(0,v*s, s):
        if i == 0:
            pass
        else:
            matrika[i][i-1] = 0 #popravek, da enice niso na celi pod oz. nad-diagonali
            matrika[i-1][i] = 0 #imamo toliko blokov, kot je minimum m-ja ter n-ja
    for vrstica in matrika: #to je zgolj za lepši izpis
        for element in vrstica:
            print(element, end = " ") 
        print()
    print("")

    return matrika

#print(mreza(3,5))
#print(mreza(5,3))
#print(mreza(2,4))
#print(mreza(4,2))
#print(mreza(4,5))
#print(mreza(1,1))
#print(mreza(3,1))
#print(mreza(1,3))
#print(mreza(2,2))
print(mreza(2,1))
#print(mreza(1,2))
#print(mreza(2,3))

#Sam še pr zadnjih dveh z neznanga razloga da same ničle, ostalu je pa use ok :D 

