function [M]=massCalculation(fit,min_flag)

Fmax=max(fit); Fmin=min(fit); Fmean=mean(fit); 
[i, N]=size(fit);

if Fmax==Fmin
   M=ones(N,1);
else
    
   if min_flag==1 
      best=Fmin;worst=Fmax; 
   else 
      best=Fmax;worst=Fmin; 
   end
  
   M=(fit-worst)./(best-worst); 

end

M=M./sum(M); 