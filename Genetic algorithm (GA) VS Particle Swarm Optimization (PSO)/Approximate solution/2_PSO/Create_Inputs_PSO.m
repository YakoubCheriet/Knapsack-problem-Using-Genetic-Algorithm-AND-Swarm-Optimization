function [Population,vel]= Create_Inputs_PSO( Objet_Nbr,dim )

Population = rand(dim,Objet_Nbr);
vel = rand(dim,Objet_Nbr);

end