function plotFreqPeakHour( minuteData )
close all

% Peak hour -> 3pm to 6pm (900 to 1080 in minutes)

% First find the ranges that split the data into each day. Whenever there
% is a drop in value e.g. 1400, 1401, 1402, 1, 2, etc. we know it's a new day
range = zeros(1,1)
prev = 0;
curr = 0;
range(1) = 1;
for i = 1:size(minuteData,1)
    prev = curr;
    curr = minuteData(i);
    if curr < prev
        range = [range;i]
    end
end

% Go through the range to count the total pickups during the peak hour
% each day. 50k dataset -> around 33 days
count = zeros(size(range,1),1)
numRanges = size(range,1)
for i = 1:numRanges-1
    for k = range(i):range(i+1)
        if minuteData(k) > 900 && minuteData(k) < 1080
            count(i+1) = count(i+1) + 1;
        end
    end    
end

plot([1:1:size(count,1)],count,'-')

end

