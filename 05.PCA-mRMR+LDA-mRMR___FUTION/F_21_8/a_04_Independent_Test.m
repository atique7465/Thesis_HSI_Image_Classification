clear all;
clc;

starttime = tic
load Data_F_21_8
F_IND_21_8_Result = [];

cMinValue = 2.5; 
cMaxValue = 3.5;
sigmaMinValue = 1.5;
sigmaMaxValue = 2.5;

uniqueClass = unique(trainClass_F_21_8); % train class

numOfMetric = 4;
dimC = cMaxValue - cMinValue + 1;
dimSigma = sigmaMaxValue - sigmaMinValue + 1;
performanceInfo = zeros(dimC, dimSigma, numOfMetric);

for cVal = cMinValue : 0.10 : cMaxValue
   actualC = 2^cVal;
   
   for sigmaVal = sigmaMinValue : 0.25 : sigmaMaxValue
      actualSigma = 2^sigmaVal;
      
      tic
      for i=1:size(uniqueClass,1)
          groups = ismember(trainClass_F_21_8, uniqueClass(i)); %train class
          warning('off', 'stats:obsolete:ReplaceThisWith');
          opts=svmsmoset('MaxIter',500000,'KernelCacheLimit',30000); %train data in below
          svmStruct(i) = svmtrain(trainData_F_21_8,groups,'Method','SMO','SMO_Opts',opts,'Kernel_Function','rbf','BoxConstraint', actualC,'RBF_Sigma',actualSigma);
      end
      
      prediction = predictTestClass(svmStruct, testData_F_21_8, uniqueClass); %test data
    
      [overallAccuracy, accuracyPerClass] = performanceMeasure(prediction, testClass_F_21_8); %test class
      
      toc
      sprintf('C = %f, Sigma = %f, Ove_Acc = %f', cVal, sigmaVal, overallAccuracy)
      accuracyPerClass
      tmp = [cVal sigmaVal overallAccuracy];
      F_IND_21_8_Result = [F_IND_21_8_Result; tmp];
   end
end

endtime = toc(starttime)
save F_IND_21_8_Result.mat F_IND_21_8_Result
[~,idx] = sort(F_IND_21_8_Result(:,3),'descend');
sorted_IND_F_21_8_Result = F_IND_21_8_Result(idx,:);
save sorted_IND_F_21_8_Result.mat sorted_IND_F_21_8_Result
sprintf('The Code run has finished :XD')
