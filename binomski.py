# n - število vozlišč
import math
import random

def binomsko_drevo(n):
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
    return(matrika)

#print(binomsko_drevo(3))
#print(binomsko_drevo(5))
#print(binomsko_drevo(8))
#print(binomsko_drevo(12))

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

#print(cikli(5))
#print(cikli(8))
#print(cikli(12))