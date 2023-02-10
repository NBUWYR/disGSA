function [a1,a2]=Gfield(M,X,G,Rnorm,Rpower,ElitistCheck,iteration,max_it,dis_sort,diskbestnow2)

 [N,dim]=size(X);
 final_per=2; 

 if ElitistCheck==1
     kbest=exp(-900.*diskbestnow2.*iteration./max_it);
     kbest=round(N*kbest);
 else
     kbest=N; 
 end


 if kbest<final_per
     kbest=final_per;
 end

 [Ms, ds]=sort(M,'descend');
 if size(ds)== 1
     ds=ones(N,1);
 end
 E = zeros(N,dim);
 E2=zeros(N,dim);


 for i=1:N  
     for ii=1:kbest
         j=ds(ii);
         if j~=i
            R=norm(X(i,:)-X(j,:),Rnorm); 
            E(i,:)=E(i,:)+rand(1,dim).*(M(j)).*((X(j,:)-X(i,:))./(R^Rpower+eps));     
          end
     end

   
     for ii2=1:kbest
         j2=dis_sort(ii2,3);
         if j2~=ii2
             R2=norm(X(i,:)-X(j2,:),Rnorm);
             E2(i,:)=E2(i,:)+rand(1,dim).*(M(j2)).*((X(j2,:)-X(i,:))./(R2^Rpower+eps));
         end
     end

 end


a1=E.*G; 
a2=E2.*G;


