%% TITLE: Stock Portfolio Management, 4/07/2020
% Authors: Luca Sanfilippo

%% --- INITIALIZE ---
clear variables
close all
clc

% NOTICE: make sure all functions have been loaded;

%% --- 1) download market data ---
startDate = datetime(addtodate(datenum(today),-2,'year'),'ConvertFrom','datenum');
symbols = {'AAPL','CYDY','SPR', 'PLUG', 'FB','RACE', 'GE', 'RHHVF', 'AMT', 'AMZN','TM','TSLA' };
%symbols = {'AAPL','FB','SPR'};
[histdata,finHistData]=download_data_function(symbols, startDate); 

%% --- 2) compute returns,average return and variance return---
[retHistData, exRetAssets, sdRetAssets, corrRetAssets]=returns_moments_asset_function(finHistData);

%% --- 3) create portfolio with initial weigths, its returns and the Var/Cov---
digits(3)
nStocks = length(finHistData(1,:));
initWeights = [repmat(1/nStocks,nStocks,1)]; % equally weighted

[portfolioRet,portfolioExRet, sdPortfolio,VarCov] = port_function(retHistData, exRetAssets, initWeights);

% USED FORMULAS:
% % $R_p = w_{1}* R_1 + w_{2}*R_2+...$
% %%
% % $E(R_p) = w_{1}* E(R_1) + w_{2}*E(R_2)+...$

%% --- 4) set objective function, default constraints and optimize portfolio---
    %% withFormula:
    jot = ones(length(finHistData(1, :)),1);
    optimalWeights = ((inv(VarCov) * jot)/ sum((inv(VarCov) * jot))); %min variance weights 
    
    [portfolioOptimRet,portfolioOptimExRet, sdOptimPortfolio] = port_function(retHistData, exRetAssets, optimalWeights);

    %% With Optimizer:     
    
    w = sdpvar(length(initWeights),1); % decision variable
    constraints = [sum(w)==1, w>=0 ]; 
    
    objF = (w' *VarCov * w); %variance porfolio
    
    optimize(constraints, objF);
    optimalWeightsSolver = value(w);
    optimalValue = value(objF);
    
    [portfolioOptimSolverRet,portfolioOptimSolverExRet, sdOptimSolverPortfolio] = port_function(retHistData, exRetAssets, optimalWeightsSolver);
   
%% --- 5) Create the efficient frontier
 % Portfolio with different returns based on weights
    % we use the function 'randfixedsum' to extract the random weights 
    % for different scenarious to build the frontier:
    
    random_weights=randfixedsum(nStocks,20,1,-1,1)'; % 20 different random weights(2nd argument)
    % compute the portfolio returns for each scenario (one scenario for column)
    for k = 1:length(random_weights(:,1)) 
        for i = 1:length(retHistData(:,1))
            % matrix with the different combination of portfolios returns (in columns)
            front_fin_actual_return(i,k)=sum(retHistData(i,:) * random_weights(k,:)'); %#ok<SAGROW>
        end
    end
%%
% $E(R_p)= \sum_{i}{(w_i * E(R_i))}$
%expected return for all the random weights
front_fin_exp_return = exRetAssets * random_weights(:,:)';

%%
% $\sigma_{p}^2= \sum_{i}{(w_i^2 *\sigma_{i}^2)}+\sum_{i}{\sum_{j\neq i}{(w_i * w_j *\sigma_i *\sigma_j * \rho_{ij}) }}$

front_fin_var_return =random_weights * VarCov * random_weights(:,:)';
front_fin_sd_return= std(front_fin_actual_return);

%% --- 6)Plot the returns and the efficient frontier---
tiledlayout(2,1)
nexttile
% Plot cumulative Returns for initial and optimal portfolio:
rawDate = table2array(histdata(:,1));
plot(datetime(rawDate(2:length(rawDate))),cumsum(portfolioRet(:,1))); %initial
xlabel('Date');
ylabel('Cumulative Returns');
title('Portfolio Growth');
hold on
plot(datetime(rawDate(2:length(rawDate))),cumsum(portfolioOptimRet(:,1))); %formula
plot(datetime(rawDate(2:length(rawDate))),cumsum(portfolioOptimSolverRet(:,1))); %solver
legend ('Initial Portfolio ', 'Min Variance Portfolio Formula ', 'Min Variance Portfolio Solver');
hold on 

% Plot cumulative Returns for random weights portfolio, different scenarios:
plot(datetime(rawDate(2:length(rawDate))),cumsum(front_fin_actual_return(:,1:length(random_weights(:,1)))))
title ('Portfolio in different scenarios')
legend ({},'Location','northwest','NumColumns',4);
hold off

% Plot the efficient frontier with the optimal portfolio and random
% portfolios:
nexttile
scatter(front_fin_sd_return,front_fin_exp_return)
hold on
portopt(front_fin_exp_return, cov(front_fin_actual_return), nStocks)
title('Mean-Variance Efficient Frontier')
hold off

%% ==== 7) TESTS ====
%%UNCOMMENT TO TEST part 2:
%           retHistData = tick2ret(finHistData()) %verification tests with
%           a existing function

%%UNCOMMENT TO TEST part 3:
%          %Long way to compute actual portfolio ret (without matrix multiplication):
%          for k= 1:length(finHistData(1,:)) % #column
%              for i = 1:length(finHistData(:,1))-1 % #row 
%                  port(i) = sum(initWeights(k) .* retHistData(i,:));
%              end
%          end
%          portfolioRet = port'; %portfolio returns with initial weights for every day

%%UNCOMMENT TO TEST part 4:
%         %TEST the quality of the optimization with formula and solver
%         %respect the initial one
%         weights_result(:,1:3)=[initWeights,optimalWeights,optimalWeightsSolver]
%         RetBothPort(:,1:3) =[portfolioRet,portfolioOptimRet, portfolioOptimSolverRet]
%         avRet_Both_Port = [portfolioExRet, portfolioOptimExRet, portfolioOptimSolverExRet]
%         sdDev_Both_Port = [sdPortfolio,sdOptimPortfolio,sdOptimSolverPortfolio] %compare stDev portfolio standard and optimal
%   
 
