% This function takes training data and corresponding labels and trains
% a K-Nearest Neighbour classifier
%
%   Input
%   **********************
%       @predictors: N x D training data values with D dimensions
%       @responses: N x 1 corresponding ground truth labels
%       @optimize: flag whether to perform full optimization
%
%   Output
%   **********************
%       @KNN_Classifier: Trained classifier
%
function KNN_Classifier = ClassifyKNN(predictors, responses, optimize)

    disp('Training K-Nearest Neighbor Classifier...');
    
    if(~optimize)
        % Use experimentally determined parameters to train new classifier
        KNN_Classifier = fitcknn(predictors,responses,...
            'ClassNames', unique(responses),... 
            'Distance', 'Euclidean',... 
            'Exponent', [],... 
            'NumNeighbors', 36,... 
            'DistanceWeight', 'SquaredInverse', ...
            'Standardize', true);
    else
        % Train and optimize new classifier
        KNN_Classifier = fitcknn(predictors,responses,...
            'ClassNames', unique(responses), 'OptimizeHyperparameters','auto',...
            'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
            'expected-improvement-plus'));
    end
    
    close all;

end

