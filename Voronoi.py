import random #da lahko naključno generiramo matrike

matrika1 = [[0,1,1],[1,0,0],[1,0,0]]
matrika2 = [[0,1,0,0,1,0],[1,0,0,0,1,1],[0,0,0,1,1,0],[0,0,1,0,0,0],[1,1,1,0,0,0],[0,1,0,0,0,0]]

def FloydWarshall(graf):
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

#test Floyd-Warshallovega algoritma na dveh enostavnih matrikah
#print(FloydWarshall(matrika1))
#print(FloydWarshall(matrika2))

#print(FloydWarshall(nakljucna))

def Voronoi(graf, U):#U je seznam tistih vozlišč, okrog katerih nas zanimajo
    u = len(U)
    n = len(graf[0])
    m = n - u
    print(u,n,m)
    d = FloydWarshall(graf) #d je matrika razdalj med poljubnima vozliščema
    print(d)
    seznam = [] #seznam bo vseboval dolžine od vozlišč iz U do vseh ostalih
    for i in range(0,u):  
        print("prvi for, i je ", i)
        seznam.append(d[U[i]-1])
        print("seznam razdalj do vozlisc iz U: ", seznam)
    for i in range(0,u): #odstranimo razdaljo do samega sebe ter do drugih vozlišč
        print("drugi for, i je ", i) #v množici U
        for j in reversed(range(u)):
            print("tretji for, j je ", j)
            seznam[i].pop(U[j] - 1)
            print("seznam med odstranjevanjem: ", seznam)
    transponiranseznam = list(map(list, zip(*seznam))) #transponiranje seznama seznamov
    print("transponiran seznam je: ", transponiranseznam)
    vmin = []
    for i in range(0,m): #konstrukcija vektorja minimumov razdalj
        print("cetrti for, i je ", i)
        vmin.append(min(transponiranseznam[i])) #do Voronoijevih vozlišč
        print("vektor minimumov razdalj vmin: ", vmin)
    seznamrazdalj = []
    for i in range(0,u):
        print("peti for, i je ", i)
        seznamrazdalj.append([])
        print("seznamrazdalj je trenutno ", seznamrazdalj)
        for j in range(0,m):
            print("sesti for, j je ", j)
            print("seznam je bil ", seznam)
            print("seznam[i][j] je ", seznam[i][j], " ,vmin[j] pa je ", vmin[j])
            if seznam[i][j] == vmin[j]:
                seznamrazdalj[i].append(vmin[j])
            else:
                seznamrazdalj[i].append(0)
            print("seznam razdalj dokončen je: ", seznamrazdalj)
    preostalavozlisca = [] #tista, ki niso v U
    for i in range(0,n): #napolnemo z vsemi vozlišči
        preostalavozlisca.append(i + 1)
    for i in range(0,u): #odstranimo vozlišča iz U po vrednosti
        preostalavozlisca.remove(U[i])
    V = []
    for i in range(0,u):
        V.append([U[i]])
        for j in range(0,m):
            if seznamrazdalj[i][j] != 0:
                V[i].append([preostalavozlisca[j]])
    return V

#print(Voronoi(matrika1,[1]))
#print(Voronoi(matrika1,[2,3]))
#print(Voronoi(matrika1,[1,2,3]))
#print(Voronoi(matrika1,[1,3]))
#print(Voronoi(matrika2,[1,3,6]))
#print(Voronoi(matrika2,[1,4,5]))
#print(Voronoi(matrika2,[1,3]))
#print(Voronoi(matrika2,[1,4]))
#print(Voronoi(matrika2,[1,5]))
#print(Voronoi(matrika2,[1,6]))
#print(Voronoi(matrika2,[2,1])) # -> ni prav, kje je 3?
#print(Voronoi(matrika2,[3,6]))
#print(Voronoi(matrika2,[3,6]))
#print(Voronoi(matrika2,[1,3,4,5]))
#print(Voronoi(matrika2,[5,3,4,1])) #- TLE ŠE NE DELA, AMPAK EN SORT BI MOGU REŠT
#print(Voronoi(matrika2,[1,2,3,4,5]))
#print(Voronoi(matrika2,[1,2,3,4,5,6]))
#print(Voronoi(matrika2,[1,3,4,2,6,5])) #- TLE ISTU NE DELA, AMPAK SEJ LH ZAHTEVAVA INPUT VOZLIŠČ PO VRSTI

#dim = 3
#nakljucna = [[random.randint(0,1) for _ in range(dim)] for _ in range(dim)]
#for i in range(0,dim):
#    nakljucna[i][i] = 0 #s to for zanko poskrbimo, da je vhodni, naključno
#                       #generirani graf "lep", t.j. da so na diagonali 0,
#                       #saj je razdalja do samega sebe vedno 0.

#lepši izpis te naključno generirane matrike, poimenovane nakljucna
#for vrstica in nakljucna: 
#    for element in vrstica:
#        print(element, end = " ") 
#    print()
#print("")
