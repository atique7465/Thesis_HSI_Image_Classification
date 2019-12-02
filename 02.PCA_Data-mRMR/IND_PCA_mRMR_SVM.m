clear all;
clc;

load TrainTestSplit_work_02
load IND_work_05_mRMR_Rank
load PCA_DATA_IND

strCell = cell(4000, 1);
sci = 1;

IND_PCA_MRMR_SVM2=[];
classList=[1,2,3,4,5,6,7,8,9];
% pc=[21,10,40,60,80,100,120,140,160,180,200,220]
pc=[25,30,35]
%PCA+SVM start
starttime = tic    
for j = 1:12
    pcCounter = pc(1, j);
    pcCounter
    data = IND_trainDataOnPc(:, mRMRfeatures(1:pcCounter));
    class = trainClass;
    validationData = IND_testDataOnPc(:, mRMRfeatures(1:pcCounter));
    validationClass = testClass;

    for c=0:8
        for sigma=0:8
        tic
        predictionClass = ones(size(validationClass))*classList(1);
        score = zeros(size(validationClass));

        for i = 1:size(classList, 2)
            index = ismember(class, classList(i));
            dd = data;
            cc = class;
            cc(index) = 1;
            cc(~index) = 0;

            index = ismember(validationClass, classList(i));
            ttestClass = validationClass;
            ttestClass(index) = 1;
            ttestClass(~index) = 0;
            
            warning('off', 'stats:obsolete:ReplaceThisWith');
            opts=svmsmoset('MaxIter',500000,'KernelCacheLimit',30000);
            svmstruct=svmtrain(dd,cc,'Method','SMO','SMO_Opts',opts,'Kernel_Function','rbf','BoxConstraint', 2^c,'RBF_Sigma',2^sigma);
            %svmstruct = fitcsvm(dd, cc,'KernelFunction', 'RBF', 'Cost', [0, penaltyOne; penaltyZero,0], 'KernelScale', 2^sigma);
            [yo,predictionscore] = svmclassifyfvalue(svmstruct, validationData);

            predictionscore = predictionscore*(-1);

            if (i == 1)
            score = predictionscore;           
            else
                for i1=1:size(validationClass,1)
                    if (predictionscore(i1,1)>score(i1,1))
                        score(i1,1)=predictionscore(i1,1);
                        predictionClass(i1)=classList(i);
                    end
                end               
            end
        end

        cp = classperf(validationClass, predictionClass);
        toc
        result = sprintf('feature = %d  C = %f, Sigma = %f, Acc = %f\n', pcCounter, c, sigma, cp.CorrectRate)
        tmp = [pcCounter c sigma cp.CorrectRate];
        IND_PCA_MRMR_SVM2 = [IND_PCA_MRMR_SVM2; tmp];
        
        strCell{sci} = result;
        sci = sci+1;

        filePh = fopen('CV_PCA_IFS.txt','w');
        fprintf(filePh,'%s\n',strCell{:});
        fclose(filePh);
        end
    end
end
toc
%PCA+SVM end

save IND_PCA_MRMR_SVM2.mat IND_PCA_MRMR_SVM2
csvwrite('IND_PCA_MRMR_SVM2.csv',IND_PCA_MRMR_SVM2);
[~,idx] = sort(IND_PCA_MRMR_SVM2(:,4),'descend');
Sorted_IND_PCA_mRMR_SVM2 = IND_PCA_MRMR_SVM2(idx,:);
save Sorted_IND_PCA_mRMR_SVM2.mat Sorted_IND_PCA_mRMR_SVM2
csvwrite('Sorted_IND_PCA_mRMR_SVM2.csv',Sorted_IND_PCA_mRMR_SVM2);
% load Result
% M = max(Result(:,3));
% [M I] = max(Result(:,3));
