function [X,V]=move(X,a1,a2,V,iteration,max_it,dis_sort)

[N,dim]=size(X);

c1=8./(1+exp((iteration-max_it./2)./200));

c2=8-c1;

best=dis_sort(1,3);
worst=dis_sort(N,3);
V(worst,:)=V(best,:);
X(worst,:)=X(best,:);

for i=1:N
    if i~=worst
        V(i,:)=rand(1,dim).*V(i,:)+c1*a1(i,:)+c2*a2(i,:); 
        X(i,:)=X(i,:)+V(i,:);
    end
end


