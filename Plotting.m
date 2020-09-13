close all;
fig = figure; 

eeg1 = subplot(4,1,1); plot(S{1,1});
ylim([600,1000])

eeg2 = subplot(4,1,2); plot(S{1,2});
ylim([600,1000])

eeg3 = subplot(4,1,3); plot(S{1,3});
ylim([600,1000]) 

eeg4 = subplot(4,1,4); plot(S{1,4});
ylim([600,1000])

han=axes(fig, 'visible', 'off');
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
title(han, 'Normal condition EEG signal');
ylabel(han, "Voltage Reading (\muVolts)");
xlabel(han, "Samples");

% remove horizontal ticks
set(eeg1, 'XTick', []);
set(eeg2, 'XTick', []);
set(eeg3, 'XTick', []);
set(eeg4, 'XTick', []);

% change vertical axes ticks
set(eeg1, 'YTick', [650, 750, 850, 950]);
set(eeg2, 'YTick', [650, 750, 850, 950]);
set(eeg3, 'YTick', [650, 750, 850, 950]);
set(eeg4, 'YTick', [650, 750, 850, 950]);
set(eeg1, 'TickLength', [0.005 0]);
set(eeg2, 'TickLength', [0 0]);
set(eeg3, 'TickLength', [0 0]);
set(eeg4, 'TickLength', [0 0]);

% reposition plots for tighter coupling
set(eeg1, 'position', [0.1 0.72 0.85 0.20]);
set(eeg2, 'position', [0.1 0.51 0.85 0.20]);
set(eeg3, 'position', [0.1 0.30 0.85 0.20]);
set(eeg4, 'position', [0.1 0.09 0.85 0.20]);

han.Title.Position = [ 0.5 1.02 0.5 ];
han.YLabel.Position = [ -0.11 0.5 0 ];
han.XLabel.Position = [ .5 -0.07 0 ];

annotation('textbox', [0.88 0.82 0.1 0.1], 'String', 'CH1', 'EdgeColor', 'none');
annotation('textbox', [0.88 0.61 0.1 0.1], 'String', 'CH2', 'EdgeColor', 'none');
annotation('textbox', [0.88 0.4 0.1 0.1], 'String', 'CH3', 'EdgeColor', 'none');
annotation('textbox', [0.88 0.19 0.1 0.1], 'String', 'CH4', 'EdgeColor', 'none');

eeg4.XTick = [10000, 20000, 30000, 40000, 50000 60000 70000 80000 90000]
% 
% 
% vars = {'CH1', 'CH2', 'CH3', 'CH4'};
% 
% CH1 = S{1,1}';
% CH2 = S{1,2}';
% CH3 = S{1,3}';
% CH4 = S{1,4}';
% 
% tb1 = table(CH1, CH2, CH3, CH4);
% 
% sp = stackedplot(tb1, 'Title', 'EEG Signal - Normal Condition')
% sp.AxesProperties(1).YLimits = [600 1000];
% sp.AxesProperties(2).YLimits = [600 1000];
% sp.AxesProperties(3).YLimits = [600 1000];
% sp.AxesProperties(4).YLimits = [600 1000];
% 
% sp.DisplayLabels = {"","","",""};
% sp.XLabel = "Samples (10,000's)";
% %Results = table('Size', [length(classifiers_desc), length(varNames)], ...
%         %'VariableTypes', varTypes, 'VariableNames', varNames);