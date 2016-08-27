%load uber-data-final
function [output,closestMean,meanLocs,nIters] = countArea(uberData,sample,p,subplotNum)
k=p;
data=table2array(uberData);
maxIters=9999;


[closestMean, meanLocs, nIters ]=clusterKMeans(data, k, maxIters,sample,subplotNum);


for i=1:k
    output(i)=sum(closestMean(:)==i);
end

