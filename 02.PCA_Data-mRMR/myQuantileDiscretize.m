%Vinh Nguyen, Jeffrey Chan and James Bailey, "Reconsidering Mutual Information Based Feature Selection: A Statistical Significance View",
%Proceedings of the Twenty-Eighth AAAI Conference on Artificial Intelligence (AAAI-14), Quebec City, Canada, July 27-31 2014.
%(C) 2014 Nguyen Xuan Vinh   
%Email: vinh.nguyen@unimelb.edu.au, vinh.nguyenx@gmail.com
%Usage: discretize data by collumn, using quantile discretization (d is the number of quantiles)
function b=myQuantileDiscretize(a,d)
if nargin<2 d=3;end;

[n dim]=size(a);
b=zeros(n,dim);
for i=1:dim
   b(:,i)=doDiscretize(a(:,i),d);
end
b=b+1;

% ----------------------------------------
function y_discretized= doDiscretize(y,d)
% ----------------------------------------
% discretize a vector
ys=sort(y);
y_discretized=y;

pos=ys(round(length(y)/d *[1:d]));
for j=1:length(y)
    y_discretized(j)=sum(y(j)>pos);
end