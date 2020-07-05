function [portfolioRet,portfolioExRet, sdPortfolio,VarCov] = port_function(retHistData,exRetAssets, weights)
% Compute the returns/ expected returns, VarCov assets, standard deviation
% portfolio
    % 
    % INPUT:
    % retHistData - returns for the single assets
    % exRetAssets - list with the mean of the single asset return
    % weights - weights of the portfolio 
    %
	% OUTPUT: 
    % VarCov - matrix VarCov for the different assets
    % portfolioRet - vector with the portfolio Ret
    % portfolioExRet - expected return portfolio
    % sdPortfolio - standard devation returns portfolio
    %
    % Example: 
    %   data = port_function(retHistData, exRetAssets, initWeights);
    % 
    % Author: Luca Sanfilippo

    VarCov = cov(retHistData()); % create the matrix var/cov (var for column, cov between column)

    portfolioRet = retHistData * weights; % ReturnPortfolio
    portfolioExRet = exRetAssets * weights; % ExpectedReturnPorfolio

    % SDeviation_Portfolio
    varPortfolio = var(portfolioRet); % or (initWeights' * VarCov * initWeights);
    sdPortfolio = sqrt(varPortfolio);

    outputArg1 = VarCov;
    outputArg2 = portfolioRet;
    outputArg3 = portfolioExRet;
    outputArg4 = sdPortfolio;
end

