function solution = printSolution(gene, numDiscs)
    solucion = ''; %aqui se van agregando los pasos
    %Estas son las torres en la posicion inicial
    tower1 = [inf, ones(1, numDiscs) * (numDiscs + 1) - [1:numDiscs]]; % este vector es [n,n-1,..,3,2,1]
    tower2 = [inf];
    tower3 = [inf];

    for m = 1:length(gene) / 3
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
                solucion = [solucion, 'mueve del 1->2, '];
            end

        end

        if chrom == [0 0 1] %mueve del 1->3

            if tower1(length(tower1)) < tower3(length(tower3))
                tower3 = [tower3, tower1(length(tower1))];
                tower1 = tower1(1:length(tower1) - 1);
                solucion = [solucion, 'mueve del 1->3, '];
            end

        end

        if chrom == [0 1 0] %mueve del 2->1

            if tower2(length(tower2)) < tower1(length(tower1))
                tower1 = [tower1, tower2(length(tower2))];
                tower2 = tower2(1:length(tower2) - 1);
                solucion = [solucion, 'mueve del 2->1, '];
            end

        end

        if chrom == [0 1 1] %mueve del 2->3

            if tower2(length(tower2)) < tower3(length(tower3))
                tower3 = [tower3, tower2(length(tower2))];
                tower2 = tower2(1:length(tower2) - 1);
                solucion = [solucion, 'mueve del 2->3, '];
            end

        end

        if chrom == [1 0 0] %mueve del 3->1

            if tower3(length(tower3)) < tower1(length(tower1))
                tower1 = [tower1, tower3(length(tower3))];
                tower3 = tower3(1:length(tower3) - 1);
                solucion = [solucion, 'mueve del 3->1, '];
            end

        end

        if chrom == [1 0 1] %mueve del 3->2

            if tower3(length(tower3)) < tower2(length(tower2))
                tower2 = [tower2, tower3(length(tower3))];
                tower3 = tower3(1:length(tower3) - 1);
                solucion = [solucion, 'mueve del 3->2, '];
            end

        end

        tower1
        tower2
        tower3

        pause(0.5)
        clc
        rnfitness = sum(tower3(2:length(tower3))');

        if rnfitness > ((numDiscs * (numDiscs + 1)) / 2) - 1 %si se consigue la solucion esta condicion termina el loop
            break
        end

    end %esto agrega los pasos a la solucion

    solution = solucion; %imprime la solucion