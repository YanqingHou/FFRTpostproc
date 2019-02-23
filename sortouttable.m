% save(,'fitfuncs');
load('FitFuncsPfixPfILS.mat');
lens=length(fitfuncs);
idxPf=15;%15
tablelen=22;
paralen=4;
Fixtable=nan(tablelen,paralen);
Fixtablens1=coeffvalues(fitfuncs{1,idxPf});
for i=2:lens
    fitres=fitfuncs{i,idxPf};
    paravalues=coeffvalues(fitres);
    Fixtable(i,:)=[i,paravalues];
    

end
