function Save_File( Objet_Nbr,Vect_Weight,Vect_Profit,Sac_Max_capacity,TestName )

% Initial
warning('off','all'); % Disctiver les affichage d'avertissement
mkdir('Tests'); % Creer le Dossier Tests

%% Difinire les entetes
header1 = 'Nombre d Objet : ';
header3 = 'Vecteur Poids  : ';
header4 = 'Vecteur Profit : ';
header5 = 'Max Capacite Sac : ';

%% Ouvrire/Creer le fichier en lecture
fid=fopen([TestName '.txt'],'wt');

%% Debut d'ecriture dans le fichier
fprintf(fid, [header1 '\n']);
fprintf(fid, '%d', Objet_Nbr);

fprintf(fid, ['\n \n' header3 '\n']);
fprintf(fid, '%d \r', Vect_Weight);

fprintf(fid, ['\n \n' header4 '\n']);
fprintf(fid, '%d \r', Vect_Profit);

fprintf(fid, ['\n \n' header5 '\n']);
fprintf(fid, '%d', Sac_Max_capacity);

%% Fermeture d'ecriture dans le fichier
fclose(fid);