function [fitresult, gof] = FitFixrate(Pf, Pfix,ns)
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
txtwidth=(maxPfix-minPfix)/8;
txtposy=maxPfix-txtwidth;

minPf=min(Pf);
maxPf=max(Pf);
% ylims=[0.75,1];
% ylimsres=[-0.02,0.03];
txtposx=(minPf+maxPf)/2;
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
subplot(2,2,1);
title('rat02');
h = plot( fitresult{1}, xData, yData );
legend( h, 'Pfix vs. Pf', 'rat02', 'Location', 'SouthWest' );
% Label axes
paravalues=coeffvalues(fitresult{1});
parabnds=confint(fitresult{1});
% legend( h, '\mu_m_i_n vs. P_f_,_I_L_S', 'y=a*x^b+c', 'Lower bounds', 'Upper bounds','Location', 'SouthWest' );
% title('Power2: y=a*x^b+c');
xlabel ('P_f_,_I_L_S');
ylabel ('Pfix');

str1=strcat('a= ',num2str(paravalues(1)),', 95% [',num2str(parabnds(1,1)),',',num2str(parabnds(2,1)),' ]');
str2=strcat('b= ',num2str(paravalues(2)),', 95% [',num2str(parabnds(1,2)),',',num2str(parabnds(2,2)),' ]');
str3=strcat('c= ',num2str(paravalues(3)),', 95% [',num2str(parabnds(1,3)),',',num2str(parabnds(2,3)),' ]');

str4=strcat('SSE: ',num2str(gof(1).sse));
str5=strcat('ad R^2: ',num2str(gof(1).adjrsquare));
str6=strcat('RMSE: ',num2str(gof(1).rmse));
% str7=strcat('ReRMSE: ',num2str(RealRMSE));

text(txtposx,txtposy,str1); 
text(txtposx,txtposy-txtwidth,str2);
text(txtposx,txtposy-2*txtwidth,str3);
text(txtposx,txtposy-3*txtwidth,str4);
text(txtposx,txtposy-4*txtwidth,str5);
text(txtposx,txtposy-5*txtwidth,str6);


grid on

%% Fit: 'poly2'.
[xData, yData] = prepareCurveData( Pf, Pfix );

% Set up fittype and options.
ft = fittype( 'poly2' );

% Fit model to data.
[fitresult{2}, gof(2)] = fit( xData, yData, ft );
subplot(2,2,2);

title('poly2');
% Plot fit with data.
% figure( 'Name', 'poly2' );
h = plot( fitresult{2}, xData, yData );
legend( h, 'Pfix vs. Pf', 'poly2', 'Location', 'SouthWest' );
paravalues=coeffvalues(fitresult{2});
parabnds=confint(fitresult{2});
% legend( h, '\mu_m_i_n vs. P_f_,_I_L_S', 'y=a*x^b+c', 'Lower bounds', 'Upper bounds','Location', 'SouthWest' );
% title('Power2: y=a*x^b+c');
xlabel ('P_f_,_I_L_S');
ylabel ('Pfix');
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
% Label axes
% xlabel Pf
% ylabel Pfix
grid on

%% Fit: 'Fourier1'.
[xData, yData] = prepareCurveData( Pf, Pfix );

% Set up fittype and options.
ft = fittype( 'fourier1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0 0 0 33.1881750854616];

% Fit model to data.
[fitresult{3}, gof(3)] = fit( xData, yData, ft, opts );

% Plot fit with data.
subplot(2,2,3);
title('fourier1');
% figure( 'Name', 'Fourier1' );
h = plot( fitresult{3}, xData, yData );
legend( h, 'Pfix vs. Pf', 'Fourier1', 'Location', 'SouthWest' );
paravalues=coeffvalues(fitresult{3});
parabnds=confint(fitresult{3});
% legend( h, '\mu_m_i_n vs. P_f_,_I_L_S', 'y=a*x^b+c', 'Lower bounds', 'Upper bounds','Location', 'SouthWest' );
% title('Power2: y=a*x^b+c');
xlabel ('P_f_,_I_L_S');
ylabel ('Pfix');
str1=strcat('a= ',num2str(paravalues(1)),', 95% [',num2str(parabnds(1,1)),',',num2str(parabnds(2,1)),' ]');
str2=strcat('b= ',num2str(paravalues(2)),', 95% [',num2str(parabnds(1,2)),',',num2str(parabnds(2,2)),' ]');
str3=strcat('c= ',num2str(paravalues(3)),', 95% [',num2str(parabnds(1,3)),',',num2str(parabnds(2,3)),' ]');
str4=strcat('d= ',num2str(paravalues(4)),', 95% [',num2str(parabnds(1,4)),',',num2str(parabnds(2,4)),' ]');

str5=strcat('SSE: ',num2str(gof(3).sse));
str6=strcat('ad R^2: ',num2str(gof(3).adjrsquare));
str7=strcat('RMSE: ',num2str(gof(3).rmse));
% str7=strcat('ReRMSE: ',num2str(RealRMSE));

text(txtposx,txtposy,str1); 
text(txtposx,txtposy-txtwidth,str2);
text(txtposx,txtposy-2*txtwidth,str3);
text(txtposx,txtposy-3*txtwidth,str4);
text(txtposx,txtposy-4*txtwidth,str5);
text(txtposx,txtposy-5*txtwidth,str6);
text(txtposx,txtposy-6*txtwidth,str7);
% Label axes
% xlabel Pf
% ylabel Pfix
grid on

%% Fit: 'exp2'.
[xData, yData] = prepareCurveData( Pf, Pfix );

% Set up fittype and options.
ft = fittype( 'exp2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [1.27285919943303 -8.22829947597533 -0.197805235595848 -31.7458355692335];

% Fit model to data.
[fitresult{4}, gof(4)] = fit( xData, yData, ft, opts );

% Plot fit with data.
% figure( 'Name', 'exp2' );
subplot(2,2,4);
title('exp2');
h = plot( fitresult{4}, xData, yData );
legend( h, 'Pfix vs. Pf', 'exp2', 'Location', 'SouthWest' );
paravalues=coeffvalues(fitresult{4});
parabnds=confint(fitresult{4});
% legend( h, '\mu_m_i_n vs. P_f_,_I_L_S', 'y=a*x^b+c', 'Lower bounds', 'Upper bounds','Location', 'SouthWest' );
% title('Power2: y=a*x^b+c');
xlabel ('P_f_,_I_L_S');
ylabel ('Pfix');
str1=strcat('a= ',num2str(paravalues(1)),', 95% [',num2str(parabnds(1,1)),',',num2str(parabnds(2,1)),' ]');
str2=strcat('b= ',num2str(paravalues(2)),', 95% [',num2str(parabnds(1,2)),',',num2str(parabnds(2,2)),' ]');
str3=strcat('c= ',num2str(paravalues(3)),', 95% [',num2str(parabnds(1,3)),',',num2str(parabnds(2,3)),' ]');
str4=strcat('d= ',num2str(paravalues(4)),', 95% [',num2str(parabnds(1,4)),',',num2str(parabnds(2,4)),' ]');

str5=strcat('SSE: ',num2str(gof(4).sse));
str6=strcat('ad R^2: ',num2str(gof(4).adjrsquare));
str7=strcat('RMSE: ',num2str(gof(4).rmse));
% str7=strcat('ReRMSE: ',num2str(RealRMSE));

text(txtposx,txtposy,str1); 
text(txtposx,txtposy-txtwidth,str2);
text(txtposx,txtposy-2*txtwidth,str3);
text(txtposx,txtposy-3*txtwidth,str4);
text(txtposx,txtposy-4*txtwidth,str5);
text(txtposx,txtposy-5*txtwidth,str6);
text(txtposx,txtposy-6*txtwidth,str7);
% Label axes
% xlabel Pf
% ylabel Pfix
grid on

