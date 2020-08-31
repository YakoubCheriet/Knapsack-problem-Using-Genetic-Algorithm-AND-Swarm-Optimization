function [ Objet_Nbr,Vect_Weight,Vect_Profit,Sac_Max_capacity ] = Read_File_Sample(path)

% Ouvrture du fichier text (path: Repertoire du fichier exemple : Tests\Hard\300-2.txt)
fid = fopen(path);
% Mettre tout les caracteres du fichier séparer par un espace, dans un vecteur
data = textscan(fid,'%t','HeaderLines',0,'CollectOutput',1);
data = data{:};
% Fermeture de la lecture
fclose(fid);
% Récupérer la première colonne
data(:,1);

iter = 1;
k = size(data,1);

% Parcourire le vecteur
for i=5:k
    
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

%% Affichage dans la Console
fprintf('**************************************************************************');
fprintf(['\n Nombre d Objet : ',num2str(Objet_Nbr),...
    '\n Vecteur Poids : ',num2str(Vect_Weight),...
    '\n Vecteur Profit :',num2str(Vect_Profit),...
    '\n Capacite sac max : ' ,num2str(Sac_Max_capacity),'\n'])
fprintf('************************************************************************** \n');

end
