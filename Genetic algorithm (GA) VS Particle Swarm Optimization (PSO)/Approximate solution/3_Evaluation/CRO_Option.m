function Repaired_Chrom = CRO_Option()

global CRO_Type

if isempty(CRO_Type) % Si la methode selectionner est vide (par erreur)
    Repaired_Chrom = CRO_Sequence(); % choisie la methode sequentille par default 
else

    if strcmp(CRO_Type,'1- Sequence') % Si la methode selectionner est Sequentielle
        Repaired_Chrom = CRO_Sequence(); % Methode sequentielle
        
    elseif strcmp(CRO_Type,'2- Profit') % Si la methode selectionner est par trie de Profit
        Repaired_Chrom = CRO_PSort(); % Methode trie par Profit descendant
        
	elseif strcmp(CRO_Type,'3- Weight') % Si la methode selectionner est par trie de Profit
        Repaired_Chrom = CRO_WSort(); % Methode trie par Poids ascendant
        
	elseif strcmp(CRO_Type,'4- Ratio (Profit / Weight)') % Si la methode selectionner est par trie de Profit
        Repaired_Chrom = CRO_RatioPW(); % Methode trie par Ration (Profit/Weight)
        
    elseif strcmp(CRO_Type,'5- Mix (1, 2, 3 & 4)') % Si la methode selectionner est Mixée

        n = randi(4); % Choisir aléatoirement une méthode de réparation

        switch n
            case 1
                Repaired_Chrom = CRO_Sequence();
            case 2
                Repaired_Chrom = CRO_PSort();
            case 3
                Repaired_Chrom = CRO_WSort();
            otherwise
                Repaired_Chrom = CRO_RatioPW();
        end
    end
end

end