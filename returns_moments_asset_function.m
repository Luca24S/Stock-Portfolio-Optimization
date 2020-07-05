function [retHistData,exRetAssets, sdRetAssets, corrRetAssets] = returns_moments_asset_function(finHistData)
   % Downloads market data from Yahoo Finance using the function 
    % "getMarketDataVia Yahoo" for a specified symbol and time range.
    % Here we arrange the data to make it usable.
    % 
    % INPUT:
    % finHistData - is a dataset of prices
    %
	% OUTPUT:
    % retHistData - is a dataset with the single assets returns
    % exRetAssets - is a dataset  with expected return
    % sdRetAssets - standard deviation for the single assets
    % corrRetAssets - correlation between assets returns
    %
    % Example: 
    %   data = returns_moments_asset_function(finHistData);
    % 
    % Author: Luca Sanfilippo
    
    retHistData = []; %initialize
    for k= 1:length(finHistData(1,:))
        for i = 1:(length(finHistData(:,1))-1)
        retHistData(i,k) = ((finHistData(i+1,k)- finHistData(i,k))/finHistData (i,k));
        end 
    end

    % Expected returns(AVERAGE) and stDev of single assets
    if length(retHistData(:,1))>1
        exRetAssets = mean(retHistData(:,:)); % Expected Return single assets
        varRetAssets = var(retHistData(:,:)); % variance single assets
        sdRetAssets = sqrt(varRetAssets);
        corrRetAssets = corr(retHistData);
    end
    
    outputArg1 = retHistData;
    outputArg2 = exRetAssets;
    outputArg3 = sdRetAssets;
    outputArg4 = corrRetAssets;
end

