load uber-data-final
data=table2array(uber5);%change dataset and kmean here
k=5;

result= zeros(4,k);

[n, p] = size(data);
sample = data(randperm(n, k)',:);


uber1_result=countArea(uber5,sample,k,1);
result(1,:)=uber1_result;
uber2_result=countArea(uber7,sample,k,2);
result(2,:)=uber2_result;
uber3_result=countArea(uber8,sample,k,3);
result(3,:)=uber3_result;
uber4_result=countArea(uber9,sample,k,4);
result(4,:)=uber4_result;

reignItIn(result,k);


%uber5_result=countArea(uber8,sample);
%result(5,:)=uber5_result;
%uber6_result=countArea(uber9,sample);
%result(6,:)=uber6_result;
