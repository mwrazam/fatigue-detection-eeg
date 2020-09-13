% This function takes the Signals dataset and applies transformations to
% turn it into the necessary format for classification tasks.
%
% Transformations applied:
%
%   Flattening: Each 1 x 4 signal with one label is converted to a 4 x 1
%       signal with 4 labels
%   Segementation: Each signal is broken into chunks for a fixed length
%       producing multiple signals with corresponding labels
%
% Input
% **********************
%   @SignalsIn: N x 4 x T signal cell arrays (T varies for each signal)
%   @LabelsIn: N sized categorical array of ground truth labels
%
% Output
% **********************
%   @SignalsOut: M x 1 x L signal cell array (L is fixed)
%   @LabelsOut: M sized categorical array of ground truth labels


function [SignalsOut, LabelsOut] = PrepareData(SignalsIn, LabelsIn)

    % rearrange data, turn each channel to indidivudal signal with
    % corresponding label
    SignalsOut = reshape(SignalsIn, length(SignalsIn)*4,1);
    LabelsOut = repmat(LabelsIn, 4,1);

    [SignalsOut, LabelsOut] = segmentSignals(SignalsOut, LabelsOut);
    
end

function [signalsOut, labelsOut] = segmentSignals(signalsIn,labelsIn)
%SEGMENTSIGNALS makes all signals in the input array 10240 samples long

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

