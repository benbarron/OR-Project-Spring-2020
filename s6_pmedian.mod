param I;								## number of demand nodes 
param J; 								## number of canidate facility locations  
param P;								## number of facilities to build
param h{i in 1..I};						## demand for demand node i
param d{i in 1..I, j in 1..J};			## distance from demand node i to facility j

var y{i in 1..I, j in 1..J}, binary;	 	## 1 = demand node i is assigned to facility j, 0 = ow
var x{j in 1..J}, binary;					## 1 = facility is built at canidate site j, 0 = ow
 
minimize dw_distance: 
	sum{i in 1..I, j in 1..J} y[i,j] * d[i,j] * h[i];

subject to c1: 
	sum{i in 1..J} x[i] = P;

subject to c2{i in 1..I}: 
	sum{j in 1..J} y[i,j] = 1;

subject to c3{i in 1..I, j in 1..J}: 
	y[i,j] <= x[j];

