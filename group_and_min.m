function [minmu,minPf_ILS,minPfix]=group_and_min(Pf_ILS,mu,Pfix,xstep)
% xstep=0.01;
xbins=min(Pf_ILS):xstep:max(Pf_ILS);
if max(xbins)<max(Pf_ILS), xbins=[xbins, max(Pf_ILS)]; end
lenbin=length(xbins);
minmu=ones(lenbin-1,1);
minPf_ILS=minmu;
minPfix=zeros(lenbin-1,1);

for i=1:lenbin-1
    ind_h=Pf_ILS<=xbins(i+1);
    ind_l=Pf_ILS>xbins(i);
    ind=ind_h & ind_l;
    tmp=mu(ind);
    if isempty(tmp)
    minmu(i)=NaN(1);
    minPf_ILS(i)=NaN(1);
    minPfix(i)=NaN(1);
    continue;
    end
    [minmu(i),minind]=min(tmp);
    tmp=Pf_ILS(ind);
    minPf_ILS(i)=tmp(minind);
    tmp=Pfix(ind);
    minPfix(i)=tmp(minind);   
end

idx=isnan(minmu); minmu(idx)=[];
idx=isnan(minPf_ILS); minPf_ILS(idx)=[];
idx=isnan(minPfix); minPfix(idx)=[];