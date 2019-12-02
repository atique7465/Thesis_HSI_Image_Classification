
function [overallAccuracy, accuracyPerClass] = performanceMeasure(predictedClass, actualClass)

numOfUniqueClass = size(unique(actualClass), 1);
accuracyTable = zeros(numOfUniqueClass, numOfUniqueClass);

for i = 1:size(actualClass, 1)
   accuracyTable(actualClass(i), predictedClass(i)) = accuracyTable(actualClass(i), predictedClass(i)) + 1;
end

accuracyPerClass = zeros(numOfUniqueClass, 1);
total = 0.0;
diagonalTotal = 0.0;

for i = 1:numOfUniqueClass
   accuracyPerClass(i) = accuracyTable(i, i) / sum(double(accuracyTable(i, :)));
   total = total + sum(double(accuracyTable(i, :)));
   diagonalTotal = diagonalTotal + accuracyTable(i, i);
end

overallAccuracy = diagonalTotal / total;

end
