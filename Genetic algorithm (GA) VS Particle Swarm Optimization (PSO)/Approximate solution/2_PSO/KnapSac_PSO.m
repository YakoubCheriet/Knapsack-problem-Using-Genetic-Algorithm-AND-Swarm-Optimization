function [BestFit,PSO_Exec_Time,Best_Chrom] = KnapSac_PSO( c1,c2,w )

tic; % Pour déclencher le debut de comptage du temps
%% Parametre globale
global Max_Iter Exec_Time Non_Realisable
global Objet_Nbr Pop_Size Vect_Weight Vect_Profit Sac_Max_capacity
global CRO_Bool

%% Creation de Population et Velocite
[Population,velo]= Create_Inputs_PSO( Objet_Nbr,Pop_Size );

%% Initialisataion
Gbest_fit = 0;
Fitnes_Gbest = 0;
Non_Realisable_loop = ones(1,Objet_Nbr); % Stocker les solutions non valides

% Creer matrice avec des vecteur Poids,Profit Dupliquer, pour avoir meme
% size que la population lors de la multiplication
Mat_Profit = repmat(Vect_Profit,Pop_Size,1);
Mat_Poids = repmat(Vect_Weight,Pop_Size,1);

% Initialisation de Pbest et Gbest
Pbest = zeros(Pop_Size,Objet_Nbr); % Stocker la position de PBest
Fitnes_Pbest = zeros(Pop_Size,1); % Stocker la fitness de Gbest
Gbest = zeros(1,Objet_Nbr); % Stocker la position de Gbest

%% Verification du Critere d'Arret
iter = 1;
time = Exec_Time;

if Exec_Time == -1
    time = 1;
elseif  Max_Iter == -1
    Max_Iter = 1;
    iter = 1;
end

% Parametre de Temps
t = timer('TimerFcn', 'stat=false;','StartDelay',time);
t.StartDelay = 1;
start(t) % Demarer le compteur de temps
stat=true;

if time == 1
    stat= false;
end

%% Generation Loop
while (stat == true || iter <= Max_Iter) % Condition d'arret (temps / iteration)
    
    Sum_Profit = sum((Mat_Poids.*Population)'); % Somme des Poids, et transform en vecteur horizontal
    Sum_Poids = sum((Mat_Profit.*Population)'); % Somme des Profit, et transform en vecteur horizontal
    
    for i=1:Pop_Size % Parcour de la population
        if Sum_Poids(i) > Sac_Max_capacity % Comparer somme Poids de la population avec max capacite sac
            Sum_Profit(i) = -1; % Retourner un -1
        end
    end
    
    %% MJA de Pbest
    for i=1:Pop_Size % Parcour de la population
        if Fitnes_Pbest(i) < Sum_Profit(i) % Comparer la fitness
            Fitnes_Pbest(i) = Sum_Profit(i); % MAJ de fitness de Fitnes_Pbest
            Pbest(i,:) = Population(i,:); % MJA de Pbest
        end
    end
    
    %% MJA de Gbest
    if Fitnes_Gbest < max(Fitnes_Pbest)
        [Fitnes_Gbest,Index] = max(Fitnes_Pbest);
        Gbest = Pbest(Index,:);
    end
    
    for i = 1:Pop_Size % Parcour de la population
        if Population(i,:) == Gbest % Si le Patch est le meme que Gbest
            Population(i,:) = round(rand(1,Objet_Nbr)); % Changer le Patch
        end
    end
    
    % Generation aleatoire de parametres de velocite Rndom1,Rndom2
    R1 = rand(Pop_Size,Objet_Nbr);
    R2 = rand(Pop_Size,Objet_Nbr);
    
    %% Mis a Jour de la Vilocite
    velo = velo * w + c1*R1.*(Pbest-Population)+ c2*R2.*(repmat(Gbest,Pop_Size,1)-Population);
    
    %% Mis a Jour de la Population
    Population = Population + velo;
    
    %% Binarisation
    for i=1:Pop_Size % Parcour de la population
        for j=1:Objet_Nbr
            SigF = 1 / ( 1 + exp( -velo(i,j) ) ); % Fonction Sigmoid
            if rand < SigF
                Population(i,j) = 1;
            else
                Population(i,j) = 0;
            end
        end
    end
    
    %% Evaluation
    Result = Fitness_Finder( Vect_Weight,Vect_Profit,Sac_Max_capacity,Population );
    % Recuperer les solutions non valides
    Non_Realisable_loop = cat(1,Non_Realisable_loop,Non_Realisable);
    
    %% Pour l'option de reparation (Active ou Disactiver)
    if ( CRO_Bool == 1 && rand > 0.8 )
        
%         % Passer les solution non valide en Variables globale
%         Non_Realisable = Non_Realisable_loop;
%         % Re-initialiser la variable locale
%         Non_Realisable_loop = ones(1,Objet_Nbr);
        
        %% Heuristic de Reparation
        Repaired_Chrom = CRO_Option() ;
        
        % Concat des SOLUTIONS
        Population = cat(1,Population,unique(Repaired_Chrom,'rows')); % Concaténer la pop initial avec les chrom tournoi
    end
    
    %% Remplacement (Elitisme)
    [Result, Best_sol] = Fitness_Finder( Vect_Weight,Vect_Profit,Sac_Max_capacity,Population );
    [Fitness,Index] = sort(Result, 'descend'); % Trie de Fitness
    
    Population = Population(Index(1:Pop_Size),:); % Trie de la population
    
    %% MJA de Fitness Gbest
    if Gbest_fit < Fitness(1) % Comparer les fitness
        Gbest_fit = Fitness(1); % MAJ de la Fitness Global
    end
    
    %% Verification du critere d'arret
    if time <= toc
        stat = false;
        if Max_Iter == 1
            Max_Iter = iter;
        end
    end
    
    % Generation suivante
    iter = iter + 1;
end

%% Le return des parametre
BestFit = Fitness(1); % Meilleur fitness
PSO_Exec_Time = toc;  % Meilleur chrom
Best_Chrom = Best_sol; % temps d'execution

end