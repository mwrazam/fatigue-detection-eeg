% This function takes training data and corresponding labels and trains
% a Best First Decision Tree classifier
%
%   Input
%   **********************
%       @predictors: N x D training data values with D dimensions
%       @responses: N x 1 corresponding ground truth labels
%       @optimize: flag whether to perform full optimization
%
%   Output
%   **********************
%       @BFDT_Classifier: Trained classifier
%
function BFDT_Classifier = ClassifyBFDT(predictors, responses, optimize)

    disp('Training Decision Tree Classifier...');
    
    if(~optimize)
        % Use experimentally determined parameters to train new classifier
        BFDT_Classifier = fitctree(...
            predictors, ...
            responses, ...
            'SplitCriterion', 'gdi', ...
            'MaxNumSplits', 117, ...
            'Surrogate', 'off', ...
            'ClassNames', unique(responses));
    else
        % Train and optimize new classifier
        BFDT_Classifier = fitctree(predictors,responses,...
            'ClassNames', unique(responses), 'OptimizeHyperparameters','auto',...
            'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
            'expected-improvement-plus'));
    end

    close all;

end

