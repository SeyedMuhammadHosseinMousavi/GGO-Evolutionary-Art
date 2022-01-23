function com=MassLose(com,temporbit)
global ProblemSettings;
Orbitmax=ProblemSettings.Orbitmax;
global SGOSettings;
nRock=SGOSettings.nRock;
nOrbit=nRock;
for i=1:nOrbit
com(i).TotalCost=(com(i).TotalCost)-((Orbitmax*10)/com(i).mainOrbit);         
end