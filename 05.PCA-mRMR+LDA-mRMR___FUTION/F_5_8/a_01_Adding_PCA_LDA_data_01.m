clear all;
clc;

load PCA_on_OData_80_20;
load mRMR_Rank_PCA_train;
load LDA_on_OData_80_20;
load mRMR_Rank_LDA_train;

trainData_F_5_8 = [PCA_trainData(:, mRMR_Rank_PCA_train(1:5)) LDA_trainData(:, mRMR_Rank_LDA_train(1:8))];
trainClass_F_5_8 = PCA_trainClass;
testData_F_5_8 = [PCA_testData(:, mRMR_Rank_PCA_train(1:5)) LDA_testData(:, mRMR_Rank_LDA_train(1:8))];
testClass_F_5_8 = PCA_testClass;

save Data_F_5_8.mat trainData_F_5_8 testData_F_5_8 trainClass_F_5_8 testClass_F_5_8;

