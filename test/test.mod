#Zbiory
set SUROWCE;
set POLPRODUKTY_D;
set POLPRODUKTY_K;
set PROGI;
set KRYTERIA;
#parametry 

param limit_surowcow{SUROWCE}; 
param zapotrzebowanie_przygotowalni{POLPRODUKTY_D,SUROWCE};
param przepustowosc_przygotowalni;

param zapotrzebowanie_uwodornienia {POLPRODUKTY_K,POLPRODUKTY_D};
param przepustowosc_uwodornienia;






#decyzyjne

var s{SUROWCE} integer >= 0;
var s1_progi{PROGI} integer >= 0;


var d{POLPRODUKTY_D} integer >= 0;
var k{POLPRODUKTY_K} integer >= 0;






#ograniczenia

subject to ogr_surowce {i in SUROWCE}:
	s[i] <= limit_surowcow[i];
	
subject to przepustowosc_przygot_d:
	sum{j in POLPRODUKTY_D} d[j] <= przepustowosc_przygotowalni;
 	
subject to przygot_d {j in POLPRODUKTY_D}:
	d[j] = sum{z in SUROWCE} s[z]*zapotrzebowanie_przygotowalni[z,j];

subject to przepustowosc_uwodornienia_k:
	sum{f in POLPRODUKTY_K} d[f] <= przepustowosc_uwodornienia; 

subject to uwodornienie_k {j in POLPRODUKTY_K}:
	k[j] = sum{kj in SUROWCE} s[kj]*zapotrzebowanie_uwodornienia[kj,j];

#czy na pewno? moze powinno byc param?	

subject to s1_progi_suma:
	s[1] = sum{pi in PROGI} s1_progi[pi];
	
 
			


#subject to prog1: 2041*b1 <= s11;
#subject to prog1_:  s11 <= 2041;
#subject to prog2: 4398*b2 <= s12;
#subject to prog2_:  s12 <= 4398*b1;
#subject to prog3: 6439*b2 >= s13;

	
	

	