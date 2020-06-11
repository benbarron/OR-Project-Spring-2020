## ------------------  PARAMETERS  ---------------------------------------------------------------------
param N;
param S;
param hub_cost{s in 1..S};				
param hub_capacity{s in 1..S};
param demand{i in 1..N, j in 1..N};                               		
param distance{i in 1..N, j in 1..N};       
param hubs{i in 1..N}, binary;                                   	                      		
## ------------------  DECISION VARIABLES  --------------------------------------------------------------
var v{i in 1..N, j in 1..N} >= 0, integer;                  
var x{i in 1..N, h in 1..N, k in 1..N, j in 1..N} >= 0, integer;  
var y{i in 1..N, s in 1..S}, binary;
## ------------------  OBJECTIVE  ---------------------------------------------------------------------
minimize annual_cost:
	sum{i in 1..N, j in 1..N: i <> j} 
		((0.22 * distance[i, j] * (x[i, i, i, j] + x[i, j, j, j])) + 
		(0.05 * distance[i, j] * x[i, i, j, j]) + 
		(0.40 * distance[i, j] * v[i, j])) +
	sum{i in 1..N, h in 1..N, j in 1..N: i <> h <> j} 
		(((0.05 * distance[i, h] + 0.22 * distance[h, j]) * x[i, i, h, j]) + 
		((0.22 * distance[i, h] + 0.05 * distance[h, j]) * x[i, h, j, j]) + 
		((0.22 * distance[i, h] + 0.22 * distance[h, j]) * x[i, h, h, j])) +
  	sum{i in 1..N, h in 1..N, k in 1..N, j in 1..N: i <> h <> k <> j} 
		((0.22 * distance[i, h] + 0.05 * distance[h, k] + 0.22 * distance[k, j]) * x[i, h, k, j]) + 
	sum{i in 1..N, s in 1..S} hub_cost[s] * y[i, s];

## ------------------  CONSTRAINTS  ------------------------------------------------------------------       
subject to c_hub_capacity_1{h in 1..N}:
	sum{i in 1..N, k in 1..N, j in 1..N} (x[i, h, k, j] + x[i, k, h, j]) 
	<= sum{s in 1..S} (y[h, s] * hub_capacity[s]);

subject to c_hub_per_city{i in 1..N}:  												
	sum{s in 1..S} y[i, s] = hubs[i];

subject to c_demand{i in 1..N, j in 1..N}: 		                            
	v[i, j] + sum{h in 1..N, k in 1..N} x[i, h, k, j] >= demand[i, j];

subject to c_fill{i in 1..N}:
	x[i, i, i, i] = 0;
