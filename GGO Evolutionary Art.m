%% Galaxy Gravity Optimization(GGO) Evolutionary Art
% Evolutionary art is a branch of generative art, in which the artist does not
% do the work of constructing the artwork, but rather lets a system do the 
% construction. Here GGO algorithm does the task. Related paper:
% Mousavi, Seyed Muhammad Hossein, S. Younes MiriNezhad, and Mir Hossein Dezfoulian. "Galaxy gravity optimization (GGO) an algorithm for optimization, inspired by comets life cycle." 2017 Artificial Intelligence and Signal Processing Conference (AISP). IEEE, 2017.
% BE HAPPY:)

%% Cleaning
clc;
clear;
close all;
warning('off');
%% Image Parameters

tmp=1;
MaxPerigee = 256;  
Image_Width = 256;
Image_Height = MaxPerigee;

%% GGO EA Runs ... !
for iii=1:Image_Width
%% Basic Parameters
% Cost Function
CostFunction = @(x) Sphere(x);        
% Number of Decision Variables
nVar = 5+tmp;            
% Decision Variables Matrix Size
VarSize = [1 nVar]; 
% Lower Bound of Variables
VarMin = -10;  
% Upper Bound of Variables
VarMax = 10;   
%Orbit Lower Bound
Orbitmin = 1;   
%Orbit Upper Bound
Orbitmax = 30+tmp;       
% -----------------------------------
%% Galaxy Gravity Optimization(GGO) Main Parameters
% Maximum Number of Iterations
% MaxPerigee = 1080;   
% Population Size
nPop = 50+tmp;         
% Number of Rocks
nRock = 25;        
%Number of Rubbles
nRubble = nPop - nRock; 
% Selection Pressure
alpha = 1;            
% Mutation Probability
pOrbitChange = 0.3;    
% Mutation Rate
mu = 0.2;            
% Effective Planets (Gravity)
Jupiter = 1;     %Jupiter
Saturn = 0.7;    %Saturn
Uranus = 0.4;    %Uranus
Neptune = 0.3;   %Neptune
% Rubbles Mean Cost Coefficient
zeta = 0.2;           
ShareSettings;

%% GGO Body
% Initialize Comets
[com,costs,rock,mainorbit]=CreateInitialComets();
% Array to Hold Best Cost Values
BestCost=zeros(MaxPerigee,1);
% Update Total Cost Mass
[com,totalmassbeforelose]=UpdateTotalCostMass(com);
%
for it=1:MaxPerigee
% Mass Loss
com=MassLose(com);
% Gravitational Mutation
[com,RockGravity]=GravitationalMutation(com);
% Mass Add Mutation
com=MassAddMutation(com);
% Update Total Orbits
com=UpdateTotalOrbits(com);
% Update Best Solution Ever Found for orbit
comorbit=[com.sumOrbit];
[bestorbitvalue, BestmainRockOrbitIndex]=max([comorbit]);
BestSol=comorbit(BestmainRockOrbitIndex);
% Update Best Cost for orbit
BestCost(it)=BestSol;
% Show Iteration Information per orbit
disp(['Perigee ' num2str(it) ': Best Orbit Cost = ' num2str(BestCost(it))....
' for Orbit index : ' num2str(BestmainRockOrbitIndex)]);
bestorbitindex(it,1)=BestmainRockOrbitIndex;
mybestorbitvalue(it,1)=bestorbitvalue;
end
roundbestvalue=round(mybestorbitvalue);
roundascend=roundbestvalue/10000;
%
ttt(:,iii)=BestCost;
hhh(:,iii)=bestorbitindex;
end;

%% Plot Generated Arts
I = mat2gray(hhh);
H = mat2gray(ttt);
%
rgbI = cat(3, H, I, I);
rgbH = cat (3, I, I, H);
% imshow(rgbI);
% figure;
% imshow(rgbH);
%
ri = imrotate(rgbI,45);
rh = imrotate(rgbH,-45);
rii = imrotate(rgbI,90);
rhh = imrotate(rgbH,-90);
% figure;
% imshow(ri+rh);
% figure;
% imshow(rii+rhh);
%
a1=ri+rh;
a2=rii+rhh;
a1=imresize(a1,[Image_Width Image_Width]);
% figure;
% imshow(a1+a2);
%
ggg=imadd(rgbI,rgbH);
% figure;
% imshow(ggg);
%
redChannel = ggg(:,:,1); % Red channel
greenChannel = ggg(:,:,2); % Green channel
blueChannel = ggg(:,:,3); % Blue channel
%
r = medfilt2(redChannel,[2 3]);
g = medfilt2(greenChannel,[2 3]);
b = medfilt2(blueChannel,[2 3]);
%
final = cat(3, r, g, b);
% figure;
% imshow(final,[]);

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,4,1)
subimage(rgbI); title ('GGO Evolutionary Generated Arts');
subplot(2,4,2)
subimage(rgbH);
subplot(2,4,3)
subimage(ri+rh);
subplot(2,4,4)
subimage(rii+rhh);
subplot(2,4,5)
subimage(a1+a2);
subplot(2,4,6)
subimage(ggg);
subplot(2,4,7)
subimage(final);
subplot(2,4,8)
subimage(I+H');

