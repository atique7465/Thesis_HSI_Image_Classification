%normalize the data set to [-1,1]

function [b,norm_const]=normalize_max(a,nc)
[n dim]=size(a);
if nargin<2 nc=max(abs(a));end;
for i=1:dim
    a(:,i)=(a(:,i))/nc(i);
end
b=a;
norm_const=nc;