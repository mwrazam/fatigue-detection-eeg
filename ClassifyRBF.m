% This function takes training data and corresponding labels and trains
% a Radial Basis Function Network
%
%   Input
%   **********************
%       @predictors: N x D training data values with D dimensions
%       @responses: N x 1 corresponding ground truth labels
%
%   Output
%   **********************
%       @RBF_Classifier: Trained classifier
%
function RBF_Classifier = ClassifyRBF(predictors, responses)

    disp('Training Radial Basis Network Classifier...');
    
    % Transform labels to binary responses
    Y = zeros(length(responses), 1);
    Y(responses=="Normal") = 0;
    Y(responses=="Fatigue") = 1;
    
    % Train RBF network
    RBF_Classifier = newrb(predictors', Y', 0.065);

end

