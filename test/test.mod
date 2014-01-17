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


param s1_progi_kosztow{PROGI};
param s2_progi_kosztow{PROGI}; 


param koszt_s{SUROWCE};
param koszt_obrobki_s1{PROGI};
param koszt_obrobki_s2{PROGI};
param koszt_u;

#decyzyjne

var s{SUROWCE} integer >= 0;

var s1_progi{PROGI} integer >= 0;
var b_s1{PROGI} binary;
var bu;

var s2_progi{PROGI} integer >= 0;


var d{POLPRODUKTY_D} integer >= 0;
var k{POLPRODUKTY_K} integer >= 0;


var K{KRYTERIA};



##########OGRANICZENIA

subject to ogr_surowce {i in SUROWCE}:
	s[i] <= limit_surowcow[i];
	
subject to przepustowosc_przygot_d:
	sum{j in POLPRODUKTY_D} d[j] <= przepustowosc_przygotowalni;

#indeksy?? 	
subject to przygot_d {j in POLPRODUKTY_D}:
	d[j] = sum{z in SUROWCE} s[z]*zapotrzebowanie_przygotowalni[z,j];

subject to przepustowosc_uwodornienia_k:
	sum{f in POLPRODUKTY_K} d[f] <= przepustowosc_uwodornienia; 

subject to uwodornienie_k {j in POLPRODUKTY_K}:
	k[j] = sum{kj in SUROWCE} s[kj]*zapotrzebowanie_uwodornienia[kj,j];

	
	
###Progi malejacych kosztow S1 = s11+s12+s13	

subject to s1_progi_suma:
	s[1] = sum{pi in PROGI} s1_progi[pi];

subject to s1_prog1a: 
	b_s1[1] * s1_progi_kosztow[1] <= s1_progi[1] ;	
 
subject to s1_prog1b: 
	s1_progi[1] <= 	s1_progi_kosztow[1];
	
subject to s1_prog2a:
	b_s1[2] * s1_progi_kosztow[2] <= s1_progi[2];

subject to s1_prog2b: 
	s1_progi[2] <= 	s1_progi_kosztow[2] * b_s1[1];	
	
subject to s1_prog3: 
	s1_progi[3]*b_s1[2] >= 	s1_progi_kosztow[3];
	
###Progi rosnacych kosztow S2 = s21+s22+s23

subject to s2_prog1:
	s2_progi[1] <=  s2_progi_kosztow[1];
	
subject to s2_prog2:
	s2_progi[2] <=  s2_progi_kosztow[2];

############KOSZTY

var koszt_surowcow=sum{i in SUROWCE} s[i]*k[i];

var koszt_s1 =  sum{i in PROGI} s1_progi[i]*koszt_obrobki_s1[i];
var koszt_s2 =  sum{i in PROGI} s2_progi[i]*koszt_obrobki_s2[i];

var koszt_uwodornienia= bu*koszt_u;

subject to flaga_uwodornienia:  
	(sum{i in POLPRODUKTY_K} k[i])-przepustowosc_uwodornienia*bu<=0;

##########KRYTERIA

#param P1= 
#param P2=
#param P3=
var P1 = D1_p1 + (K1_p1 + K2_p1);
var P2 =  ((D2 + D3)-(K1+K2)) + (K1_p2 + K2_p2); #     (D2 + D3)-(K1+K2) bo trzeba odjac to co zostalo wykorzystane do produkcji K1 i K2
var P3 = D1_p3;


subject to kryterium_niedoboru_p1:
	K[1]=


subject to kryterium_kosztu:
	K[4]=koszt_surowcow+koszt_s1+koszt_s2+koszt_uwodornienia;

	


	
	

	