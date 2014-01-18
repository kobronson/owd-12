#Zbiory
set SUROWCE;
set POLPRODUKTY_D;
set POLPRODUKTY_K;
set PROGI;
set KRYTERIA;
set PRODUKTY;
set POLPRODUKTY_D_uwodorniane;
#parametry 

param limit_surowcow{SUROWCE}; 
param zapotrzebowanie_przygotowalni{POLPRODUKTY_D,SUROWCE};
param przepustowosc_przygotowalni;

param zapotrzebowanie_uwodornienia {POLPRODUKTY_K,POLPRODUKTY_D_uwodorniane};
param przepustowosc_uwodornienia;


param s1_progi_kosztow{PROGI};
param s2_progi_kosztow{PROGI}; 


param koszt_s{SUROWCE};
param koszt_obrobki_s1{PROGI};
param koszt_obrobki_s2{PROGI};
param koszt_u;

param zapotrzebowanie_produktow;

#decyzyjne

var s{SUROWCE} integer >= 0;

var s1_progi{PROGI} integer >= 0;
var b_s1{PROGI} binary;
var bu;

var s2_progi{PROGI} integer >= 0;


var d{POLPRODUKTY_D} integer >= 0;
var k{POLPRODUKTY_K} integer >= 0;


var K{KRYTERIA};

var P1 integer >= 0;
var P2 integer >= 0;
var P3 integer >= 0;



##########OGRANICZENIA

subject to ogr_surowce {i in SUROWCE}:
	s[i] <= limit_surowcow[i];
	
subject to przepustowosc_przygot_d:
	sum{j in POLPRODUKTY_D} d[j] <= przepustowosc_przygotowalni;

#indeksy?? 	
subject to przygot_d {i in POLPRODUKTY_D}:
	d[i] = sum{j in SUROWCE} s[j]*zapotrzebowanie_przygotowalni[i,j];

subject to przepustowosc_uwodornienia_k:
	sum{i in POLPRODUKTY_K} k[i] <= przepustowosc_uwodornienia; 

subject to uwodornienie_k {i in POLPRODUKTY_K}:
	k[i] = sum{j in POLPRODUKTY_D_uwodorniane} d[j]*zapotrzebowanie_uwodornienia[i,j];

	
	
###Progi malejacych kosztow S1 = s11+s12+s13	

subject to s1_progi_suma:
	s[1] = sum{i in PROGI} s1_progi[i];

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

var koszt_s1 =  sum{i in PROGI} (s1_progi[i]*koszt_obrobki_s1[i]);
var koszt_s2 =  sum{i in PROGI} (s2_progi[i]*koszt_obrobki_s2[i]);

var koszt_uwodornienia= bu*koszt_u;

subject to flaga_uwodornienia:  
	(sum{i in POLPRODUKTY_K} k[i])-przepustowosc_uwodornienia*bu<=0;

##########KRYTERIA


####polprodukty K uzyte do produkcji P1 lub P2
var k1p{POLPRODUKTY_K} integer >= 0;
var k2p{POLPRODUKTY_K} integer >= 0; 

subject to produkty_k1_w_p:
	k[1] = sum{i in POLPRODUKTY_K} k1p[i];
	
subject to produkty_k2_w_p:
	k[2] = sum{i in POLPRODUKTY_K} k2p[i];

####polprodukty D1 uzyte do produkcji P1 i P3
var d1p1 integer >= 0;
var d1p3 integer >= 0;

subject to produkty_d1_w_p:
	d[1]= d1p1 +d1p3;

var p{PRODUKTY} integer >= 0;

subject to produkt1:
  p[1] = d1p1 + k1p[1] +k2p[1];

subject to produkt2:
  p[2] = ((d[2]+d[3])-(k[1]+k[2])) + k1p[2] +k2p[2];
  
subject to produkt3:
  p[3] = d1p3;


#subject to kryterium_niedoboru_p1:
#	K[1]=


subject to kryterium_kosztu:
	K[4]=koszt_surowcow+koszt_s1+koszt_s2+koszt_uwodornienia;

minimize cel: (zapotrzebowanie_produktow - p[1])/zapotrzebowanie_produktow;


	
	

	