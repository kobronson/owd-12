# PART 1 DECLARATION OF VARIABLES (variables, parameters, sets etc)
var p1>=4197;
var p2>=4197;
var p3>=4197;







var zysk = 193*p1+136*p2+100*p3;
var koszt = 130*s1+110*s2 + 19*s1_1+b1*14*s1_2+b2*10*s1_3 + 12*s2_1+16*s2_2+20*s2_3 + uwodornienie;





p1= d1 + k1 lub k2
p2= d2+ d3 + k1 lub k2
p3 = d1


#wstepna obrobka d1,d2,d3
s1=s1_1+s1_2+s1_3;
s2=s2_1+s2_2+s2_3;


subject to koszt_obrobka_s2_1: s2_1 <= 2733;
subject to koszt_obrobka_s2_2: 2733 <= s2_2 <= 6751 ;
subject to koszt_obrobka_s2_3: 6751 <= s2_3;

subject to wstepna_obrobka:  d1 + d2 + d3 <= 16700 # przepustowosc
subject to wstepna_obrobka_d1: 0.4*s1 + 0.1*s2  #do produkcji P1 i P3
subject to wstepna_obrobka_d2: 0.3*s1 + 0.8*s2  #do produkcji P2
subject to wstepna_obrobka_d3: 0.3*s1 + 0.1*s2  #do produkcji P2


#uwodornienie

subject to uwodornienie:  k1 + k2 <= 8367 # przepustowosc
subject to uwodornienie_k1:  0.6*d2+0.6*d3  # produkcja p1 i p2
subject to uwodornienie_k2:  0.4*d2+0.4*d3  # produkcja p1 i p2








# PART 2 OBJECTIVE FUNCTION: name and mathematical expression
maximize revenue:x_m+1.5*x_c;
# PART 3 CONSTRAINTS: names and corresponding mathematical expressions
subject to Aval_Time: (1/40)*x_m+(1/30)*x_c<=40;
subject to Max_Mint: x_m<=1000;
subject to Max_Cinn: x_c<=900;
