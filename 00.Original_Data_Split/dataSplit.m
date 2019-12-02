% Here we selected 9 class and trancated the data. finally splitted into 80% train & 20% of test data_class.

clear all;
clc;

load twoD
load classGT

Data = twoD;
Class = classGT;

dataIndex = ismember(Class,[2,3,5,6,8,10,11,12,14]);

data_of_selected_Classes = Data(dataIndex,:);
class_of_selected_classes = Class(dataIndex,:);

classIndexOne = ismember(class_of_selected_classes,2);
classIndexTwo = ismember(class_of_selected_classes,3);
classIndexThree = ismember(class_of_selected_classes,5);
classIndexFour = ismember(class_of_selected_classes,6);
classIndexFive = ismember(class_of_selected_classes,8);
classIndexSix = ismember(class_of_selected_classes,10);
classIndexSeven = ismember(class_of_selected_classes,11);
classIndexEight = ismember(class_of_selected_classes,12);
classIndexNine = ismember(class_of_selected_classes,14);


class_of_selected_classes(classIndexOne) = 1;
class_of_selected_classes(classIndexTwo) = 2;
class_of_selected_classes(classIndexThree) = 3;
class_of_selected_classes(classIndexFour) = 4;
class_of_selected_classes(classIndexFive) = 5;
class_of_selected_classes(classIndexSix) = 6;
class_of_selected_classes(classIndexSeven) = 7;
class_of_selected_classes(classIndexEight) = 8;
class_of_selected_classes(classIndexNine) = 9;

[trainIdx_80, testIdx_20] = crossvalind('holdout',class_of_selected_classes,0.20);

Original_trainData_80 = data_of_selected_Classes(trainIdx_80,:);
Original_testData_20 = data_of_selected_Classes(testIdx_20,:);
Original_trainClass_80 = class_of_selected_classes(trainIdx_80);
Original_testClass_20 = class_of_selected_classes(testIdx_20);

save Original_Data_80_20.mat trainIdx_80 testIdx_20 Original_trainData_80 Original_testData_20 Original_trainClass_80 Original_testClass_20 class_of_selected_classes data_of_selected_Classes

