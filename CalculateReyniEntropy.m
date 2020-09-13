% This function calculates the Reyni Entropy for an input signal
%
%   Input
%   **********************
%       @signal: L x 1 input signal
%       @alpha: parameter value that changes the behaviour of the entropy
%           calculation
%
%   Output
%   **********************
%       @ReyEn: Reyni entropy value
%
function ReyEn = CalculateReyniEntropy(signal, alpha)

    % number of bins for histogram
    num_bins = 50;
    
    % generate a probablity density function for the input signal
    h = histcounts(signal, num_bins, 'Normalization', 'pdf');
    
    % calculate Reyni's Entropy using the binned values
    ReyEn = log(sum(h .^ alpha))/(1-alpha);   
    
    % TO DO, need to add in other cases for alpha input

end

