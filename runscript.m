% function runscript
close all; clear all;
load myfitgroupAllPftol;

Pfs=[0.0005, 0.0006, 0.0007, 0.0008, 0.0009,...
    0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 0.01];
Pfslen=length(Pfs);
nsttl=66;

fitfuncs= cell( nsttl, Pfslen );
%  MyexperimentalFitsOrigPow(Pf, mu,31); 
 rmses=nan(66,4);
 Tests=zeros(66,3);
 FTs=zeros(4,66);FKs=FTs; FAs=FTs; FPVs=FTs;
%  indmins=zeros(66,1);
for i=18%1:66%31%1:nsttl%11:13%2:41%length(myfitgroup);% 
    for j=6%1:Pfslen%15%
    if isempty(myfitgroup{i,j}), continue;end
    Pf=myfitgroup{i,j}(:,1); 
    mu=myfitgroup{i,j}(:,2);
    Pfix=myfitgroup{i,j}(:,3); 
    % To fit Pf and mu

     [fitresult, gof] = MyexperimentalFitsbnd(Pf, mu,i);
     rmses(i,:)=[gof(1).rmse,gof(2).rmse,gof(3).rmse,gof(4).rmse];
     select=2;
     fitfuncs{i,j}=fitresult{select};
%     MyFitsMuPow2(Pf, mu,i);
%dead code
% % % % % %     alpha=0.1;
% % % % % %     [fitresult,gof,Accept,T,K] = FitmuwithFtest(Pf, mu,i,alpha,0);
% % % % % %     Tests(i,:)=[T,K,Accept];
% % % % % %     
% % % % % %     [fitresult, gof,FA,FT,FK,FPV] = FitmuwithFtestregress(Pf, mu,i,alpha,0);
% % % % % %     FTs(:,i)=FT; FKs(:,i)=FK; FAs(:,i)=FA; FPVs(:,i)=FPV;
% % % % % %      [fitresult, gof] = MyexperimentalFitsOrig(Pf, mu,i);
% % % % % %       saveas(gcf,strcat('FitMuCandsN',num2str(i),'.png'));
% % % % % %       close all;
% % % % % 
% % % % % %     close all;
% % % % % %     MyexperimentalFitsOrigPow(Pf, mu,i);
% % % % % % FitsbndExample(Pf, mu,i)
%%    To fit Pfix and Pf
%        FitFixrate(Pf, Pfix,i)
%       [fitresult, gof]=TryFixFits(Pf, Pfix);
%       if i==1
%          select=2;
%       else
%          select=1;
%       end
%          

    [fitresult, gof]=FitFixrateRat02(Pf, Pfix,i);
    
%       [fitresult, gof]=FitFixrateRat02draw2figs(Pf, Pfix,i);
% %     TryFixFits(Pf, Pfix);
%       fitfuncs{i,j}=fitresult{select};
%     close all;
    end
%     close all;
end
% save('FitFuncsPfixPfILS.mat','fitfuncs');
%%
close all;
% load('FitFuncsPfixPfILS.mat');
markersize=20;
fontsize=15;
figure;
scatter(ones(66,1),rmses(:,1),5,1:66,'filled'); colorbar; hold on;
scatter(2*ones(66,1),rmses(:,2),5,1:66,'filled'); colorbar; hold on;

scatter(3*ones(66,1),rmses(:,3),5,1:66,'filled'); colorbar; hold on;

scatter(4*ones(66,1),rmses(:,4),5,1:66,'filled'); colorbar; hold off;
set(gca,'yscale','log');
% semilogy(ones(66,1),rmses(:,1),'.',2*ones(66,1),rmses(:,2),'.',3*ones(66,1),rmses(:,3),'.',4*ones(66,1),rmses(:,4),'.','MarkerSize',markersize);
set(gca,'FontSize',fontsize);
grid on;
% figure;
% plot(1:66,Tests(:,1),'b-*',1:66,Tests(:,2),'r-.');
% 
% figure;
% for i=1:4
% subplot(2,2,i);
% semilogy(1:66,FKs(i,:),'r',1:66,FTs(i,:),'b-*');
% xlabel('Number of ambiguities','FontSize',fontsize);
% ylabel('Test statistics','FontSize',fontsize);
% title('Power1: y=a*x^b','FontSize',fontsize);
% legend('T','K');
% set(gca,'FontSize',fontsize);
% end
% figure
% semilogy(1:66,FTs(2,:),'b-*',1:66,FTs(4,:),'r-.');
% 
% figure;
% for i=1:4
% subplot(2,2,i);
% semilogy(1:66,FPVs(i,:),'r',1:66,FPVs(i,:),'b-*');
% end


% figure;
% h=histogram(indmins,'Normalization','probability');
% title('hist of minind');
% figure;
% h=histogram(rmses,'Normalization','probability');
% title('hist of minrmse');
