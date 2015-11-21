function [fitresult, gof] = MyexperimentalFitsOrigPow(Pf, mu,ns)
%CREATEFITS(PF,MU)
%  Create fits.
%
%  Data for 'ns1_power1' fit:
%      X Input : Pf
%      Y Output: mu
%  Data for 'ns1_power2' fit:
%      X Input : Pf
%      Y Output: mu
%  Data for 'exp2' fit:
%      X Input : Pf
%      Y Output: mu
%  Data for 'ns1_rat21' fit:
%      X Input : Pf
%      Y Output: mu
%  Output:
%      fitresult : a cell-array of fit objects representing the fits.
%      gof : structure array with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 21-Oct-2015 14:24:05

%% Initialization.
% i=2;Pf=myfitgroup{i,1}(:,1);mu=myfitgroup{i,1}(:,2);Pfix=myfitgroup{i,1}(:,3);
% ns=i;
% Initialize arrays to store fits and goodness-of-fit.
fontsize=15;
fitresult = cell( 2, 1 );
gof = struct( 'sse', cell( 2, 1 ), ...
    'rsquare', [], 'dfe', [], 'adjrsquare', [], 'rmse', [] );
maxmu=max(mu);
minmu=min(mu);
txtwidth=(maxmu-minmu)/8;
txtposy=maxmu-txtwidth;

minPf=min(Pf);
maxPf=max(Pf);
ylims=[0.75,1];
ylimsres=[-0.02,0.03];
txtposx=(minPf+maxPf)/2;
% iternum0=200;
% stopeps=0.001;

%% Fit: 'ns1_power1'.
[xData, yData] = prepareCurveData( Pf, mu );

% Set up fittype and options.
ft = fittype( 'power1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Algorithm = 'Levenberg-Marquardt';
opts.Display = 'Off';
% opts.StartPoint = [0.0106945315846686 -0.975627188324542];
figure( 'Name', strcat('ns=',num2str(ns)));

% Fit model to data.

[fitresult{1}, gof(1)] = fit( xData, yData, ft, opts );

% Plot fit with data.
subplot(2,2,1);
h = plot( fitresult{1}, xData, yData,'predobs', 0.95 );

% funcname=formula(fitresult{1});
% paranames=coeffnames(fitresult{1});
paravalues=coeffvalues(fitresult{1});
parabnds=confint(fitresult{1});
legend( h, '\mu_m_i_n vs. P_f_,_I_L_S', 'y=a*x^b', 'Lower bounds', 'Upper bounds', 'Location', 'SouthWest' );
title('Power1: y=a*x^b');
xlabel ('P_f_,_I_L_S');
ylabel ('\mu_m_i_n');

str1=strcat('a= ',num2str(paravalues(1)),', 95% [',num2str(parabnds(1,1)),',',num2str(parabnds(2,1)),' ]');
str2=strcat('b= ',num2str(paravalues(2)),', 95% [',num2str(parabnds(1,2)),',',num2str(parabnds(2,2)),' ]');
str3=strcat('SSE: ',num2str(gof(1).sse));
str4=strcat('ad R^2: ',num2str(gof(1).adjrsquare));
str5=strcat('RMSE: ',num2str(gof(1).rmse));
% str6=strcat('ReRMSE: ',num2str(RealRMSE));

text(txtposx,txtposy,str1); 
text(txtposx,txtposy-txtwidth,str2);
text(txtposx,txtposy-2*txtwidth,str3);
text(txtposx,txtposy-3*txtwidth,str4);
text(txtposx,txtposy-4*txtwidth,str5);
% text(txtposx,txtposy-5*txtwidth,str6);
set(gca,'FontSize',fontsize);
ylim(ylims);
grid on;
subplot(2,2,3);
plot(fitresult{1},xData,yData,'Residuals');
ylim(ylimsres);
legend('Residuals','Zero line');
set(gca,'FontSize',fontsize);
grid on;

%% Fit: 'ns1_power2'.
[xData, yData] = prepareCurveData( Pf, mu );

% Set up fittype and options.
ft = fittype( 'power2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Algorithm = 'Levenberg-Marquardt';

opts.Display = 'Off';
% opts.StartPoint = [0.0106945315846686 -0.975627188324542 0.030171985325082];

% Fit model to data.
% [fitresult{2}, gof(2)] = fit( xData, yData, ft, opts );

[fitresult{2}, gof(2)] = fit( xData, yData, ft, opts );

subplot(2,2,2);
% Plot fit with data.
% figure( 'Name', 'ns1_power2' );
h = plot( fitresult{2}, xData, yData,'predobs', 0.95 );
% paranames=coeffnames(fitresult{2});
paravalues=coeffvalues(fitresult{2});
parabnds=confint(fitresult{2});
legend( h, '\mu_m_i_n vs. P_f_,_I_L_S', 'y=a*x^b+c', 'Lower bounds', 'Upper bounds','Location', 'SouthWest' );
title('Power2: y=a*x^b+c');
xlabel ('P_f_,_I_L_S');
ylabel ('\mu_m_i_n');

str1=strcat('a= ',num2str(paravalues(1)),', 95% [',num2str(parabnds(1,1)),',',num2str(parabnds(2,1)),' ]');
str2=strcat('b= ',num2str(paravalues(2)),', 95% [',num2str(parabnds(1,2)),',',num2str(parabnds(2,2)),' ]');
str3=strcat('c= ',num2str(paravalues(3)),', 95% [',num2str(parabnds(1,3)),',',num2str(parabnds(2,3)),' ]');

str4=strcat('SSE: ',num2str(gof(2).sse));
str5=strcat('ad R^2: ',num2str(gof(2).adjrsquare));
str6=strcat('RMSE: ',num2str(gof(2).rmse));
% str7=strcat('ReRMSE: ',num2str(RealRMSE));

text(txtposx,txtposy,str1); 
text(txtposx,txtposy-txtwidth,str2);
text(txtposx,txtposy-2*txtwidth,str3);
text(txtposx,txtposy-3*txtwidth,str4);
text(txtposx,txtposy-4*txtwidth,str5);
text(txtposx,txtposy-5*txtwidth,str6);
% text(txtposx,txtposy-6*txtwidth,str7);

set(gca,'FontSize',fontsize);
grid on
ylim(ylims);
subplot(2,2,4);
plot(fitresult{2},xData,yData,'Residuals');
ylim(ylimsres);

set(gca,'FontSize',fontsize);
legend('Residuals','Zero line');

grid on;
% %% Fit: 'exp2'.
% [xData, yData] = prepareCurveData( Pf, mu );
% 
% % Set up fittype and options.
% ft = fittype( 'exp2' );
% opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
% opts.Algorithm = 'Levenberg-Marquardt';
% 
% opts.Display = 'Off';
% % opts.StartPoint = [0.523479696751086 -35.5758773193383 0.668518289836885 -27.0231187478561];
% 
% % Fit model to data.
% % [fitresult{3}, gof(3)] = fit( xData, yData, ft, opts );
% 
% [fitresult{3}, gof(3)] = fit( xData, yData, ft, opts );
% 
% subplot(2,2,3);
% % Plot fit with data.
% % figure( 'Name', 'exp2' );
% h = plot( fitresult{3}, xData, yData,'predobs', 0.95 );
% % paranames=coeffnames(fitresult{3});
% paravalues=coeffvalues(fitresult{3});
% parabnds=confint(fitresult{3});
% legend( h, '\mu_m_i_n vs. P_f_,_I_L_S', 'y= a*exp(b*x) + c*exp(d*x)', 'Lower bounds', 'Upper bounds', 'Location', 'SouthWest' );
% title('exp2:y= a*exp(b*x) + c*exp(d*x)');
% xlabel ('P_f_,_I_L_S');
% ylabel ('\mu_m_i_n');
% 
% str1=strcat('a= ',num2str(paravalues(1)),', 95% [',num2str(parabnds(1,1)),',',num2str(parabnds(2,1)),' ]');
% str2=strcat('b= ',num2str(paravalues(2)),', 95% [',num2str(parabnds(1,2)),',',num2str(parabnds(2,2)),' ]');
% str3=strcat('c= ',num2str(paravalues(3)),', 95% [',num2str(parabnds(1,3)),',',num2str(parabnds(2,3)),' ]');
% str4=strcat('d= ',num2str(paravalues(4)),', 95% [',num2str(parabnds(1,4)),',',num2str(parabnds(2,4)),' ]');
% 
% str5=strcat('SSE: ',num2str(gof(3).sse));
% str6=strcat('ad R^2: ',num2str(gof(3).adjrsquare));
% str7=strcat('RMSE: ',num2str(gof(3).rmse));
% % str8=strcat('ReRMSE: ',num2str(RealRMSE));
% 
% text(txtposx,txtposy,str1); 
% text(txtposx,txtposy-txtwidth,str2);
% text(txtposx,txtposy-2*txtwidth,str3);
% text(txtposx,txtposy-3*txtwidth,str4);
% text(txtposx,txtposy-4*txtwidth,str5);
% text(txtposx,txtposy-5*txtwidth,str6);
% text(txtposx,txtposy-6*txtwidth,str7);
% % text(txtposx,txtposy-7*txtwidth,str8);
% 
% % set(gca,'FontSize',fontsize);
% 
% grid on
% 
% %% Fit: 'ns1_rat21'.
% [xData, yData] = prepareCurveData( Pf, mu );
% 
% % Set up fittype and options.
% ft = fittype( 'rat21' );
% opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
% opts.Algorithm = 'Levenberg-Marquardt';
% 
% opts.Display = 'Off';
% % opts.StartPoint = [0.933993247757551 0.678735154857773 0.757740130578333 0.743132468124916];
% 
% % Fit model to data.
% % [fitresult{4}, gof(4)] = fit( xData, yData, ft, opts );
% 
% [fitresult{4}, gof(4)] = fit( xData, yData, ft, opts );
% 
% subplot(2,2,4);
% % Plot fit with data.
% % figure( 'Name', 'ns1_rat21' );
% h = plot( fitresult{4}, xData, yData,'predobs', 0.95 );
% paranames=coeffnames(fitresult{4});
% paravalues=coeffvalues(fitresult{4});
% parabnds=confint(fitresult{4});
% legend( h, '\mu_m_i_n vs. P_f_,_I_L_S', 'y= (p1*x^2 + p2*x + p3) / (x + q1)', 'Lower bounds', 'Upper bounds', 'Location', 'SouthWest' );
% title('rat21:y= (p1*x^2 + p2*x + p3) / (x + q1)');
% xlabel ('P_f_,_I_L_S');
% ylabel ('\mu_m_i_n');
% 
% str1=strcat('p1= ',num2str(paravalues(1)),', 95% [',num2str(parabnds(1,1)),',',num2str(parabnds(2,1)),' ]');
% str2=strcat('p2= ',num2str(paravalues(2)),', 95% [',num2str(parabnds(1,2)),',',num2str(parabnds(2,2)),' ]');
% str3=strcat('p3= ',num2str(paravalues(3)),', 95% [',num2str(parabnds(1,3)),',',num2str(parabnds(2,3)),' ]');
% str4=strcat('q1= ',num2str(paravalues(4)),', 95% [',num2str(parabnds(1,4)),',',num2str(parabnds(2,4)),' ]');
% 
% str5=strcat('SSE: ',num2str(gof(4).sse));
% str6=strcat('ad R^2: ',num2str(gof(4).adjrsquare));
% str7=strcat('RMSE: ',num2str(gof(4).rmse));
% % str8=strcat('ReRMSE: ',num2str(RealRMSE));
% 
% text(txtposx,txtposy,str1); 
% text(txtposx,txtposy-txtwidth,str2);
% text(txtposx,txtposy-2*txtwidth,str3);
% text(txtposx,txtposy-3*txtwidth,str4);
% text(txtposx,txtposy-4*txtwidth,str5);
% text(txtposx,txtposy-5*txtwidth,str6);
% text(txtposx,txtposy-6*txtwidth,str7);
% % text(txtposx,txtposy-7*txtwidth,str8);
% 
% % set(gca,'FontSize',fontsize);
% grid on

set(gcf,'units','normalized','outerposition',[0 0 1 1]);

