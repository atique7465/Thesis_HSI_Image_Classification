%% mRMR on PCA_trainData
clear all;
clc;

tic

load PCA_on_OData_80_20

Data = PCA_trainData;

norData = normalize_max(Data); %normalize the data to the [-1,1] range
discritizedNormalizedData = myQuantileDiscretize(norData,10); %discretize the data to 5 equal-frequency bins

mRMR_Rank_PCA_train = mrmr_mid_d(discritizedNormalizedData, PCA_trainClass, size(norData,2));

save mRMR_Rank_PCA_train.mat mRMR_Rank_PCA_train
%csvwrite('mRMR_Rank_PCA_train.csv',mRMR_Rank_PCA_train);

toc
%%

%% mRMR on PCA_testData
clear all;
clc;

tic

load PCA_on_OData_80_20

Data = PCA_testData;

norData = normalize_max(Data); %normalize the data to the [-1,1] range
discritizedNormalizedData = myQuantileDiscretize(norData,10); %discretize the data to 5 equal-frequency bins

mRMR_Rank_PCA_test = mrmr_mid_d(discritizedNormalizedData, PCA_testClass, size(norData,2));

save mRMR_Rank_PCA_test.mat mRMR_Rank_PCA_test
%csvwrite('mRMR_Rank_PCA_test.csv', mRMR_Rank_PCA_test);

toc
%%