function [fitres,gofit,xData, yData]=Fit_PfILS_mu(minPf_ILS, minmu)
%% Fit: 'power1'.
[xData, yData] = prepareCurveData( minPf_ILS, minmu );

% Set up fittype and options.
ft = fittype( 'power1' );
% ft = fittype( 'exp2' );

opts = fitoptions( 'Method', 'NonlinearLeastSquares' );

opts.Display = 'Off';
% opts.StartPoint = [0.37691735667143 -0.212604011046274];

% Fit model to data.
[fitres, gofit] = fit( xData, yData, ft, opts );

% Create a figure for the plots.
functxt='y=p1*exp(p2*x)+p3*exp(p4*x)';
figure( 'Name', functxt );

% Plot fit with data.
subplot( 2, 1, 1 );
h = plot( fitres, xData, yData, 'predobs', 0.9 );
legend( h, '\mu_m_i_n vs. P_f_,_I_L_S', functxt, 'Lower bounds', 'Upper bounds', 'Location', 'NorthEast' );
% Label axes
xlabel ('P_f_,_I_L_S');
ylabel ('\mu_m_i_n');
grid on

% Plot residuals.
subplot( 2, 1, 2 );
h = plot( fitres, xData, yData, 'residuals' );
legend( h, 'Residuals', 'Zero Line', 'Location', 'NorthEast' );
% Label axes
xlabel ('P_f_,_I_L_S');
ylabel ('Fitted resudual');
grid on