# PART 1 DECLARATION OF VARIABLES (variables, parameters, sets etc)
var x_c>=0;
var x_m>=0;
# PART 2 OBJECTIVE FUNCTION: name and mathematical expression
maximize revenue:x_m+1.5*x_c;
# PART 3 CONSTRAINTS: names and corresponding mathematical expressions
subject to Aval_Time: (1/40)*x_m+(1/30)*x_c<=40;
subject to Max_Mint: x_m<=1000;
subject to Max_Cinn: x_c<=900;
