function [bestSoFarFit ,bestSoFarSolution ...
    ]=simpleEA( ...  % name of your simple EA function
    fitFunc, ... % name of objective/fitness function
    T, ... % total number of evaluations
    input) % replace it by your input arguments

% Check the inputs
if isempty(fitFunc)
  warning(['Objective function not specified, ''' objFunc ''' used']);
  fitFunc = 'objFunc';
end
if ~ischar(fitFunc)
  error('Argument FITFUNC must be a string');
end
if isempty(T)
  warning(['Budget not specified. 1000000 used']);
  T = '1000000';
end
eval(sprintf('objective=@%s;',fitFunc));
% Initialise variables
nbGen = 0; % generation counter
nbEval = 0; % evaluation counter
bestSoFarFit = 0; % best-so-far fitness value
bestSoFarSolution = NaN; % best-so-far solution
%recorders
fitness_gen=[]; % record the best fitness so far
solution_gen=[];% record the best phenotype of each generation
fitness_pop=[];% record the best fitness in current population 
%% Below starting your code

% Initialise a population
population = randi([input.min,input.max],input.pop_size,1);
genotypes = dec2bin(population);

% Evaluate the initial population
%% TODO
fitness = objFunc(population)

[m,idx] = max(fitness);
fitness_pop = [fitness_pop,m]
if m > bestSoFarFit
    bestSoFarFit = m;
    bestSoFarSolution = population(idx);
end

nbGen = nbGen + 1;
nbEval = nbEval + input.pop_size;
[fitness_gen,bestSoFarFit];
fitness_gen=[fitness_gen,bestSoFarFit];
solution_gen=[solution_gen,bestSoFarSolution];
% Start the loop
while (nbEval<T) 
% Reproduction (selection, crossver)
%% TODO
crossover_prob = fitness./sum(fitness);
offspring = [];
for i = 1:input.pop_size/2
    parent = [];
    for j = 1:2
        r = rand();
        for idx = 1:input.pop_size
            if r>sum(crossover_prob(1:idx-1)) && r<=sum(crossover_prob(1:idx))
                break;
            end
        end
        parent = [parent, idx];
    end
    crossover_idx = randi(input.gen_length-1);
    offspring = [offspring; [genotypes(parent(1),1:crossover_idx), genotypes(parent(2),crossover_idx+1:end)]];
    offspring = [offspring; [genotypes(parent(2),1:crossover_idx), genotypes(parent(1),crossover_idx+1:end)]];
end
% Mutation
%% TODO
mutation_prob = 0.1;
for i = 1:input.pop_size
    isMutation = rand(1,input.gen_length)<mutation_prob;
    offspring(i,isMutation) = dec2bin('1'-offspring(i,isMutation))';
end

genotypes = offspring;
population = bin2dec(genotypes);
fitness = objective(population);
[m,idx] = max(fitness);
fitness_pop = [fitness_pop,m]
if m > bestSoFarFit
    bestSoFarFit = m;
    bestSoFarSolution = population(idx);
end

nbGen = nbGen + 1;
nbEval = nbEval + input.pop_size;

fitness_gen=[fitness_gen,bestSoFarFit];
solution_gen=[solution_gen,bestSoFarSolution];

end
bestSoFarFit
bestSoFarSolution
figure,plot(1:nbGen,fitness_gen,'black')
title('fitnessGen')
figure,plot(1:nbGen,solution_gen,'blue') 
title('solutionGen')
figure,plot(1:nbGen,fitness_pop,'red') 
title('fitnessGop')

end







