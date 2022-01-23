function [com,totalmassbeforelose]=UpdateTotalCostMass(com)
    global SGOSettings;
    zeta=SGOSettings.zeta;    
    nRock=numel(com);    
    for k=1:nRock
    com(k).TotalCost=com(k).mainRock.Mass+zeta*mean([com(k).Rubble.Mass]);
    end
   totalmassbeforelose=com;
end