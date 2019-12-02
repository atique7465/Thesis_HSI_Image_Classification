
function [outputClassName] = predictTestClass(svmStruct, dataTest, uniqueClass) 


for i=1:size(uniqueClass,1)         
    [class(:,i), fvalue(:,i)] =svmclassifyfvalue(svmStruct(i), dataTest);
end

outputClassName=zeros(size(dataTest,1),1);

for j=1:size(dataTest,1)
    min=fvalue(j,1);
    position=1;
    for i=2:size(uniqueClass, 1)                
        if( min>fvalue(j,i))
            min=fvalue(j,i);
            position=i;
        end
    end            
    outputClassName(j)=position;
end

