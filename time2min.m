function[min] = time2min(timeData)
len = length(timeData);
min = zeros(len,1);
for i = 1:len
    min(i,1) = hour(timeData{i}) * 60 + minute(timeData{i});
end
%{
xData = min;
timeMap = containers.Map;
for i = 1:size(xData)
    if isKey(timeMap, xData(i)) == 0
        timeMap(xData(i)) = 1.0;
    else
        timeMap(xData(i)) = timeMap(xData(i)) + 1.0;
    end
end

figure;
y = cell2mat(values(timeMap));

plot(keys(timeMap), y)
%}
end