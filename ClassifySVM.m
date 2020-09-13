% This function takes training data and corresponding labels and trains
% a Support Vector Machine classifier
%
%   Input
%   **********************
%       @predictors: N x D training data values with D dimensions
%       @responses: N x 1 corresponding ground truth labels
%       @optimize: flag whether to perform full optimization
%
%   Output
%   **********************
%       @SVM_Classifier: Trained classifier
%
function SVM_Classifier = ClassifySVM(predictors, responses, optimize)

    disp('Training Support Vector Machine Classifier...');
    
    if(~optimize)
        % Use experimentally determined parameters to train new classifier
        SVM_Classifier = fitcsvm(...
            predictors, ...
            responses, ...
            'KernelFunction', 'gaussian', ...
            'PolynomialOrder', [], ...
            'KernelScale', 0.001158638667005909, ...
            'BoxConstraint', 321.378044603313, ...
            'Standardize', true, ...
            'ClassNames', unique(responses));
    else
        % Train and optimize new classifier
        % NOTE: This process will take more than 20 minutes for the full
        % dataset
        SVM_Classifier = fitcsvm(predictors,responses,...
            'ClassNames', unique(responses), 'OptimizeHyperparameters','auto',...
            'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
            'expected-improvement-plus'));
    end

    close all;

end

