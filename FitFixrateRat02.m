function [fitresult, gof] = FitFixrateRat02(Pf, Pfix,ns)
%CREATEFITS(PF,PFIX)
%  Create fits.
%
%  Data for 'rat02' fit:
%      X Input : Pf
%      Y Output: Pfix
%  Data for 'poly2' fit:
%      X Input : Pf
%      Y Output: Pfix
%  Data for 'Fourier1' fit:
%      X Input : Pf
%      Y Output: Pfix
%  Data for 'exp2' fit:
%      X Input : Pf
%      Y Output: Pfix
%  Output:
%      fitresult : a cell-array of fit objects representing the fits.
%      gof : structure array with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 05-Nov-2015 22:20:12

%% Initialization.
maxPfix=max(Pfix);
minPfix=min(Pfix);
txtwidth=(maxPfix-minPfix)/4;
txtposy=maxPfix-txtwidth;

minPf=min(Pf);
maxPf=max(Pf);
% ylims=[0.75,1];
% ylimsres=[-0.02,0.03];
txtposx=(minPf+maxPf)/2;

ylims=[0,1];fontsize=15;
ylimsres=[-0.2,0.2];
% Initialize arrays to store fits and goodness-of-fit.
fitresult = cell( 4, 1 );
gof = struct( 'sse', cell( 4, 1 ), ...
    'rsquare', [], 'dfe', [], 'adjrsquare', [], 'rmse', [] );

figure('Name',strcat('ns=',num2str(ns)));

%% Fit: 'rat02'.
[xData, yData] = prepareCurveData( Pf, Pfix );

% Set up fittype and options.
ft = fittype( 'rat02' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.950924881573767 0.882626123493787 0.437438546090718];

% Fit model to data.
[fitresult{1}, gof(1)] = fit( xData, yData, ft, opts );

% Plot fit with data.
% figure( 'Name', 'rat02' );
% subplot(2,1,1);
figure(1);
h = plot( fitresult{1}, xData, yData );
legend( h, {'$P_{fix}$ vs. $P_{f,ILS}$', '$f_{fix}(x)$'},'interpreter','Latex','FontSize',fontsize, 'Location', 'NE' );
xlabel('$P_{f,ILS}$','interpreter','Latex','FontSize',fontsize);
ylabel('$P_{fix}$','interpreter','Latex','FontSize',fontsize);
title('$y=q_1/(x^2+q_2x+q_3)$','interpreter','Latex','FontSize',fontsize);
% set(gca,'FontSize',fontsize);
% Label axes
paravalues=coeffvalues(fitresult{1});
parabnds=confint(fitresult{1});
% legend( h, '\mu_m_i_n vs. P_f_,_I_L_S', 'y=a*x^b+c', 'Lower bounds', 'Upper bounds','Location', 'SouthWest' );
% title('Power2: y=a*x^b+c');

% 
% str1=strcat('q_1= ',num2str(paravalues(1)));%,', 95% [',num2str(parabnds(1,1)),',',num2str(parabnds(2,1)),' ]');
% str2=strcat('q_2= ',num2str(paravalues(2)));%,', 95% [',num2str(parabnds(1,2)),',',num2str(parabnds(2,2)),' ]');
% str3=strcat('q_3= ',num2str(paravalues(3)));%,', 95% [',num2str(parabnds(1,3)),',',num2str(parabnds(2,3)),' ]');

% str4=strcat('SSE: ',num2str(gof(1).sse));
% str5=strcat('ad R^2: ',num2str(gof(1).adjrsquare));
str4=strcat('RMSE: ',num2str(gof(1).rmse));
% str7=strcat('ReRMSE: ',num2str(RealRMSE));

% text(txtposx,txtposy,str1,'FontSize',fontsize); 
% text(txtposx,txtposy-txtwidth,str2,'FontSize',fontsize);
% text(txtposx,txtposy-2*txtwidth,str3,'FontSize',fontsize);
text(txtposx,txtposy-3*txtwidth,str4,'FontSize',fontsize);
% text(txtposx,txtposy-4*txtwidth,str5);
% text(txtposx,txtposy-5*txtwidth,str6);
% title('f_f_i_x(x)=q_1/(x^2+q_2x+q_3)');

set(gca,'FontSize',fontsize);

grid on

ylim(ylims);
% subplot(2,1,2);
figure(2);
plot(fitresult{1},xData,yData,'Residuals');
xlabel('$P_{f,ILS}$','interpreter','Latex','FontSize',fontsize);
% ylabel ('P_f_i_x-f_r');
ylim(ylimsres);

set(gca,'FontSize',fontsize);
legend({'$P_{fix}-\hat{P}_{fix}$', 'Zero line'},'interpreter','Latex','FontSize',fontsize, 'Location', 'NW' );

grid on;

