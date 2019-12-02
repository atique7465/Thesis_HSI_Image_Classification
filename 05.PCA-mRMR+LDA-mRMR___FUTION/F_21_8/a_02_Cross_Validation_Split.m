clear all;
clc;

load Data_F_21_8;

tic
[train test] = crossvalind('holdout', trainClass_F_21_8, 0.40);

CV_trainData_60_F_21_8 = trainData_F_21_8(train,:);
CV_trainClass_60_F_21_8 = trainClass_F_21_8(train,:);
CV_testData_40_F_21_8 = trainData_F_21_8(test,:);
CV_testClass_40_F_21_8 = trainClass_F_21_8(test,:);

toc

save CV_Data_F_60_40.mat CV_trainData_60_F_21_8 CV_trainClass_60_F_21_8 CV_testData_40_F_21_8 CV_testClass_40_F_21_8 train test
