# Stock Portfolio Optimization Using MATLAB
**Project Date**: July 2020

This repository contains the MATLAB implementation of a stock portfolio optimization model based on Harry Markowitz's Mean-Variance framework. The project demonstrates how to construct an optimal stock portfolio by minimizing risk (variance) for a given expected return or maximizing return for a given level of risk.

## Project Overview

The main objective of this project is to assist investors in allocating their funds among various stocks to achieve an optimal portfolio. It leverages historical stock data from Yahoo Finance to compute risk and return metrics and employs mathematical optimization techniques to derive the optimal allocation of assets.

Key features of the project:
- **Data Extraction**: Fetches historical stock data directly from Yahoo Finance.
- **Markowitz Model**: Implements the mean-variance optimization approach.
- **Efficient Frontier**: Visualizes the trade-off between risk and return for different portfolios.
- **Simulation Scenarios**: Includes randomly generated portfolios for comparative analysis.

## Repository Contents

- `Main.m`: The main script to run the portfolio optimization and visualize results.
- `getMarketDataViaYahoo.m`: Function for fetching market data from Yahoo Finance.
- `port_function.m`: Contains the core functions for portfolio calculations.
- `returns_moments_asset_function.m`: Computes returns, variances, and covariances of assets.
- `randfixedsum.m`: Utility for generating random portfolio weights with a fixed sum.
- `download_data_function.m`: Auxiliary script for data handling and pre-processing.

## Methodology

1. **Data Collection**: 
   - Historical stock data is fetched using the `getMarketDataViaYahoo` function.
   - Data includes stock prices, tickers, and time periods for analysis.

2. **Portfolio Optimization**:
   - Constructs an optimal portfolio by minimizing variance for a target return.
   - The mathematical formulation follows the Markowitz mean-variance model, incorporating constraints such as non-negative weights and fully invested portfolios.

3. **Visualization**:
   - Cumulative returns for various portfolio scenarios are plotted.
   - Efficient Frontier is displayed to highlight optimal portfolios compared to randomly generated ones.

## How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/portfolio-optimization.git
   