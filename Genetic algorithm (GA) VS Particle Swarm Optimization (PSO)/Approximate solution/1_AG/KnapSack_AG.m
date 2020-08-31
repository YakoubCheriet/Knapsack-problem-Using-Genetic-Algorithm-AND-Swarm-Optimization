function [Best_Fit,AG_Exec_Time,Best_Chrom] = KnapSack_AG(Prob_Croiss,Prob_Mut)

tic; % Pour déclencher le debut de comptage du temps

%Variables Global
global  Max_Iter Exec_Time Non_Realisable
global Objet_Nbr Pop_Size Vect_Weight Vect_Profit Sac_Max_capacity
global CRO_Bool

%% Initialisation
Chrom = zeros(Pop_Size,Objet_Nbr); % Creation de la Population initial
Non_Realisable_loop = ones(1,Objet_Nbr); % Stocker les solutions non valides
time = Exec_Time;
iteration = 1; % Variable de loop de generation
loop_indx = 1; % Nombre initial de fois de régénération de la population initial
Max_Loop_indx = 10 ; % Nombre max de fois de régénération de la population initial

%% Verification du Critere d'Arret
if Exec_Time == -1
    time = 0.1;
elseif  Max_Iter == -1
    Max_Iter = 1;
    iteration = 1;
end

% Parametre de Temps
t = timer('TimerFcn', 'stat=false;','StartDelay',time);
t.StartDelay = 1;
start(t) % Demarer le compteur de temps
stat = true;


%% Generation & Evaluation Initial de la Population
while (true && loop_indx <= Max_Loop_indx)
    
    for i = 1:Pop_Size % Geneartion de la population
        Chrom (i,:) = rand(1,Objet_Nbr)>.9; % .9 générer le maximum des 1 par rapport a des 0
    end
    
    Fitness = Fitness_Finder(Vect_Weight,Vect_Profit,Sac_Max_capacity,Chrom); % Evaluation initial
    [Fitness,index] = sort(Fitness, 'descend'); % Triage de fitness
    
    Index_Finder = find(~Fitness,1,'first'); % Trouver l'index du premier chiffre = 0
    
    if Index_Finder == Pop_Size , break; end % Si pas de 0 (tout les chrom de la population initial sont valides)
    
    Chrom = Chrom(index(1:Pop_Size),:); % Re-order la population
    
    for i = Index_Finder : Pop_Size % Creation des chrom pour remplacer celle non valides
        Chrom (i,:) = rand(1,Objet_Nbr)>.9;
    end
    
    Fitness = Fitness_Finder(Vect_Weight,Vect_Profit,Sac_Max_capacity,Chrom); % Calculer la fitness a nouveau
    [Fitness,index] = sort(Fitness, 'descend'); % trie du fitness
    
    Chrom = Chrom(index(1:Pop_Size),:); % Trie de population
    
    Index_Finder = find(~Fitness,1,'first'); % Trouver l'index du premier chiffre = 0
    
    % si le taux de chrom valide et de 80% ou plus on les accept
    if (Index_Finder >= round(80/100)*Pop_Size),break;elseif (Index_Finder == Pop_Size),break;end
    
    % Sinon on refait la procédure encore une fois
    loop_indx = loop_indx + 1;
end


%% Generations (Loop)
while ( stat == true || iteration <= Max_Iter ) % Condition d'arret (temps / iteration)
    
    %% Selection par tournoi
    [Tournoi_Chrom] = Selection_Tournoi( Vect_Weight,Vect_Profit,Sac_Max_capacity,Chrom );
    Slected_Nbr = round(Pop_Size/4); % taille population en sortie apres la tournoi
    
    %% Croissement
    % Creer un point de croissement aleatoire de tout les chrom tournoi
    Cross = randi([1,Objet_Nbr - 1 ],Slected_Nbr,1)' ;
    random = rand; % nombre aleatoire ]0,1[
    Chosen_Chrom = randperm(Slected_Nbr); % indice de chrome choisi pour le croisement
    
    for n=1:Slected_Nbr % Parcoure les chrom tournoi
        if( random < Prob_Croiss ) % comparer le nombre généré avec la probabilite du Croisement
            % pour chaque chrom : selectioner un point de croiss et le croisser
            % avec un autre point d'un autre chrom de tournoi
            Tournoi_Chrom(n,1:Cross(n)) = Tournoi_Chrom(Chosen_Chrom(n),1:Cross(n));
        end
    end
    
    %% Mutation
    for n = 1:Slected_Nbr % Parcoure les chrom tournoi
        random = rand; % nombre aleatoire ]0,1[
        if( random < Prob_Mut ) % comparer le nombre généré avec la probabilite du Mutaion
            xx = randi(Objet_Nbr); % Générer aléatoire des coordonnées du chrom pour la mutation
            Tournoi_Chrom(n,xx) = 1 - Tournoi_Chrom(n,xx); % Operation de mutation
        end
    end
    
    %% Evaluation
    Fitness = Fitness_Finder(Vect_Weight,Vect_Profit,Sac_Max_capacity,Tournoi_Chrom);
    % Recuperer les solutions non valides
    Non_Realisable_loop = cat(1,Non_Realisable_loop,Non_Realisable);
    
    [Fitness,index] = sort(Fitness, 'descend'); % Trie de Fitness
    Tournoi_Chrom = Tournoi_Chrom(index(1:Slected_Nbr),:); % Trie des Chrom tournoi
    
    %% Pour l'option de reparation (Active ou Disactiver)
    if ( CRO_Bool == 1 && rand > 0.8 )
        
        % Passer les solution non valide en Variables globale
        Non_Realisable = Non_Realisable_loop;
        % Re-initialiser la variable locale
        Non_Realisable_loop = ones(1,Objet_Nbr);
        
        %% Reparation Heuristic
        Repaired_Chrom = CRO_Option() ;

        %% Cancat des solutions
        % Concaténer la pop initial avec les chrom tournoi & les chroms
        % reparer
        Chrom = cat(1,Chrom,unique(Tournoi_Chrom,'rows'),unique(Repaired_Chrom,'rows'));
    else
        %% Cancat des solutions
        Chrom = cat(1,Chrom,unique(Tournoi_Chrom,'rows')); % Concaténer la pop initial avec les chrom tournoi
    end
    
    % Calcule de la fitness
    [Fitness, Best_sol] = Fitness_Finder(Vect_Weight,Vect_Profit,Sac_Max_capacity,Chrom); % Calculer la fitness
    [Fitness,index] = sort(Fitness, 'descend'); % Trie de fitness
    
    %% Remplacement (Elitisme)
    Chrom = Chrom(index(1:Pop_Size),:); % Trie de la population
    
    %% Verification du critere d'arret
    if time <= toc % si le temps passer en parametre == au temps déclencher
        stat = false;
        
        if Max_Iter == 1
            Max_Iter = iteration;
        end
    end
    
    % next generation
    iteration = iteration +1;
end

%% Le return des parametre
Best_Fit = Fitness(1); % Meilleur fitness
Best_Chrom = Best_sol; % Meilleur chrom
AG_Exec_Time = toc; % temps d'execution

end