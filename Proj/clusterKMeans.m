function [closestMean, meanLocs, nIters ] = clusterKMeans( data, k, maxIters,sample,subplotNum)
%CLUSTERKMEANS Runs kmeans algorithm.
%   [CLOSESTMEAN, MEANLOCS, NITERS ] = CLUSTERKMEANS( DATA, K, MAXITERS )
%   runs the k-means algorithm with K centers on DATA. DATA is an N by P
%   matrix where N rows are the number of datapoints and P columns is the
%   number of attributes. The algorithm runs until convergence or the max
%   number of iterations. CLOSESTMEAN is a vector of length N with labels
%   for each datapoint. MEANLOCS is a K by P matrix with the locations of
%   mean K in row K as labeled in the CLOSESTMEAN vector. NITERS is the
%   number of iterations the algorithm ran.
%
%   Shell and Comments Written by Jake Olson
%   Program written by: huajun zhang
%   Last modified August 6 2015


% Initialize means randomly among points
[n, p] = size(data);
meanLocs = sample;

closestMean = zeros(n, 1);
nIters = 0;

% Iterate through a max number of times
for t = 1:maxIters
    numItems = zeros(k, 1);
    % Find the distance to each mean
    for i = 1:n
        curRow = data(i, :);
        minDist = norm(curRow - meanLocs(1, :));
        closestCluster = 1;
        for j = 2:k
            tempDist = norm(curRow - meanLocs(j, :));
            if tempDist < minDist
                minDist = tempDist;
                closestCluster = j;
            end
        end

        % Label it to be with the closest mean
        closestMean(i, 1) = closestCluster;
        numItems(closestCluster, 1) = numItems(closestCluster, 1) + 1;
    end
    
    % Create new means
    newMeans = zeros(k, p);
    for i = 1:n
        j = closestMean(i, 1);
        newMeans(j, :) = newMeans(j, :) + data(i, :);
    end
    
    for i = 1:k
        newMeans(i, :) = newMeans(i, :) / numItems(i, 1);
    end

    % Check if means do not move!
    if isequal(newMeans, meanLocs)
        % Quit if means do not move! Woooohoooo!
        break;
    else
        % If they do not move, do it all again!
        meanLocs = newMeans;
        nIters = nIters + 1;
    end
end

%Plot output as a bunch of points with different colors for each cluster.
figure(20);
subplot(2,2,subplotNum);
if p == 2    
     hold on;
     for i = 1:k
         plot(data(closestMean(:,1) == i,1), data(closestMean(:,1) == ...
             i,2), '*', 'Color', rand(1, 3));
     end
 end
% Prepare output.

end

