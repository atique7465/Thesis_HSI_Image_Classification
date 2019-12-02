%% mRMR on PCA_trainData
clear all;
clc;

tic

load LDA_on_OData_80_20

Data = LDA_trainData;

norData = normalize_max(Data); %normalize the data to the [-1,1] range
discritizedNormalizedData = myQuantileDiscretize(norData,10); %discretize the data to 5 equal-frequency bins

mRMR_Rank_LDA_train = mrmr_mid_d(discritizedNormalizedData, LDA_trainClass, size(norData,2));

save mRMR_Rank_LDA_train.mat mRMR_Rank_LDA_train
%csvwrite('mRMR_Rank_LDA_train.csv', mRMR_Rank_LDA_train);

toc
%%

%% mRMR on PCA_testData
clear all;
clc;

tic

load LDA_on_OData_80_20

Data = LDA_testData;

norData = normalize_max(Data); %normalize the data to the [-1,1] range
discritizedNormalizedData = myQuantileDiscretize(norData,10); %discretize the data to 5 equal-frequency bins

mRMR_Rank_LDA_test = mrmr_mid_d(discritizedNormalizedData, LDA_testClass, size(norData,2));

save mRMR_Rank_LDA_test.mat mRMR_Rank_LDA_test
%csvwrite('mRMR_Rank_LDA_test.csv', mRMR_Rank_LDA_test);

toc
%%