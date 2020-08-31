function Save_Results_GA(Result_Name)

%% Parametres Global
global AG_Best_Fit AG_Avrg_Fit AG_Fitness_Ecart AG_Best_Chrom_Found
global AG_TimeforeachTest AG_Time_All_Sec AG_Time_All_Min AG_Time_Par_Test

% Charger les variable depuis les fichier .mat
load('Global_Setting_Status.mat')
load('Menu_Setting_Status.mat')

%% Initialisation des parametre
Max_Iter = num2str(state.Max_Iter);
Exec_Time = num2str(state.Exec_Time);
Test_Iter = num2str(state.Test_Iter);
Pop_Size = num2str(state.Pop_Size);

Proba_Cross = num2str(state_GA.Proba_Cross);
Proba_Mut = num2str(state_GA.Proba_Mut);

% Discativer les affichage
warning('off','all');

%% Declaration des Entetes
headerGlob = 'KnapSack Global Settings : ';
header0 = 'KnapSack GA Settings : ';
header1 = 'Best Fitness Found : ';
header2 = 'Average Fitness Found  : ';
header3 = 'Fitness Ecart : ';
header5 = 'Total Execution Time /sec : ';
header6 = 'Total Execution Time /min : ';
header7 = 'Average Time for each Test /sec : ';
header8 = 'Best Chrom For Test ';

%% Ovrire le fichier en Ecriture
fid=fopen([Result_Name '.txt'],'wt');

%% Debut d'Ecrire dans  le Fichier TXT
fprintf(fid, '%s', '****************** Settings ******************');
fprintf(fid, ['\n\n' headerGlob '\n']);
Setting_Global = ['   Max Iteation = ' Max_Iter...
                  ';   Execution Time = ' Exec_Time ' /sec' ...
                  ';   Test Iteration = ' Test_Iter ...
                  ';   Population Size = ' Pop_Size];
fprintf(fid, '%s', (Setting_Global));

fprintf(fid, ['\n\n' header0 '\n']);
Setting = ['   Crossover Probability = ' Proba_Cross ';   Mutation Probability = ' Proba_Mut ';'];
fprintf(fid, '%s', (Setting));
fprintf(fid, '\n\n%s', '**********************************************');

fprintf(fid, ['\n \n' header1 '\n']);
fprintf(fid, '%d \r', AG_Best_Fit);

fprintf(fid, ['\n \n' header2 '\n']);
fprintf(fid, '%d \r', AG_Avrg_Fit);

fprintf(fid, ['\n \n' header3 '\n']);
fprintf(fid, '%d \r', AG_Fitness_Ecart);

fprintf(fid, ['\n \n' header5 '\n']);
fprintf(fid, '%d %s', AG_Time_All_Sec ,'Second(s)');

fprintf(fid, ['\n \n' header6 '\n']);
fprintf(fid, '%d %s', AG_Time_All_Min ,'Minute(s)');

fprintf(fid, ['\n \n' header7 '\n']);
fprintf(fid, '%d %s', AG_Time_Par_Test ,'Second(s)');

fprintf(fid, ['\n \n \n' '################ Best Chrome for-each Test Category ################' '\n']);

for i = 1:30 % Ecriture des Meilleurs Chrom Trouver Pour chaque Test
    fprintf(fid, ['\n \n' header8 num2str(i) ' :\n']);
    fprintf(fid,'%s \n', num2str(AG_Best_Chrom_Found{i}));
end

%% Fermeture de l'ecriture sur le fichier
fclose(fid);

end