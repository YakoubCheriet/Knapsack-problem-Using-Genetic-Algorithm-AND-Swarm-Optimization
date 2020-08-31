function [ Tournoi_Winners ] = Selection_Tournoi( Vect_Weight,Vect_Profit,Sac_Max_capacity,Chrom )

global Pop_Size % Parametre global

%% Initialisation
Binary_Tournoi_Winner = zeros(1,size(Chrom,2)); % gagnant du tournoi binaire
Tournoi_Winners = zeros(1,size(Chrom,2)); % gagnant du tournoi Par 4
tournoi_Chrom = zeros(2,size(Chrom,2)); % Pour stocker les chrom sélectionner

Pair = 2; % Indice du tournoi binaire
Sol = 1; % Indice du gagnant du tournoi binaire

%% Generer aleatoir les chrom a selectionner
for i=1:Pop_Size + 1
    Parent1(i) = randperm(Pop_Size - 1,1);
end

%% 
for i=1 :round(Pop_Size/4)
    
    %% Permier Paire
    tournoi_Chrom = [ Chrom(Parent1(Pair-1),:); Chrom(Parent1(Pair),:) ]; % Slection un paire de chrom
    tournoi_fit = Fitness_Finder(Vect_Weight,Vect_Profit,Sac_Max_capacity,tournoi_Chrom); % Calculer la fitness
    
    if tournoi_fit(1) > tournoi_fit(2) % Comparer la fitness des deux chrom
        Binary_Tournoi_Winner(Sol) = tournoi_Chrom(1); % Sauvegarder le meilleur chrom
        winner1 = tournoi_fit(1); % Sauvegarder la fitness
    else
        Binary_Tournoi_Winner(Sol) = tournoi_Chrom(2); % Sauvegarder le meilleur chrom
        winner1 = tournoi_fit(2); % Sauvegarder la fitness
    end
    
    % MJA des Indices
    Sol = Sol + 1;
    Pair = Pair + 2;
    
    %% Deuxieme Paire
    tournoi_Chrom = [ Chrom(Parent1(Pair-1),:); Chrom(Parent1(Pair),:) ]; % Slection un paire de chrom
    tournoi_fit = Fitness_Finder(Vect_Weight,Vect_Profit,Sac_Max_capacity,tournoi_Chrom); % Calculer la fitness
    
    if tournoi_fit(1) > tournoi_fit(2) % Comparer la fitness des deux chrom
        Binary_Tournoi_Winner(Sol) = tournoi_Chrom(1); % Sauvegarder le meilleur chrom
        winner2 = tournoi_fit(1); % Sauvegarder la fitness
    else
        Binary_Tournoi_Winner(Sol) = tournoi_Chrom(2); % Sauvegarder le meilleur chrom
        winner2 = tournoi_fit(2); % Sauvegarder la fitness
    end
    
    if winner1 > winner2 % Comparer les 2 fitnes des 2 Pair (Permier Paire et Deuxieme Paire)
        Tournoi_Winners (Sol,:) = Binary_Tournoi_Winner (Sol-1); % Sauvegarder le meilleur chrom
    else
        Tournoi_Winners (Sol,:) = Binary_Tournoi_Winner (Sol); % Sauvegarder le meilleur chrom
    end
    
    % MJA des Indices
    Sol = Sol + 1;
    Pair = Pair + 2;
    
end

end