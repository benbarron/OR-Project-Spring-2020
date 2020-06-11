param N;                                                          		## number of cities
param demand{i in 1..N, j in 1..N};                               		## demand from city i to city j
param distance{i in 1..N, j in 1..N};                             		## distance from city i to city j

var v{i in 1..N, j in 1..N} >= 0, integer;                   			## units transported from i to j directly

minimize z:
  	sum{i in 1..N, j in 1..N} 0.4 * distance[i, j] * v[i, j]; 			## direct - non hub to non hub  

subject to c2{i in 1..N, j in 1..N}: 		                            ## units shipped from city i to city j via all routing 
	v[i, j] >= demand[i, j];
