function Repaired_Chrom = CRO_Sequence()

% Variables Globales
global Objet_Nbr Vect_Weight Vect_Profit Sac_Max_capacity
global Non_Realisable

NR_Size = size(Non_Realisable,1); % Calculer le nombre de lignes
Repaired_Chrom = Non_Realisable; % Initialisation

Mat_Weight = repmat(Vect_Weight,NR_Size,1); % Transformer le vecteur en Matrice
Get_Chrom_Weight = (Non_Realisable.*Mat_Weight); % Calculer le poids de chaque chrome

for i = 1 : NR_Size % Parcourire les chromes
    
    for j = 1 : Objet_Nbr % Parcourire les objets
        
        if ( sum(Get_Chrom_Weight') < Sac_Max_capacity ) & (rand < 0.2) % Condition
            if Repaired_Chrom (i,j) == 0 % si l'objet n'est pas deja slectionner
                Repaired_Chrom (i,j) = 1; % selectionner l'objet
            end
        else
            if Repaired_Chrom (i,j) == 1 % si l'objet est deja slectionner
                Repaired_Chrom (i,j) = 0; % enlever l'objet
            end
        end
        
        % Calculer la fitnes apres la modification
        Fit = Fitness_Finder (Vect_Weight,Vect_Profit,Sac_Max_capacity,Repaired_Chrom(i,:)) ;
        
        % Condition de satisfaction
        if (Fit ~= -1 && Fit ~= 0) ,break; end
        
    end
    
end

end