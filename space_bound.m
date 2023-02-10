function  X=space_bound(X,up,down)

[N,dim]=size(X);
for i=1:N 

    Tp=X(i,:)>up;Tm=X(i,:)<down;X(i,:)=(X(i,:).*(~(Tp+Tm)))+((rand(1,dim).*(up-down)+down).*(Tp+Tm));

end
