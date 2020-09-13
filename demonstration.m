clc; clear; close all; 

% set up folder paths and define what data to use
path_to_raw_data = pwd + "/Data/Raw";
path_to_saved_data = pwd + "/Data/Matlab";
datasets_to_use = ["2018", "2019"];

% set flags for data load operations
reload_data = false;
recalculate_entropies = false; % WARNING: Recalculating entropies can take 14+ hours if used on raw data

% perform data load
[Signals, Labels] = LoadData(path_to_raw_data, path_to_saved_data, datasets_to_use, reload_data);

% Randomize, apply segementation and flatten channels to signals
[Signals, Labels] = PrepareData(Signals, Labels);

% Generate entropy feature data
if(~recalculate_entropies)
    % Load pre-calculated entropy data
    load(pwd + "/Data/Matlab/ApproxEn.mat");
    load(pwd + "/Data/Matlab/SampEn.mat");
    load(pwd + "/Data/Matlab/ReyEn.mat");
else
    % Calculate entropy
    ApproximateEntropy = cellfun(@(x) CalculateApproximateEntropy(x, 2, 5), SignalsIn, 'UniformOutput', false);
    SampleEntropy = cellfun(@(x) CalculateSampleEntropy(x, 2, 0.2), SignalsIn, 'UniformOutput', false);
    ReyniEntropy = cellfun(@(x) CalculateReyniEntropy(x, 0.75), SignalsIn, 'UniformOutput', false);
    
    % Save entropy data
    save(pwd + "/Data/Matlab/ApproxEn.mat", "ApproximateEntropy");
    save(pwd + "/Data/Matlab/SampEn.mat", "SampleEntropy");
    save(pwd + "/Data/Matlab/ReyEn.mat", "ReyniEntropy");
end

% Convert entropy cell arrays to matrix
ApproximateEntropy = cell2mat(ApproximateEntropy);
SampleEntropy = cell2mat(SampleEntropy);
ReyniEntropy = cell2mat(ReyniEntropy);

% Create data table of entropies and labels
Data = table(ApproximateEntropy, SampleEntropy, ReyniEntropy, Labels);

% Divide into training and test sets
[train_index,~,test_index] = dividerand(size(Data,1), 0.8, 0.0, 0.2);
trainData = Data(train_index,:);
testData = Data(test_index,:);

% Perform classification of signals using entropies
Results = ClassifyUsingEntropies(trainData, testData);
disp('Completed, displaying results:');
Results %#ok<NOPTS>

