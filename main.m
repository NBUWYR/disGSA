% Information
% Authors: Anjing Guo, Yirui Wang, Lijun Guo, Rong Zhang, Yang Yu, Shangce Gao
% Cited Paper: An adaptive position-guided gravitational search algorithm for function optimization 
% and image threshold segmentation, Engineering Applications of Artificial Intelligence.
%
clear all;clc
warning off


N=100;
D=30;
max_it=D*10000/N;
ElitistCheck=1; Rpower=1;
min_flag=1; 
Statistic = [];



for problem = [1]
    
    P_index = problem;
    fhd = str2func('cec17_func');
    FbestChart=[];    
    for t=1:1
        [Fbest,BestChart]=GSA(fhd,N,D,max_it,ElitistCheck,min_flag,Rpower,P_index);
        FbestChart=[FbestChart,BestChart];         
        ['problem',num2str(problem),'-run',num2str(t)]
    end
    
    
    Mean=mean(FbestChart(max_it,:),2);
    Std =std(FbestChart(max_it,:),0,2);
    Y = FbestChart(max_it,:) - problem*100;  
    ErrorMean=mean(Y,2);
    ErrorStd =std(Y,0,2);
    Statistic = [Statistic;[FbestChart(max_it,:),Mean,Std,ErrorMean,ErrorStd]];
    FbestChart=[FbestChart,mean(FbestChart,2)];

    
    xlswrite(['disGSA_GSA_CEC2017_D',num2str(D),'.xlsx'],FbestChart,['CEC2017_F',num2str(problem)]);
   
end

    xlswrite(['disGSA_GSA_CEC2017_D',num2str(D),'.xlsx'],Statistic,'CEC2017_Statistic');
 
