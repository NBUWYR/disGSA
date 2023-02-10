% Information
% Authors: Anjing Guo, Yirui Wang, Lijun Guo, Rong Zhang, Yang Yu, Shangce Gao
% Cited Paper: An adaptive position-guided gravitational search algorithm for function optimization 
% and image threshold segmentation, Engineering Applications of Artificial Intelligence.
%

function [Fbest,BestChart]=GSA(fhd,N,D,max_it,ElitistCheck,min_flag,Rpower,P_index)

Rnorm=2; 
down = -100;up = 100;

X=initialization(D,N,up,down); 
BestChart=[];

V=zeros(N,D);
FES=0;iteration=1;
dis=zeros(N,2);
dis=[dis [1:N]'];

while FES<D*10000

    X=space_bound(X,up,down); 
 
    fitness=feval(fhd,X',P_index);
    
    if min_flag==1
    [best, best_X]=min(fitness); 
    [worst,worst_X]=max(fitness);
    else
    [best, best_X]=max(fitness);
    [worst,worst_X]=min(fitness);
    end        
    
    if iteration==1
       Fbest=best;Lbest=X(best_X,:);
    end
    if min_flag==1
      if best<Fbest 
       Fbest=best;Lbest=X(best_X,:);
      end
    else 
      if best>Fbest  
       Fbest=best;Lbest=X(best_X,:);
      end
    end
    
    for i=1:N
        best_dis=norm(X(i,:)-Lbest,Rnorm);
        worst_dis=norm(X(i,:)-X(worst_X,:),Rnorm);
        dis(i,1)=best_dis/(worst_dis+eps);
    end

    dis_sort=sortrows(dis,1);

    dis_sum=0;
    for i=2:N-1
        dis_sum=dis_sum+dis_sort(i,1);
    end

    diskbestnow2=dis_sort(N-1,1)/dis_sum;
    
	
BestChart=[BestChart; Fbest];

[M]=massCalculation(fitness,min_flag); 

G=Gconstant(iteration,max_it); 

[a1,a2]=Gfield(M,X,G,Rnorm,Rpower,ElitistCheck,iteration,max_it,dis_sort,diskbestnow2);

[X,V]=move(X,a1,a2,V,iteration,max_it,dis_sort);
 
FES=FES+N;
iteration=iteration+1;
end 

