function [com,RockGravity]=GravitationalMutation(com)
global SGOSettings;
pOrbitChange=SGOSettings.pOrbitChange;
mu=SGOSettings.mu;
nRock=SGOSettings.nRock;
% RockGravity=SGOSettings.RockGravity;
nOrbit=nRock;
Jupiter=SGOSettings.Jupiter;
Saturn=SGOSettings.Saturn;
Uranus=SGOSettings.Uranus;
Neptune=SGOSettings.Neptune;
%Produce Planets Mass Amount 
for i=1:nOrbit
masses(i,1)=com(i).mainRock.Mass;
end
[maxmass indexmaxmass]=max(masses);
JupiterMassAmount=com(indexmaxmass).mainRock.Mass*2.54;
UranusMassAmount=com(indexmaxmass).mainRock.Mass*1.9;
SaturnMassAmount=com(indexmaxmass).mainRock.Mass*1.25;
NeptuneMassAmount=com(indexmaxmass).mainRock.Mass*1.14;
%Gravational Constant
G = 6.67; 
RockGravity=0;
for i=1:nOrbit
if com(i).TotalCost>=3
if rand<=pOrbitChange
temp=rand;
% Isaac Newton Gravity Formula   F = G*((m sub 1*m sub 2)/r^2)
if temp>=0 && temp<=Neptune
RockGravity=G*(NeptuneMassAmount*com(i).mainRock.Mass);
changescale=mu*com(i).mainOrbit;
com(i).mainOrbit=com(i).mainOrbit+randn*changescale;
end
if temp>Neptune && temp<=Uranus
RockGravity=G*(UranusMassAmount*com(i).mainRock.Mass);
changescale=mu*com(i).mainOrbit;
com(i).mainOrbit=com(i).mainOrbit+randn*changescale;
end
if temp>Uranus && temp<=Saturn
RockGravity=G*(SaturnMassAmount*com(i).mainRock.Mass);
changescale=mu*com(i).mainOrbit;
com(i).mainOrbit=com(i).mainOrbit+randn*changescale;
end
if temp>Saturn && temp<=Jupiter
RockGravity=G*(JupiterMassAmount*com(i).mainRock.Mass);
changescale=mu*com(i).mainOrbit;
com(i).mainOrbit=com(i).mainOrbit+randn*changescale;
end
end
end
end
end