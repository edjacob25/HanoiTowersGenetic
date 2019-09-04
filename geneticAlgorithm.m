function [fitness, genes] = geneticAlgorithm(numDiscs, numFathers, movements, participants, mutationRate, seed)
    %%%%%%%%%%%%%%%%%%%%%%%%% Algoritmo Genetico %%%%%%%%%%%%%%%%%%%%%%%%%%
    rng(seed)
    chromnumber = movements * 3; %numero de cromosomas en en cada gen
    genes = randi(2, numFathers, chromnumber) - 1; % estos son los genes random
    fitness = 0;

    while 1 %el loop acaba cuando se encuentra un gen que resuelve el problema
        %%%%%%%%%%%%%%%%%%%%% FITNESS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        fitness = zeros(numFathers, 1); %aqui se guarda el fitness de cada gen

        for pnumber = 1:numFathers
            gene = genes(pnumber, :);

            tower1 = [inf, ones(1, numDiscs) * (numDiscs + 1) - [1:numDiscs]]; % este vector es vector es n,n-1,..,3,2,1 es el tamaño de los discos
            tower2 = [inf];
            tower3 = [inf];

            for m = 1:length(gene) / 3 % esto revisa las instrucciones del gen y las ejecuta
                chrom = gene(3 * m - 2:3 * m);

                if chrom == [1 1 0] %por si salen los cromosomas que no tienen intrucciones
                    chrom = [0 0 0];
                end

                if chrom == [1 1 1]
                    chrom = [0 0 1];
                end

                if chrom == [0 0 0] %mueve del 1->2

                    if tower1(length(tower1)) < tower2(length(tower2))
                        tower2 = [tower2, tower1(length(tower1))];
                        tower1 = tower1(1:length(tower1) - 1);
                    end

                end

                if chrom == [0 0 1] %mueve del 1->3

                    if tower1(length(tower1)) < tower3(length(tower3))
                        tower3 = [tower3, tower1(length(tower1))];
                        tower1 = tower1(1:length(tower1) - 1);
                    end

                end

                if chrom == [0 1 0] %mueve del 2->1

                    if tower2(length(tower2)) < tower1(length(tower1))
                        tower1 = [tower1, tower2(length(tower2))];
                        tower2 = tower2(1:length(tower2) - 1);
                    end

                end

                if chrom == [0 1 1] %mueve del 2->3

                    if tower2(length(tower2)) < tower3(length(tower3))
                        tower3 = [tower3, tower2(length(tower2))];
                        tower2 = tower2(1:length(tower2) - 1);
                    end

                end

                if chrom == [1 0 0] %mueve del 3->1

                    if tower3(length(tower3)) < tower1(length(tower1))
                        tower1 = [tower1, tower3(length(tower3))];
                        tower3 = tower3(1:length(tower3) - 1);
                    end

                end

                if chrom == [1 0 1] %mueve del 3->2

                    if tower3(length(tower3)) < tower2(length(tower2))
                        tower2 = [tower2, tower3(length(tower3))];
                        tower3 = tower3(1:length(tower3) - 1);
                    end

                end

                %rnfitness=sum(tower3(2:length(tower3))'); %este es el fitnes hata el momento
                rnfitness = length(tower3) - 1;

                if rnfitness > fitness(pnumber)
                    fitness(pnumber) = rnfitness;
                end

            end

        end %aqui se saca el fitnes de cada padre

        if max(fitness) > numDiscs - 1 %si se consigue la solucion esta condicion termina el loop
            break
        end

        %%%%%%%%%%%%   TOURNAMENT SELECTION   %%%%%%%%%%%%%%%%%%%%%%%%
        matingpool = zeros(numFathers, chromnumber); %estos son los que se van a reproducir

        for tround = 1:numFathers
            tind = randperm(numFathers, participants); %indices de los participantes por torneo.
            [mval, indmax] = max(fitness(tind)); %para encontrar al mejor del torneo
            winnerindex = tind(indmax); %indice en genes del mejor del torneo
            matingpool(tround, :) = genes(winnerindex, :);
        end %aqui se sacan a los ganadores del torneo

        %%%%%%%%%%%%   CROSSOVER Y MUTACION    %%%%%%%%%%%%%%%%%%%%%%%%%
        newindividuals = zeros(numFathers, chromnumber); %aqui se guardan los genes de los nuevos individuos

        for crin = 1:numFathers / 2 %aqui se hace el crossover y la mutacion. El crossover es del primero con el segundo, el tercero con el cuarto y asi...
            crpoint = randi(chromnumber / 3 - 1) * 3; %punto del crossover;
            newindividuals(2 * crin - 1, :) = [matingpool(2 * crin - 1, 1:crpoint), matingpool(2 * crin, crpoint + 1:chromnumber)]; %este es el primer hijo
            newindividuals(2 * crin, :) = [matingpool(2 * crin, 1:crpoint), matingpool(2 * crin - 1, crpoint + 1:chromnumber)]; %este es el segundo hijo

            if rand < mutationRate %mutacion del primer hijo
                newindividuals(2 * crin - 1, randi(chromnumber)) = randi(2) - 1;
            end

            if rand < mutationRate %mutacion del segundo hijo
                newindividuals(2 * crin, randi(chromnumber)) = randi(2) - 1;
            end

        end

        genes = newindividuals; %se reemplazan los genes viejos.
    end
end


