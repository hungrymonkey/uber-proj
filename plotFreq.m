function plotFreq(min)
xData = min;
timeMap = containers.Map('KeyType','int64', 'ValueType','int64');
for i = 1:size(xData)
    if isKey(timeMap, xData(i)) == 0
        timeMap(xData(i)) = 1;
    else
        timeMap(xData(i)) = timeMap(xData(i)) + 1;
    end
end
figure;
y = cell2mat(values(timeMap));
x = cell2mat(keys(timeMap));
plot(x, y, '.')
end