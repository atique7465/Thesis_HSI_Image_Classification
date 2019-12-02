% Just applying the LDA on Original_Data_80_20
clear all;
clc;

load Original_Data_80_20;

Original_trainData_80 = double(Original_trainData_80);
Original_testData_20 = double(Original_testData_20);

[mappedLDA mappingLDA] = lda(Original_trainData_80, Original_trainClass_80, 8);

numValidfeatures = sum(mappingLDA.val>0);
[n,p] = size(Original_testData_20);
testDataCenter = Original_testData_20 - repmat(mean(Original_trainData_80,1),n,1);
validfeatures = mappingLDA.M(:,1:numValidfeatures);

testDataOnPc = testDataCenter * validfeatures;
trainDataOnPc = mappedLDA(:,1:numValidfeatures);

LDA_trainData = trainDataOnPc;
LDA_testData = testDataOnPc;
LDA_trainClass = class_of_selected_classes(trainIdx_80,:);
LDA_testClass = class_of_selected_classes(testIdx_20,:);

save LDA_on_OData_80_20.mat LDA_trainData LDA_testData LDA_trainClass LDA_testClass
save Pc_data_LDA.mat testDataOnPc trainDataOnPc mappedLDA mappingLDA
