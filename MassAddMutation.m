function com=MassAddMutation(com)
global SGOSettings;
nRock=SGOSettings.nRock;
nOrbit=nRock;
pOrbitChange=SGOSettings.pOrbitChange;
for i=1:nOrbit
if com(i).TotalCost>=3
if rand<=pOrbitChange
com(i).TotalCost=(com(i).TotalCost)+((1/20)*(com(i).TotalCost));
end
end
end