% This function takes a set of signals with corresponding labels and
% segments them a fixed length, producing a new set of signals and
% corresponding labels.
%
% Full credit for this function goes to MathWorks. Function was adapated
% from: https://www.mathworks.com/help/signal/examples/classify-ecg-signals-using-long-short-term-memory-networks.html
%
%   Input
%   **********************
%       @signalsIn: N x 1 x T cell array of signals with varying lengths T
%       @labelsIn: N x 1 cell array of labels
%
%   Output
%   **********************
%       @signalsOut: M x 1 x L cell array of segmented signals with fixed
%           length L
%       @labelsOut: M x 1 cell array of corresponding labels
%
function [signalsOut, labelsOut] = SegmentSignals(signalsIn,labelsIn)
% Copyright 2017 The MathWorks, Inc.

targetLength = 10240;
signalsOut = {};
labelsOut = {};

for idx = 1:numel(signalsIn)
    
    x = signalsIn{idx};
    y = labelsIn(idx);
    
    % Ensure column vector
    x = x(:);
    
    % Compute the number of targetLength-sample chunks in the signal
    numSigs = floor(length(x)/targetLength);
    
    if numSigs == 0
        continue;
    end
    
    % Truncate to a multiple of targetLength
    x = x(1:numSigs*targetLength);
        
    % Create a matrix with as many columns as targetLength signals
    M = reshape(x,targetLength,numSigs); 
    
    % Repeat the label numSigs times
    y = repmat(y,[numSigs,1]);
    
    % Vertically concatenate into cell arrays
    signalsOut = [signalsOut; mat2cell(M.',ones(numSigs,1))]; %#ok<AGROW>
    labelsOut = [labelsOut; cellstr(y)]; %#ok<AGROW>
end

labelsOut = categorical(labelsOut);

end