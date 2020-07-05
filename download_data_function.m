function [histdata,finHistData] = download_data_function(symbols,startDate)
    % Downloads market data from Yahoo Finance using the function 
    % "getMarketDataVia Yahoo" for a specified symbol and time range.
    % Here we arrange the data to make it usable.
    % 
    % INPUT:
    % symbol    - is a ticker symbol i.e. 'AMD', 'BTC-USD'
    % startdate - the date from which the market data will be requested
    %
	% OUTPUT:
    % histdata - is a retrieved  dataset returned as a table
    % finHistData - is a dataset returned as a double
    %
    % Example: 
    %   data = download_data_function(symbols, startDate);
    % 
    % Author: Luca Sanfilippo
 
    for i = 1:length(symbols)
        histdata = getMarketDataViaYahoo(symbols{i}, startDate);
        ts(i) = timeseries(histdata.Close, datestr(histdata(:,1).Date));
        %resamples a timeseries object tsin using a new time vector timevec
        final_ts = resample(ts(i),ts(1).Time); 
        % way to extract data from a timeseries object
        finHistData(:,i) = final_ts.Data; 
    end
    outputArg1 = histdata;
    outputArg2 = finHistData;
    
end

