function [Vect_Weight,Vect_Profit,Sac_Max_capacity] = Create_Inputs( Profit,Poids,Objet_Nbr )

Vect_Weight = round(Poids(1,:) + (Poids(2,:)-Poids(1,:)).*rand(1,Objet_Nbr));
Vect_Profit = round(Profit(1,:) + (Profit(2,:)-Profit(1,:)).*rand(1,Objet_Nbr));

Sac_Max_capacity = round(sum(Vect_Weight)/4);

end