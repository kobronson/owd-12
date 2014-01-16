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
var s11 integer >=0;
var s12 integer >=0;
var s13 integer >=0;

var s21 integer >=0, <= 2733;
var s22 integer >=0, <= 4018;
var s23 integer >=0;




var bu binary;
var b1 binary;
var b2 binary;
var b3 binary;

var S1=s11+s12+s13;
var S2=s21+s22+s23;

var D1 = D1_p1 + D1_p3;
var K1 = K1_p1 + K1_p2;
var K2 = K2_p1 + K2_p2;


var P1 = D1_p1 + (K1_p1 + K2_p1);
var P2 =  ((D2 + D3)-(K1+K2)) + (K1_p2 + K2_p2);
var P3 = D1_p3;




#===================
#ilosc produktow







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



var koszt_obrobki_s1 = 19*s11+14*s12+10*s13;





subject to prog1: 2041*b1 <= s11;
subject to prog1_:  s11 <= 2041;
subject to prog2: 4398*b2 <= s12;
subject to prog2_:  s12 <= 4398*b1;

subject to prog3: 6439*b2 >= s13;









var koszt_obrobki_s2 = 12*s21+16*s22+20*s23;




var koszt_uwodornienia= bu*15000;


subject to binarne_wlacznik_uwodornienia:  (K1+K2)-8367*bu<=0;

var zysk = 193*P1+136*P2+100*P3;
var koszt_calkowity = koszt_surowcow + koszt_obrobki_s1 + koszt_obrobki_s2 + koszt_uwodornienia  ;



#cel: niedobory
var wzg_niedobor_p1 = (4917 - P1)/4917;
var wzg_niedobor_p2 = (4917 - P2)/4917;
var wzg_niedobor_p3 = (4917 - P3)/4917;





