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
%       @Results: M x 6 table of classification results, where M is the 
%       number of classifiers, and each has 6 evaluation measures:
%       SEN, SPF, ACC, PPV, NPV, MCC
%
function Results = ClassifyUsingEntropies(TrainData, TestData)

    % Select whether to perform full optimization on every classifier
    % NOTE: FULL OPTIMIZATION WILL TAKE MORE THAN 30 MINUTES ON FULL
    % DATASET
    optimize = false;

    % Select which classifiers to use and create results table
    classifiers = ["NB", "RBF", "KNN", "SVM", "BFDT"];
    classifiers_desc = ["Naive Bayes", "Radial Basis Function", "K-Nearest Neighbour", ...
        "Support Vector Machine", "Best First Decision Tree"];
    varNames = ["Classifier", "ACC", "SEN", "SPF", "PPV", "NPV", "MCC"];
    varTypes = {'string', 'double', 'double', 'double', 'double', 'double', 'double'};
    Results = table('Size', [length(classifiers_desc), length(varNames)], ...
        'VariableTypes', varTypes, 'VariableNames', varNames);
    
    % Seperate training data into predictors and responses
    X_Train = TrainData{:,1:3}; % predictors
    Y_Train = TrainData{:,4}; % responses
    
    % Seperate test data into predictors and responses
    X_Test = TestData{:,1:3}; % predictors
    Y_Test = TestData{:,4}; % responses
    
    % *****************************************************
    % Create and evaluate performance of NB classifier
    % *****************************************************
    if(find(classifiers=="NB"))
        % Create trained model
        NBC = ClassifyNB(X_Train,Y_Train, optimize);
        
        % Predict on novel test data
        predicted_labels = predict(NBC, X_Test);
        
        % Generate performance metrics for test data
        m = GenerateMeasures(Y_Test, categorical(predicted_labels));
        
        % Store results
        idx = find(classifiers=="NB");
        Results(idx,:) = {classifiers_desc(idx), m(1), m(2), m(3), m(4), m(5), m(6)};
    end
    
    % *****************************************************
    % Create and evaluate performance of RBF classifier
    % *****************************************************
    if(find(classifiers=="RBF"))
        % Create trained network
        RBF = ClassifyRBF(X_Train, Y_Train);
        
        % Predict on novel test data
        Y = sim(RBF, X_Test');
        Y = round(Y);
        Y = abs(Y);
        Y(Y>1) = 1;
        predicted_labels(Y==0) = "Normal";
        predicted_labels(Y==1) = "Fatigue";
        
        % Generate performance metrics for test data
        m = GenerateMeasures(Y_Test, categorical(predicted_labels));
        
        % Store results
        idx = find(classifiers=="RBF");
        Results(idx,:) = {classifiers_desc(idx), m(1), m(2), m(3), m(4), m(5), m(6)};
        
    end
    
    % *****************************************************
    % Create and evaluate performance of KNN classifier
    % *****************************************************
    if(find(classifiers=="KNN"))
        % Create trained model
        KNN = ClassifyKNN(X_Train, Y_Train, optimize);
        
        % Predict on novel test data
        predicted_labels = predict(KNN, X_Test);
        
        % Generate Performance metrics for test data
        m = GenerateMeasures(Y_Test, categorical(predicted_labels));
        
        % Store results
        idx = find(classifiers=="KNN");
        Results(idx,:) = {classifiers_desc(idx), m(1), m(2), m(3), m(4), m(5), m(6)};
        
    end
    
    % *****************************************************
    % Create and evaluate performance of SVM classifier
    % *****************************************************
    if(find(classifiers=="SVM"))
        % Create trained model
        SVM = ClassifySVM(X_Train, Y_Train, optimize);
        
        % Predict on novel test data
        predicted_labels = predict(SVM, X_Test);
        
        % Generate performance metrics for test data
        m = GenerateMeasures(Y_Test, categorical(predicted_labels));
        
        % Store results
        idx = find(classifiers=="SVM");
        Results(idx,:) = {classifiers_desc(idx), m(1), m(2), m(3), m(4), m(5), m(6)};
        
    end
    
    % *****************************************************
    % Create and evaluate performance of BFDT classifier
    % *****************************************************
    if(find(classifiers=="BFDT"))
        % Create trained model
        BFDT = ClassifyBFDT(X_Train, Y_Train, optimize);
        
         % Predict on novel test data
        predicted_labels = predict(BFDT, X_Test);
        
        % Generate performance metrics for test data
        m = GenerateMeasures(Y_Test, categorical(predicted_labels));
        
        % Store results
        idx = find(classifiers=="BFDT");
        Results(idx,:) = {classifiers_desc(idx), m(1), m(2), m(3), m(4), m(5), m(6)};
        
    end

end

