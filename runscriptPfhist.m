% function runscriptPfhist
close all; clear all;
load FitFuncsMuPfILS;

Pfs=[0.0005, 0.0006, 0.0007, 0.0008, 0.0009,...
    0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 0.01];
Pfslen=length(Pfs);
% nsttl=42;
nsttl=size(fitfuncs,1);
pcnts=zeros(Pfslen);
for i=1:Pfslen
   pcnts(i) = Pfhist(fitfuncs{:,i},Pfs(i));
end


% fitfuncs= cell( nsttl, Pfslen );
% 
% for i=1:nsttl%11:13%2:41%length(myfitgroup);% 
%     for j=1:Pfslen
%     if isempty(myfitgroup{i,j}), continue;end
%     Pf=myfitgroup{i,j}(:,1); 
%     mu=myfitgroup{i,j}(:,2);
%     Pfix=myfitgroup{i,j}(:,3); 
%     [fitresult, gof] = MyexperimentalFitsbnd(Pf, mu,i);
%     if i<12, select=1; else select=2; end
%     fitfuncs{i,j}=fitresult{select};
% %     MyexperimentalFitsOrigPow(Pf, mu,i); 
% %     FitFixrate(Pf, Pfix,i);
%     end
%     close all;
% end
% save('FitFuncsMuPfILS.mat','fitfuncs');