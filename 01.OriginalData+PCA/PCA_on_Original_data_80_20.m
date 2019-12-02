%% Just applying the PCA on Original_Data_80_20
clear all;
clc;

load Original_Data_80_20;

Original_trainData_80 = double(Original_trainData_80);
Original_testData_20 = double(Original_testData_20);

[mappedPCA mappingPCA] = pca(Original_trainData_80,220);

numValidPc = sum(mappingPCA.lambda>0);
[n,p] = size(Original_testData_20);
testDataCenter = Original_testData_20 - repmat(mappingPCA.mean,n,1);
validPc = mappingPCA.M(:,1:numValidPc);

testDataOnPc = testDataCenter*validPc;
trainDataOnPc = mappedPCA(:,1:numValidPc);

save Pc_data_PCA.mat testDataOnPc trainDataOnPc mappedPCA mappingPCA

%%


%% Checking the cumulative sum of variance of features.
clear all;
clc;

load Pc_data_PCA

var_cumsum_pca = zeros(220,1);
var = 0;
sum_var = sum(mappingPCA.lambda);
for i = 1 : 220
    var=var + mappingPCA.lambda(i,1);
    var_cumsum_pca(i,1)=var;
    var_cumsum_pca(i,1)=(var_cumsum_pca(i,1)*100)/sum_var;
end
save var_cumsum_pca.mat var_cumsum_pca
csvwrite('var_cumsum_pca.csv',var_cumsum_pca);

%%


%% Trancate the PCA data according to the cumulative sum of variance
clear all;
clc;

load Pc_data_PCA
load Original_Data_80_20;

PCA_trainData = trainDataOnPc(:,1:21);
PCA_testData = testDataOnPc(:,1:21);
PCA_trainClass = class_of_selected_classes(trainIdx_80,:);
PCA_testClass = class_of_selected_classes(testIdx_20,:);

save PCA_on_OData_80_20.mat PCA_trainData PCA_testData PCA_trainClass PCA_testClass

%%