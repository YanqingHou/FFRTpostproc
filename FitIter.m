% function FitIter

close all; clear all;
load myfitgroup;
ns=11;
Pf=myfitgroup{ns,1}(:,1); 
mu=myfitgroup{ns,1}(:,2);


maxmu=max(mu);
minmu=min(mu);
txtwidth=(maxmu-minmu)/8;
txtposy=maxmu-txtwidth;

minPf=min(Pf);
maxPf=max(Pf);
txtposx=(minPf+maxPf)/2;
iternum0=200;
stopeps=0.001;

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
maxres=1;
yhat=yData;
iternum=iternum0;
weights=0.5*ones(length(xData),1);
while maxres>stopeps && iternum>0
iternum=iternum-1;
% opts = fitoptions('Weights',weights);

opts = fitoptions( 'Method', 'NonlinearLeastSquares','Weights',weights);
opts.Algorithm = 'Levenberg-Marquardt';
opts.Display = 'Off';

[fitresult{1}, gof(1),output] = fit( xData, yhat, ft, opts );
resi=output.residuals;
ind=resi<0;
yhat=fitresult{1}(xData);
yhat(ind)=yData(ind);

h = plot( fitresult{1}, xData, yData); hold on;
weights=abs(resi);
% weights=0.5*ones(length(xData),1);
% weights(ind)=1;

maxres=max(abs(resi(ind)));
end
numofcoef=2;
v=length(yData)-numofcoef;
RealRes=yData-fitresult{1}(xData);
RealRMSE=sqrt(RealRes'*RealRes/v);
% Plot fit with data.
h = plot( fitresult{1}, xData, yData);%,'predobs', 0.9 );

% funcname=formula(fitresult{1});
% paranames=coeffnames(fitresult{1});
paravalues=coeffvalues(fitresult{1});
parabnds=confint(fitresult{1});
legend( h, '\mu_m_i_n vs. P_f_,_I_L_S', 'y=a*x^b', 'Lower bounds', 'Upper bounds', 'Location', 'NorthEast' );
title('Power1: y=a*x^b');
xlabel ('P_f_,_I_L_S');
ylabel ('\mu_m_i_n');

str1=strcat('a= ',num2str(paravalues(1)),', 95% [',num2str(parabnds(1,1)),',',num2str(parabnds(2,1)),' ]');
str2=strcat('b= ',num2str(paravalues(2)),', 95% [',num2str(parabnds(1,2)),',',num2str(parabnds(2,2)),' ]');
str3=strcat('SSE: ',num2str(gof(1).sse));
str4=strcat('ad R^2: ',num2str(gof(1).adjrsquare));
str5=strcat('RMSE: ',num2str(gof(1).rmse));
str6=strcat('ReRMSE: ',num2str(RealRMSE));

text(txtposx,txtposy,str1); 
text(txtposx,txtposy-txtwidth,str2);
text(txtposx,txtposy-2*txtwidth,str3);
text(txtposx,txtposy-3*txtwidth,str4);
text(txtposx,txtposy-4*txtwidth,str5);
text(txtposx,txtposy-5*txtwidth,str6);
% set(gca,'FontSize',fontsize);

grid on