%__________________________________________________________________________
%
% Description:
%
% Digital Signal Processing - Mini Project 2 STFT/SVM analysis.
%
% Runs experiment 3a.
%
% Instructions - some code missing. Search for "XXX" and edit code.
%
% **********************************
% * This code requires libSVM 3.23 *
% **********************************
%
% Inputs: Reads the file "DSP_MP2_microDoppler_Data.mat" which must
% be in the same directory as this code.
%
% Outputs: Graphs, outputs to screen.
%
% Change History:
%
% 30 September 2020 - Original
%
% Authors:
% John Ball
%__________________________________________________________________________
%
clc
clear varaibles
close all
addpath('D:\MSU\Fall 2020\DSP\mini-project-2\MP2_Student\libsvm-3.23')
%
% Flags
% Set noramlize_data to 1 to normalize data before giving to SVM
%
normalize_data = 1;
%
% LibSVM training string
%
%libsvm_train_str = '-s 0 -t 0 -c 10 -e 0.00001 -q';
libsvm_train_str = '-s 0 -t 2 -c 10 -e 0.00001 -q';
%
% Load the datafile in
%
% X - matrix of features, one per data instance
% Y - vector of class labels
% RV - vector of relative velocities
%
load('DSP_MP2_microDoppler_Data.mat');
%
% Print statistics
%
Ninstances = length(Y);
the_classes = unique(Y);
Nclasses = length(the_classes);
Nfeatures = size(X,1);
fprintf('Number of instances: %d.\n', Ninstances);
fprintf('Number of features per instance: %d.\n', Nfeatures);
fprintf('Number of classes: %d.\n', Nclasses);
for y = the_classes
fprintf(' Class %2d: instances %d.\n', y, sum(Y == y));
end
%
% Plot instances for each class
%
RV_min = min(RV) * 0.9;
RV_max = max(RV) * 1.1;
num_bins = 20;
RV_bins = linspace(RV_min, RV_max, num_bins);
colorcode = {'r', 'b-.', 'm:', 'k--'};
figure;
hold on;
yindx = 1;
for y = the_classes
indx = find(Y == y);
rv_class_y = RV(indx);
hist_class_y = hist(rv_class_y, RV_bins);
h = plot(RV_bins, hist_class_y, colorcode{yindx});
set(h, 'LineWidth', 1.5);
legendstr{yindx} = sprintf('Class=%d', y);
yindx = yindx + 1;
end
xlabel('Relative Velocity');
ylabel('Number instances');
legend(legendstr, 'location', 'NorthWest');
title('Histograms of each class versus relative velocity');
drawnow;
%
% Split data into training and testing
%
percent_train = 60;
fprintf('\nSplitting into training and test, with %.2f %% training.\n', percent_train);
Xtrain = [];
Xtest = [];
Ytrain = [];
Ytest = [];
RVtrain = [];
RVtest = [];
for y = the_classes
indx = find(Y == y);
% Generate random indices and split into training and testing
rand_y = randperm(length(indx));
last_train_indx = floor(length(rand_y)*percent_train/100);
train_indx = 1 : last_train_indx;
test_indx = (last_train_indx+1) : length(rand_y);
Xtrain = [Xtrain, X(:, indx(train_indx))];
Ytrain = [Ytrain, Y(indx(train_indx))];
RVtrain = [RVtrain, RV(indx(train_indx))];
Xtest = [Xtest, X(:, indx(test_indx))];
Ytest = [Ytest, Y(indx(test_indx))];
RVtest = [RVtest, RV(indx(test_indx))];
end
%
% Transpose everything to input to libSVM
%
Xtrain = Xtrain';
Ytrain = Ytrain';
RVtrain = RVtrain';
Xtest = Xtest';
Ytest = Ytest';
RVtest = RVtest';
%
% Normalize features to [-1,1]
%
if normalize_data == 1
%
% Normalize each feature to [-1, 1]
%
for k = 1 : Nfeatures
temp = Xtrain(:,k);
maxtemp = max(temp);
mintemp = min(temp);
Xtrain(:,k) = 2 * ((temp - mintemp) / (maxtemp - mintemp)) - 1;
temp = Xtest(:,k);
Xtest(:,k) = 2 * ((temp - mintemp) / (maxtemp - mintemp)) - 1;
end
end
%
% Plot features
%
fcolorstr = {'ro', 'bo', 'mo', 'ko', 'rx', 'bx'};
fcolorstr2 = {'r', 'b', 'm', 'k', 'r', 'b'};
for n = 1:Nfeatures
Xtrain_feature = Xtrain(:,n);
figure;
subplot(2,1,1);
hold on;
nindx = 1;
for y = the_classes
indx = find(Ytrain == y);
h = plot(indx, Xtrain_feature(indx), fcolorstr{nindx});
set(h,'MarkerFaceColor',fcolorstr2{nindx});
set(h,'MarkerSize',2.0);
nindx = nindx+1;
end
title(sprintf('Train Feature %d', n));
Xtest_feature = Xtest(:,n);
subplot (2,1,2);
hold on;
nindx = 1;
for y = the_classes
indx = find(Ytest == y);
h = plot(indx, Xtest_feature(indx), fcolorstr{nindx});
set(h,'MarkerFaceColor',fcolorstr2{nindx});
set(h,'MarkerSize',2.0);
nindx = nindx+1;
end
title(sprintf('Test Feature %d', n));
end
%
% Run the SVM feature by feature
%
fprintf('\n');
train_n_oa = zeros(1, Nfeatures); % Store overall accuracy
test_n_oa = zeros(1, Nfeatures); % Store overall accuracy
for n = 1:Nfeatures
fprintf('\nRunning SVM for feature %d.\n', n);
Xtrain_feature = Xtrain(:,n);
Xtest_feature = Xtest(:,n);
% Train
svm_model = svmtrain(Ytrain, sparse(Xtrain_feature), libsvm_train_str);
%
% Get results on training and testing set, and plot the discriminant function
%
train_pred = svmpredict(Ytrain, sparse(Xtrain_feature), svm_model, '-q');
fprintf("\nTraining confusion matrix and stats (only feature %d):\n", n);
[~, train_oa, ~, ~, ~, ~] = confusion_matrix(train_pred, Ytrain, 1, 1);
test_pred = svmpredict(Ytest, sparse(Xtest_feature), svm_model, '-q');
fprintf("\nTesting confusion matrix and stats (only feature %d:\n", n);
[~, test_oa, ~, ~, ~, ~] = confusion_matrix(test_pred, Ytest, 1, 1);
% Save results
train_n_oa(n) = train_oa;
test_n_oa(n) = test_oa;
tick_labels{n} = sprintf('%d', n);
end
%
% Run SVM on all features
%
fprintf('\nRunning SVM for all features.\n');
% Train
svm_model = svmtrain(Ytrain, sparse(Xtrain), libsvm_train_str);
%
% Get results on training and testing set, and plot the discriminant function
%
train_pred = svmpredict(Ytrain, sparse(Xtrain), svm_model, '-q');
fprintf("\nTraining confusion matrix and stats (all features):\n");
[train_cm, train_oa, train_tp, train_fp, train_tn, train_fn] = confusion_matrix(train_pred, Ytrain, 1, 1);
test_pred = svmpredict(Ytest, sparse(Xtest), svm_model, '-q');
fprintf("\nTesting confusion matrix and stats (all features):\n");
[test_cm, test_oa, test_tp, test_fp, test_tn, test_fn] = confusion_matrix(test_pred, Ytest, 1, 1);
train_n_oa(end+1) = train_oa;
test_n_oa(end+1) = test_oa;
tick_labels{end+1} = 'All';
%
% Plot results
%
figure;
bar(1:(Nfeatures+1), [train_n_oa' * 100, test_n_oa' * 100]);
ax = axis;
axis([ax(1:2), 0 105.0]);
xlabel('Feature number');
ylabel('Accuracy (percent)');
h = gca;
set(h,'XTickLabel', tick_labels);
grid on;
legend('Train','Test','location','EastOutside');
title('SVM Results');
drawnow;