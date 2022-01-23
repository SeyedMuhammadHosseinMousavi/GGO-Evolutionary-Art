function com=UpdateTotalOrbits(com)
global SGOSettings;
nRock=SGOSettings.nRock;
nOrbit=nRock;
for i=1:nOrbit
   com(i).sumOrbit=com(i).sumOrbit+com(i).mainOrbit;
end
end