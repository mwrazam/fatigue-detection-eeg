% Apply preprocessing to raw signal data.
%
% Preprocessing options include:
%
%   Mean Removal: Remove the mean from each input signal
%   TODO Normalization: Normalze each signal using MSE
%   TODO Noise Removal: Apply filtering to remove noise
%   TODO Standardization: Standardize each signal to between [-1,1]
%
% Input
% **********************
%   @SignalIn: Input signal double array
%
% Output
% **********************
%   @SignalOut: Output signal double array

function [SignalOut] = PreprocessData(SignalIn)

    % apply mean removal
    SignalOut = SignalIn - mean(SignalIn);
    
    % apply filters to remove noise
    % TO DO
    
    % apply other preprocessing.....
    % TOD O
    
end