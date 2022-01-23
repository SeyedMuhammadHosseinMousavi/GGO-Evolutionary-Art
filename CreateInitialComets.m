function [com,costs,rock,mainorbit]=CreateInitialComets()
    global ProblemSettings;
    global SGOSettings;
    CostFunction=ProblemSettings.CostFunction;
    VarSize=ProblemSettings.VarSize;
    VarMin=ProblemSettings.VarMin;
    VarMax=ProblemSettings.VarMax;
    Orbitmin=ProblemSettings.Orbitmin;
    Orbitmax=ProblemSettings.Orbitmax;
    nPop=SGOSettings.nPop;
    nRock=SGOSettings.nRock;
    nRubble=nPop-nRock;
    alpha=SGOSettings.alpha;
    empty_rock.Position=[];
    empty_rock.Mass=[];
    rock=repmat(empty_rock,nPop,1);
    for i=1:nPop
        rock(i).Position=unifrnd(VarMin,VarMax,VarSize);        
        rock(i).Mass=CostFunction(rock(i).Position);        
    end
    orbit=repmat(nRock,1);
    for j=1:nRock
        orbit(j)=unifrnd(Orbitmin,Orbitmax);
    end    
    costs=[rock.Mass];
    [~, SortOrder]=sort(costs,'descend');    
    rock=rock(SortOrder);    
    mainrock=rock(1:nRock);        
    rubble=rock(nRock+1:end);    
    mainorbit=orbit(1:nRock);
    mainorbit=sort(mainorbit,'descend');    
    empty_comet.mainRock=[];
    empty_comet.mainOrbit=[];
    empty_comet.sumOrbit=[];
    empty_comet.Rubble=repmat(empty_rock,0,1);
    empty_comet.nRubble=0;
    empty_comet.TotalCost=[];
    com=repmat(empty_comet,nRock,1);    
    % Assign Rocks
    for k=1:nRock
        com(k).mainRock=mainrock(k);
    end    
    %Assign Orbits
    for k=1:nRock
        com(k).mainOrbit=mainorbit(k);
    end    
     for k=1:nRock
        com(k).sumOrbit=1;
     end    
    % Assign Rubbles
    P=exp(-alpha*[mainrock.Mass]/max([mainrock.Mass]));
    P=P/sum(P);
    for j=1:nRubble       
        k=RouletteWheelSelection(P);        
        com(k).Rubble=[com(k).Rubble
                    rubble(j)];       
        com(k).nRubble=com(k).nRubble+1;
    end    
    com=UpdateTotalCostMass(com);    
end