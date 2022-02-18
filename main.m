fitFunc = 'objFunc'; % name of objective/fitness function
T = 200; % total number of evaluations
input.pop_size = 4;
input.min = 0;
input.max = 31;
input.gen_length = 5;
[bestSoFarFit, bestSoFarSolution] = simpleEA(fitFunc, T,input);
