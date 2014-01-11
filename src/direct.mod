var D1_p1 integer >=0;
var D1_p3 integer >=0;
var K1_p1 integer >=0;
var D2 integer >=0;
var D3 integer >=0;
var K1_p2 integer >=0;
var K2_p2 integer >=0;
var XA_1 integer >=0;
var K2_p1 integer >=0;


#progi S1 i S2
var s11 integer >=0, <= 2041;
var s12 integer >=0, <= 4425;
var s13 integer >=0;

var s21 integer >=0, <= 2733;
var s22 integer >=0, <= 4018;
var s23 integer >=0;

var S1=s11+s12+s13;
var S2=s21+s22+s23;


var bu binary;
var b1 binary;
var b2 binary;


var P1 = D1_p1 + (K1_p1 + K2_p1);
var P2 =  (D2 + D3) + (K1_p2 + K2_p2);
var P3 = D1_p3;

var D1 = D1_p1 + D1_p3;
var K1 = K1_p1 + K1_p2;
var K2 = K2_p1 + K2_p2;


#===================
#ilosc produktow


#subject to pp1: P1 >= 4917;
#subject to pp2: P2 >= 4917;
#subject to pp3: P3 >= 4917;





#surowce
subject to limit_s1: S1<= 11000; 
subject to limit_s2: S2<= 12000;


#przygotowalnia

subject to d1: D1=0.4*S1+0.1*S2;
subject to d2: D2=0.3*S1+0.8*S2;
subject to d3: D3=0.3*S1+0.1*S2;
subject to przepustowosc_przygotowalni: D1+D2+D3<=16700;

#uwodornienie

subject to k1: K1=0.6*D2+0.6*D3;
subject to k2: K2=0.4*D2+0.4*D3;
subject to przepustowosc_uwodornienia: K1+K2<=8367;

#cel: koszty

var koszt_surowcow=130*S1+110*S2;
var koszt_obrobki_s1 = 19*s11+b1*14*s12+b2*10*s13;




subject to binarne_s1_prog1: S1 >= 2041*b1;
subject to binarne_s1_prog2: S1 >= 6439*b2;


var koszt_obrobki_s2 = 12*s21+16*s22+20*s23;




var koszt_uwodornienia= bu*15000;


subject to binarne_wlacznik_uwodornienia: K1+K2>=1*bu;

var zysk = 193*P1+136*P2+100*P3;
var koszt_calkowity = koszt_surowcow + koszt_obrobki_s1 + koszt_obrobki_s2 + koszt_uwodornienia - zysk;



#cel: niedobory
var wzg_niedobor_p1 = 4097 - P1;
var wzg_niedobor_p2 = 4097 - P2;
var wzg_niedobor_p3 = 4097 - P3;

minimize cel: wzg_niedobor_p1 + wzg_niedobor_p2 + wzg_niedobor_p3 + koszt_calkowity;



