%% applying svm on cross validation 60_40 data to determine c & sigma
clear all;
clc;

starttime = tic
load CV_Data_F_60_40
F_21_8_Result = [];

cMinValue = 0; 
cMaxValue = 8;
sigmaMinValue = 0;
sigmaMaxValue = 8;

uniqueClass = unique(CV_trainClass_60_F_21_8);

numOfMetric = 4;
dimC = cMaxValue - cMinValue + 1;
dimSigma = sigmaMaxValue - sigmaMinValue + 1;
performanceInfo = zeros(dimC, dimSigma, numOfMetric);

for cVal = cMinValue : 1 : cMaxValue
   actualC = 2^cVal;
   
   for sigmaVal = sigmaMinValue : 1 : sigmaMaxValue
      actualSigma = 2^sigmaVal;
      
      tic
      for i=1:size(uniqueClass,1)
          groups = ismember(CV_trainClass_60_F_21_8, uniqueClass(i));
          warning('off', 'stats:obsolete:ReplaceThisWith');
          opts=svmsmoset('MaxIter',500000,'KernelCacheLimit',30000);
          svmStruct(i) = svmtrain(CV_trainData_60_F_21_8,groups,'Method','SMO','SMO_Opts',opts,'Kernel_Function','rbf','BoxConstraint', actualC,'RBF_Sigma',actualSigma);
      end
      
      prediction = predictTestClass(svmStruct, CV_testData_40_F_21_8, uniqueClass);
    
      [overallAccuracy, accuracyPerClass] = performanceMeasure(prediction, CV_testClass_40_F_21_8);
      
      toc
      sprintf('C = %f, Sigma = %f, Ove_Acc = %f', cVal, sigmaVal, overallAccuracy)
      accuracyPerClass
      tmp = [cVal sigmaVal overallAccuracy];
      F_21_8_Result = [F_21_8_Result; tmp];
   end
end

endtime = toc(starttime)
save F_21_8_Result.mat F_21_8_Result
sprintf('The Code run has finished :XD')
%%


%% manupulate the result to get best c & sigma
clear all;
clc;

load F_21_8_Result
[~,idx] = sort(F_21_8_Result(:,3),'descend');
sorted_F_21_8_Result = F_21_8_Result(idx,:);
save sorted_F_21_8_Result.mat sorted_F_21_8_Result

%%