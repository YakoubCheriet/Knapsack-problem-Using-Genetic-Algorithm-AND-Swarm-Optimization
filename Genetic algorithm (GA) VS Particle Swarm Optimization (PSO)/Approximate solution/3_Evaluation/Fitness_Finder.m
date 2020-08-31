function [ Fitness,Best_sol ] = Fitness_Finder( Vect_Weight,Vect_Profit,Sac_Max_capacity,Chrom )

global Non_Realisable % les chrom non valide
%% Initilisation
Best = 0;
Best_sol = zeros(1,size(Chrom,2));
Non_Realisable = ones(1,size(Chrom,2));
Index_NR = 1;

%% Parcourire des Chrom
for i= 1:size(Chrom,1)
    
    sum_Values=sum(Chrom(i,:).*Vect_Profit); % Calculer la somme de Profit de chrom en cours
    sum_Weights=sum(Chrom(i,:).*Vect_Weight); % Calculer la somme de Poids de chrom en cours
    
    if sum_Weights <= Sac_Max_capacity % Condition de validation
        
        Fitness(i)= sum_Values; % Sauvegarder la fitness
        
        if Best < sum_Values
            Best = sum_Values; % Sauvegarder la Meilleur fitness
            Best_sol(1,:) = Chrom(i,:); % Sauvegarder le Meilleur Chrom
        end
        
    elseif sum_Weights > Sac_Max_capacity % Sinon le retour du valeur -1
        Fitness(i) = -1; % retourner le code -1 comme erreur
        Non_Realisable(Index_NR,:) = Chrom(i,:); % % Sauvegarder des Chrom non Valides
        Index_NR = Index_NR +1;
    end
end

end