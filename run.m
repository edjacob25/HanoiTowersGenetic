%%%%%%%%% Team Members
%Arturo Gamboa A1749802
%Jacob Rivera A01184125 
%Ernesto Campos A00759359

%%%%%%%%% Initial variables
discs = 3; %numero de discos
fathers = 10; %numero de padres
movements = 2^(discs - 1) + 1; %numero de movimientos
tnum = 3; % numero de participantes por torneo
mutrate = 0.2; %probabilidad de mutacion.
seed = 111;

[fitness, genes] = geneticAlgorithm(discs, fathers, movements, tnum, mutrate, seed);

%%%%%%%% IMPRIMIENDO LA SOLUCION %%%%%%%%%%%
[solfit, solindex] = max(fitness);
gene = genes(solindex, :); %este es el gen con la solucion
solution = printSolution(gene, discs)