% This function performs loading of data. If the dataset has been loaded
% before and it already exists in a Matlab matrix, simply load that.
%
% Folder structure should be in the following format
%  
% /Raw
%   /2018
%       /Fatigue
%       /Normal
%   /2019
%       /Fatigue
%       /Normal
% /Matlab
%   Signals.mat
%   Labels.mat
%
% Input
% **********************
%   @raw_path: String file path to the raw data directory
%   @save_path: String file path to output directory
%   @sets: 1D array of dataset folder names to load
%
% Output
% **********************
%   @signals: N x C where N is the number of signal sets, and C is the
%       number of channels, each channel is returned as a cell array of
%       signal values
%   @labels: N x 1 label values that correspond to each of the signal
%       sets

function [signals, labels] = LoadData(raw_path, save_path, sets, reload)

    signals_fname = "Signals.mat"; % file name to save signals data as
    labels_fname = "Labels.mat"; % file name to save labels data as
    
    normal_fname = "Normal"; % folder name where normal data is
    fatigued_fname = "Fatigue"; % folder name where fatigued data is
    
    normal_cat = "Normal"; % categorical name to apply to normal data
    fatigued_cat = "Fatigue"; % categorical name to apply to fatigued data
    
    f_type = ".csv"; % file type to load
    
    channels = 4; % number of EEG channels recorded
    
    apply_preprocessing = "false";
    
    if (~exist(save_path, 'dir') || ~isfile(save_path + "/" + signals_fname) || ~isfile(save_path + "/" + labels_fname) || reload == true)
        % data hasn't been loaded before, or reload has been requested
        if (exist(save_path,'dir'))
            rmdir(save_path, 's');
        end
        mkdir(save_path);
        
        signals = {}; % holder for all signal data
        labels = {}; % holder for all ground truth labels
        
        for d=1:length(sets)
            % load all files
            normal_files = dir(raw_path + "\" + sets(d) + "\" + normal_fname + "\*" + f_type);
            fatigued_files = dir(raw_path + "\" + sets(d) + "\" + fatigued_fname + "\*" + f_type);
            
            s1 = {1:length(normal_files),1:channels};
            s2 = {1:length(fatigued_files),1:channels};
            l1(1:length(normal_files),1) = "";
            l2(1:length(fatigued_files),1) = "";
            
            % load all normal files
            disp("Loading " + length(normal_files) + " files (normal condition) from " + raw_path + "/" + sets(d));
            for i=1:length(normal_files)
                try
                    T = readtable(normal_files(i).folder + "/" + normal_files(i).name);
                    s1{i, 1} = transpose(T.EEG1);
                    s1{i, 2} = transpose(T.EEG2);
                    s1{i, 3} = transpose(T.EEG3);
                    s1{i, 4} = transpose(T.EEG4);
                    l1(i, 1) = normal_cat;
                catch
                    fprintf('Unable to load file: ');
                    fprintf(normal_files(i).name);
                    fprintf('\n');
                end
                
            end
            
            % load all fatigued files
            disp("Loading " + length(normal_files) + " files (fatigue condition) from " + raw_path + "/" + sets(d));
            for i=1:length(fatigued_files)
                try
                    T = readtable(fatigued_files(i).folder + "/" + fatigued_files(i).name);
                    s2{i, 1} = transpose(T.EEG1);
                    s2{i, 2} = transpose(T.EEG2);
                    s2{i, 3} = transpose(T.EEG3);
                    s2{i, 4} = transpose(T.EEG4);
                    l2(i, 1) = fatigued_cat;
                catch
                    fprintf('Unable to load file: ');
                    fprintf(normal_files(i).name);
                    fprintf('\n');
                end
                
            end
            
            % concatenate onto main data arrays
            signals = [signals; s1; s2];
            labels = [labels; l1; l2];
            
        end
        
        disp('Cleaning data...');
        
        % fix conversion errror in one of the signal channels
        signals{85,1} = str2double(signals{85,1}); 
        
        % fix any NaN values in the dataset
        for i=1:size(signals, 1)
            for j=1:size(signals, 2)
                s = signals{i,j};
                s(isnan(s))=0;
                signals{i,j} = s;
            end
        end

        % convert to categorical array for training models
        labels = categorical(labels);
        
        % apply preprocessing to signals if requested
        if(apply_preprocessing)
            signals = cellfun(@PreprocessData, Signals, 'UniformOutput', false);
        end
        
        disp(length(signals) + " signals successfully loaded and saved to " + save_path + "/" + signals_fname);
        disp("Labels saved to " + save_path + "/" + labels_fname);
        
        % save data output
        save(save_path + "/" + signals_fname, "signals");
        save(save_path + "/" + labels_fname, "labels");

    else
        % data already exists, return it
        disp("Loading existing data from " + save_path);
        s = load(save_path + "/" + signals_fname);
        l = load(save_path + "/" + labels_fname);
        signals = s.signals;
        labels = l.labels;
    end

end

