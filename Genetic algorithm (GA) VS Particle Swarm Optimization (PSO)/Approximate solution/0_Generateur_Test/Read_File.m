function [ Objet_Nbr,Vect_Weight,Vect_Profit,Sac_Max_capacity ] = Read_File(path)

clc; % Netoyage de console
%% Inisialisation
iter = 1;

%% Ouvrture du fichier text
fid = fopen(path);
%% Mettre tout les caracteres du fichier séparer par un espace, dans un vecteur
data = textscan(fid,'%t','HeaderLines',0,'CollectOutput',1);
data = data{:};
%% Fermeture de la lecture
fclose(fid);
%% Récupérer les lignes
data(:,1);

k = size(data,1);

%% Recuperation des parametre du sac a dos
for i=5:k %Parcourire le vecteur
    
    if i == 5
        Objet_Nbr = str2double(data(i));
        range = (Objet_Nbr +3) + i;
    end
    
    if i >= 9 & i <= range
        Vect_Weight(1,iter) = str2double(data(i));
        iter = iter + 1;
        
        if i == range
            iter = 1;
        end
    end
    
    if i > (range+3) & i <= (range+3) + Objet_Nbr
        Vect_Profit(1,iter) = str2double(data(i));
        iter = iter + 1;
    end
    
    if i == k
        Sac_Max_capacity = str2double(data(i));
    end
    
end

end