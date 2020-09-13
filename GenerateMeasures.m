% This function takes the ground truth labels categorical array and the
% predicated categorical array and calculates a number of measures:
%
% TP = True Positive, TN = True Negative
% FP = False Positive, FN = False Negative
% 
% ACC = Accuracy
% SEN = Sensitivity
% SPF = Specificity
% PPV = Positive Predictive Value
% NPV = Negative Predictive Value
% MCC = Matthews Correlation Coefficient
%
%   Input
%   **********************
%       @true_labels: N x 1 Categorical array of ground truth labels
%       @predicted_labels: N x 1 Categorical array of predicted labels
%
%   Output
%   **********************
%       @SEN, @SPF, @ACC, @PPV, @NPV, @MCC: Calculated measures
%
function measures = GenerateMeasures(true_labels, predicted_labels)

    if(length(true_labels) ~= length(predicted_labels))
        % The arrays are not of the same length
        error('Error. \n Inputs must be categorical arrays of same length');
    end
    
    % Concatenate into N x 2 array for comparisons
    res = [true_labels, predicted_labels];
    
    % Calculate true and false for positive and negative predictions
    TP = length(find(res(:,1)=="Fatigue" & res(:,2)=="Fatigue"));
    TN = length(find(res(:,1)=="Normal" & res(:,2)=="Normal"));
    FP = length(find(res(:,1)=="Normal" & res(:,2)=="Fatigue"));
    FN = length(find(res(:,1)=="Fatigue" & res(:,2)=="Normal"));
    
    % Calculate measures
    ACC = ((TP + TN) / (TP + TN + FP + FN)) * 100;
    SEN = (TP / (TP + FN)) * 100;
    SPF = (TN / (TN + FP)) * 100;
    PPV = (TP / (TP + FP)) * 100;
    NPV = (TN / (TN + FN)) * 100;
    T1 = (abs((TP + FN)*(TP + FP))) ^ 0.5;
    T2 = (abs((TN + FN)*(TN + FP))) ^ 0.5;    
    MCC = ((TP * TN) - (FN * FP)) / (T1 * T2);
    
    % Concatenate measures into output array
    measures = [ACC, SEN, SPF, PPV, NPV, MCC];

end



