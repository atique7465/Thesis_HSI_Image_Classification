clear all;
clc;

bestC = 2;
bestSigma = 1; 
load Data_F_5_8

uniqueClass = unique(trainClass_F_5_8);
actualC = 2^bestC;
actualSigma = 2^bestSigma;

tic
for i=1:size(uniqueClass,1)
    groups = ismember(trainClass_F_5_8, uniqueClass(i));   
    warning('off', 'stats:obsolete:ReplaceThisWith');
    opts = svmsmoset('MaxIter',500000,'KernelCacheLimit',30000);
    svmStructRbf(i) = svmtrain(trainData_F_5_8,groups,'Method','SMO','SMO_Opts',opts,'Kernel_Function','rbf','BoxConstraint', actualC,'RBF_Sigma',actualSigma);
end
toc

save svmStructRbf.mat  svmStructRbf;
