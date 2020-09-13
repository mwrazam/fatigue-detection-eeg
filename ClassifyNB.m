% This function takes training data and corresponding labels and trains
% a Naive Bayes Classifier
%
%   Input
%   **********************
%       @predictors: N x D training data values with D dimensions
%       @responses: N x 1 corresponding ground truth labels
%       @optimize: flag whether to perform full optimization
%
%   Output
%   **********************
%       @NB_Classifier: Trained classifier
%
function NB_Classifier = ClassifyNB(predictors, responses, optimize)

    disp('Training Naive Bayes Classifier...');

    if(~optimize)
        % Use experimentally determined parameters to train new classifier
        NB_Classifier = fitcnb(predictors,responses,...
            'ClassNames', unique(responses), ...
            'Prior', [0.4762, 0.5238], ...
            'DistributionNames', 'kernel', ...
            'Kernel', 'normal', ...
            'Support', 'unbounded', ...
            'Width', 2.9420e-05);
    else
        % Train and optimize new classifier
        NB_Classifier = fitcnb(predictors,responses,...
            'ClassNames', unique(responses), 'OptimizeHyperparameters','auto',...
            'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
            'expected-improvement-plus'));
    end
    
    close all;
    
end